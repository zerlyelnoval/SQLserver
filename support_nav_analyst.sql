DROP TABLE IF EXISTS #tmp_LLD
DROP TABLE IF EXISTS #tmp_TT
DROP TABLE IF EXISTS #tmp_AVAIL
DROP TABLE IF EXISTS #act_alarm
DROP TABLE IF EXISTS #history_alarm
DROP TABLE IF EXISTS #hourLessThanTreshold
--======================================LIST SITE======================================================
declare @datetime datetime
declare @datedata datetime
declare @startdate datetime

set @datetime = '2023-07-15 00:00:00' --> SET TIME
set @datedata = (select max(PERIOD_START_TIME) from [dbo].[MEAS_4G_AVAIL_H])
set @startdate = cast(dateadd(day,-1,@datedata) as date)

SELECT*
INTO #tmp_LLD
FROM
	[00_LIST_OAM]
WHERE
	[Tower Index] in ('JAW-JT-PML-1434','JAW-JT-PWR-1621','JAW-JT-PWT-0595','JAW-JT-PBG-1280','JAW-JT-CLP-0440','JAW-JT-PML-1390','JAW-JT-DMK-0603','JAW-JT-PTI-1469','JAW-JT-BBS-0023','JAW-YO-WNO-0455','JAW-JT-CLP-0538','JAW-JT-KJN-1008','JAW-JT-CLP-0488','JAW-JT-TMG-2679','JAW-JT-TMG-2676','JAW-JT-PWR-3500','JAW-JT-KRG-2136','JAW-JT-SKT-2068','JAW-JT-BNR-3513','JAW-JT-CLP-3653','JAW-JT-CLP-4002','JAW-JT-BTG-3903','JAW-YO-WNO-0701','JAW-JT-KLN-4005','JAW-JT-PTI-3650','JAW-JT-KJN-4039','JAW-JT-KLN-3664','JAW-YO-BTL-3003')


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>AGG AVAIL 4G<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	drop table if exists #agg4g

	SELECT
		a.PERIOD_START_TIME,
		format(CAST(a.PERIOD_START_TIME AS date), 'yyMMdd') + '-' + FORMAT(CAST(a.PERIOD_START_TIME AS time),'hh')[hour],
		a.RC,
		a.mrbtsId,
		a.[Tower Index],
		a.Kabupate [KABUPATEN],
		a.mrbts_name [Site Name],
		'https://'+a.ip_oam [ip_oam],
		iif(SUM(Radio_Network_Avail_Den)=0,0,ROUND(100*(SUM(Radio_Network_Avail_Num)/SUM(Radio_Network_Avail_Den)),2))[AVAIL_%]
	INTO #tmp_AVAIL
	FROM
		(select PERIOD_START_TIME,[Tower Index],mrbts_name, Kabupate, RC,mrbtsId, ip_oam, format_ws_4g[ws] from #tmp_LLD cross join (select distinct PERIOD_START_TIME from MEAS_4G_AVAIL_H)b)a
			left join MEAS_4G_AVAIL_H b on (a.mrbtsId = b.mrbtsId and a.PERIOD_START_TIME=b.PERIOD_START_TIME)
	WHERE
		a.PERIOD_START_TIME >= @datetime
	GROUP BY
		a.PERIOD_START_TIME,
		a.RC,
		a.Kabupate,
		a.mrbtsId,
		a.ip_oam,
		a.mrbts_name,
		a.[Tower Index]

	update #tmp_AVAIL
	set [AVAIL_%] = 0
	where [AVAIL_%] is null;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#hour<99<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

select
	A.mrbtsId,
	STRING_AGG(convert(nvarchar(max),FORMAT(A.PERIOD_START_TIME, 'ddMMM [HH] ')),'; ') within group(order by A.PERIOD_START_TIME) [#hour<99]
into #hourLessThanTreshold
from
	#tmp_AVAIL A
where
	(cast(A.PERIOD_START_TIME as date) >= @datetime) and (A.[AVAIL_%] < 99)
group by
	A.mrbtsId;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ALARM ACTIVE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
SELECT 
	B.mrbts_id,
	STRING_AGG('#'+B.active_alarm,'&char(10)&') [active alarm]
into #act_alarm
FROM (
	select
		a.mrbts_id,
		'['+ case a.Severity
				when 'Critical' then 'C'
				when 'Major' then 'M'
				when 'Minor' then 'm'
				when 'Warning' then 'W'
				else a.Severity
			 end + '] ' +
		case
			when a.[Supplementary Information] = '' then a.[Alarm Text]
			when patindex('%milliseconds timeout on connection%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%http-outgoing%',a.[Supplementary Information])-1) 
			when patindex('%java.net.ConnectException%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%URL%',a.[Supplementary Information])-3)
			when patindex('%RSSI difference between main and diversity paths exceed the threshold%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%paths%',a.[Supplementary Information])-2)
			when patindex('%provision operation has failed.%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%.%',a.[Supplementary Information]))
			when patindex('%smirp.ne.CommunicationTimeout%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
			when patindex('%The server sent HTTP status code 503%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
			when patindex('%HTTP transport error:%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
			else a.[Supplementary Information]
		end + ' | [Alarm Time]: ' + format(a.[Alarm Time],'ddMMM HH:mm') [active_alarm]
		--'="-'+STRING_AGG(a.[Alarm Type]+' | '+a.Severity+' | '+a.[Probable Cause]+' | '+a.[Supplementary Information],'"&char (10)&"-')+'"' [active alarm]
	from
		[dbo].[CHECK_ActiveAlarm] a
	where
		obj_name1='MRBTS'
	group by
		a.mrbts_id,
		a.[Supplementary Information],
		a.[Alarm Text],
		a.Severity,
		a.[Alarm Time]
)B
GROUP BY
	B.mrbts_id

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ALARM HISTORY<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SELECT 
	B.mrbts_id,
	--'='+STRING_AGG('"-'+B.[hist_alarm_h-1_to_now]+'|aging: '+B.aging+'"','&char(10)&') [hist_alarm_h-1_to_now]
		STRING_AGG('('+cast(B.nomor as nvarchar(max))+') '+B.[hist_alarm_h-1_to_now],'&char(10)&') [hist_alarm_h-1_to_now],
		STRING_AGG(CONVERT(nvarchar(max),'('+cast(B.nomor as nvarchar(max))+') '+B.aging),'&char(10)&')[aging]
		--''[aging]
INTO #history_alarm
FROM (
SELECT
	A.mrbts_id,
	A.[hist_alarm_h-1_to_now],
	STRING_AGG(FORMAT(A.date,'ddMMM')+' ['+A.hour+'] '+CAST(A.h as nvarchar(max))+'h'+CAST(A.m as nvarchar(max))+'m','; ') within group (ORDER BY A.date, A.hour)[aging],
	ROW_NUMBER()over(partition by A.mrbts_id order by A.[hist_alarm_h-1_to_now])[nomor]
FROM(
			select
				CAST(a.[Alarm Time] as date)[date],
				format(CAST(a.[Alarm Time] as time),'hh')[hour],
				a.mrbts_id,
				'['+ case a.Severity
						when 'Critical' then 'C'
						when 'Major' then 'M'
						when 'Minor' then 'm'
						when 'Warning' then 'W'
						else a.Severity
					 end + '] ' +
				case
					when a.[Supplementary Information] = '' then a.[Alarm Text]
					when patindex('%milliseconds timeout on connection%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],	PATINDEX('%http-outgoing%',a.[Supplementary Information])-1)
					when patindex('%java.net.ConnectException%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],	PATINDEX('%URL%',a.[Supplementary Information])-3)
					when patindex('%RSSI difference between main and diversity paths exceed the threshold%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],	PATINDEX('%paths%',a.[Supplementary Information])-2)
					when patindex('%provision operation has failed.%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%.%',a.[Supplementary Information]))
					when patindex('%smirp.ne.CommunicationTimeout%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
					when patindex('%The server sent HTTP status code 503%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
					when patindex('%HTTP transport error:%',a.[Supplementary Information])>0 then left(a.[Supplementary Information],PATINDEX('%:%',a.[Supplementary Information])-1)
					else a.[Supplementary Information]
				end [hist_alarm_h-1_to_now],
				max(datediff(minute,a.[Alarm Time],a.[Cancel Time]))/60 [h],
				max(datediff(minute,a.[Alarm Time],a.[Cancel Time]))%60 [m]
			from
				[dbo].[CHECK_AlarmHistory]a inner join [dbo].[00_LIST_OAM] b on (a.mrbts_id = b.mrbtsId)
			
			where
				obj_name1='MRBTS'
			group by
				CAST(a.[Alarm Time] as date),
				format(CAST(a.[Alarm Time] as time),'hh'),		
				a.mrbts_id,
				a.[Supplementary Information],
				a.Severity,
				a.[Alarm Text])A
	group by
		A.mrbts_id,
		A.[hist_alarm_h-1_to_now]
)B
GROUP BY
	B.mrbts_id


--=========================================PIVOT TIME============================================
declare
@col nvarchar(max)='',
@sql nvarchar(max)='';

SELECT
	@col+=QUOTENAME(a.hour)+','
FROM
	(select distinct hour from #tmp_AVAIL) a
WHERE a.hour is not null
ORDER BY
	a.hour

SET @col = LEFT(@col,LEN(@col)-1);

set @sql = '
			select [Tower Index],[RC],ip_oam,b.[active alarm],c.[hist_alarm_h-1_to_now][hist_alarm_day(-1)_to_now],c.[aging],d.[#hour<99][#hour<99],'+@col+'
				from (select a.hour, a.[RC], a.[Tower Index], a.KABUPATEN, a.mrbtsId, a.[Site Name], a.ip_oam, a.[AVAIL_%] from #tmp_AVAIL a) t
				pivot(
					MAX([AVAIL_%])
					for [hour] in ('+@col+')) as pvt
				LEFT JOIN #act_alarm b ON (pvt.mrbtsId = b.mrbts_id)
				LEFT JOIN #history_alarm c ON (pvt.mrbtsId = c.mrbts_id)
				LEFT JOIN #hourLessThanTreshold d ON (pvt.mrbtsId = d.mrbtsId)
			 ORDER BY
				RC,KABUPATEN,[Tower Index];
			';

/*
		a.PERIOD_START_TIME,
		format(CAST(a.PERIOD_START_TIME AS date), 'yyMMdd') + '-' + FORMAT(CAST(a.PERIOD_START_TIME AS time),'hh')[hour],
		b.RC,
		a.mrbtsId,
		b.[Tower Index],
		b.Kabupate [KABUPATEN],
		a.[MRBTS name] [Site Name],
		'https://'+b.ip_oam [ip_oam],
		ROUND(100*(SUM(Radio_Network_Avail_Num)/nullif(SUM(Radio_Network_Avail_Den),0)),2)[AVAIL_%]
*/


execute sp_executesql @sql;


DROP TABLE IF EXISTS #hourLessThanTreshold
DROP TABLE IF EXISTS #history_alarm
DROP TABLE IF EXISTS #act_alarm
DROP TABLE IF EXISTS #tmp_AVAIL
DROP TABLE IF EXISTS #tmp_GNBCF
DROP TABLE IF EXISTS #tmp_TT
DROP TABLE IF EXISTS #tmp_LLD
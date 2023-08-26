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

set @datetime = '2023-07-31 00:00:00' --> SET TIME
set @datedata = (select max(PERIOD_START_TIME) from [dbo].[MEAS_4G_AVAIL_H])
set @startdate = cast(dateadd(day,-1,@datedata) as date)

SELECT*
INTO #tmp_LLD
FROM
	[00_LIST_OAM]
WHERE
	[Tower Index] in ('JAW-JT-BBS-0104','JAW-JT-BBS-3356','JAW-JT-BBS-0097','JAW-JT-UNR-2562','JAW-YO-WAT-0346','JAW-JT-PWD-0010','JAW-JT-PWT-1736','JAW-YO-BTL-0147','JAW-JT-BBS-4029','JAW-YO-BTL-0680','JAW-YO-SMN-5001','JAW-JT-PWD-3171','JAW-YO-BTL-3001','JAW-JT-SMG-2541','JAW-JT-JPA-4013','JAW-YO-WAT-2001','JAW-YO-WAT-0375','JAW-JT-WSB-3404','JAW-JT-TMG-4002','JAW-JT-KJN-4060','JAW-JT-KDL-3481','JAW-YO-BTL-8156','JAW-JT-MKD-4026','JAW-JT-KLN-4009','JAW-JT-JPA-4012','JAW-JT-PTI-4002','JAW-JT-CLP-0560','JAW-JT-TMG-2648','JAW-YO-SMN-0076','JAW-JT-PWT-0595','JAW-JT-BBS-0051','JAW-JT-KDL-0839','JAW-JT-KDS-0846','JAW-JT-MKD-3602','JAW-JT-BYL-4003','JAW-JT-BTG-3903','JAW-YO-WNO-0701','JAW-JT-KBM-4002','JAW-JT-KJN-4039','JAW-JT-KJN-4051','JAW-JT-PTI-4008','JAW-JT-SLW-4010')


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>AGG AVAIL 4G<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	drop table if exists #agg4g

	SELECT
		a.RC,
		a.mrbtsId,
		a.[Tower Index],
		a.Kabupate [KABUPATEN],
		a.mrbts_name [Site Name],
		'https://'+a.ip_oam [ip_oam]
	INTO #tmp_AVAIL
	FROM
		#tmp_LLD a
	GROUP BY
		a.RC,
		a.Kabupate,
		a.mrbtsId,
		a.ip_oam,
		a.mrbts_name,
		a.[Tower Index]

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


select [Tower Index],[RC],ip_oam,b.[active alarm],c.[hist_alarm_h-1_to_now][hist],c.aging
from #tmp_AVAIL a
	LEFT JOIN #act_alarm b ON (a.mrbtsId = b.mrbts_id)
	LEFT JOIN #history_alarm c ON (a.mrbtsId = c.mrbts_id)
 ORDER BY
	RC,KABUPATEN,[Tower Index];


DROP TABLE IF EXISTS #hourLessThanTreshold
DROP TABLE IF EXISTS #history_alarm
DROP TABLE IF EXISTS #act_alarm
DROP TABLE IF EXISTS #tmp_AVAIL
DROP TABLE IF EXISTS #tmp_GNBCF
DROP TABLE IF EXISTS #tmp_TT
DROP TABLE IF EXISTS #tmp_LLD
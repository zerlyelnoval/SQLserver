-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ALARM HISTORY<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SELECT
	B.[Tower Index],
	B.mrbts_id,
	--'='+STRING_AGG('"-'+B.[hist_alarm_h-1_to_now]+'|aging: '+B.aging+'"','&char(10)&') [hist_alarm_h-1_to_now]
		STRING_AGG('('+cast(B.nomor as nvarchar(max))+') '+B.[hist_alarm_h-1_to_now],'&char(10)&') [hist_alarm_h-1_to_now],
		STRING_AGG(CONVERT(nvarchar(max),'('+cast(B.nomor as nvarchar(max))+') '+B.aging),'&char(10)&')[aging]
		--''[aging]
FROM (
SELECT
	A.[Tower Index],
	A.mrbts_id,
	A.[hist_alarm_h-1_to_now],
	STRING_AGG(FORMAT(A.date,'ddMMM')+' ['+A.hour+'] '+CAST(A.h as nvarchar(max))+'h'+CAST(A.m as nvarchar(max))+'m','; ') within group (ORDER BY A.date, A.hour)[aging],
	ROW_NUMBER()over(partition by A.mrbts_id order by A.[hist_alarm_h-1_to_now])[nomor]
FROM(
			select
				CAST(a.[Alarm Time] as date)[date],
				format(CAST(a.[Alarm Time] as time),'hh')[hour],
				a.[Tower Index],
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
				a.[Tower Index],
				a.[Supplementary Information],
				a.Severity,
				a.[Alarm Text])A
	group by
		A.[Tower Index],
		A.mrbts_id,
		A.[hist_alarm_h-1_to_now]
)B
GROUP BY
	B.[Tower Index],
	B.mrbts_id

--==========================================DETAIL==================================
select B.[Tower Index],a.mrbts_name,format([Alarm Time],'dd-MMM-yy HH:mm')ALARM_TIME,format([Cancel Time],'dd-MMM-yy HH:mm')CANCEL_TIME,cast(round(datediff(MINUTE,[Alarm Time],[Cancel Time])/60,0,1) as nvarchar(max)) + ' hour ' + cast(datediff(MINUTE,[Alarm Time],[Cancel Time])%60 as nvarchar(max))+' min'[aging],Severity,[Supplementary Information],[Diagnostic Info]
from
	[dbo].[CHECK_AlarmHistory] A
		left join [dbo].[00_LIST_OAM]B on (A.mrbts_id=B.mrbtsId)
/*
where
	B.[Tower Index] in ('JAW-JT-KDL-0778')
		--and
		--FORMAT([Cancel Time],'yyyyMMdd HH') in ('20220912 09')
*/
order by
	[Tower Index],
	[Alarm Time] DESC,
	case
		when Severity = 'Critical' then 1
		when Severity = 'Major' then 2
		when Severity = 'Minor' then 3
		else 4
	end,
	[Supplementary Information]
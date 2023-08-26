SELECT 
	C.[Tower Index],
	C.mrbts_name,
	B.mrbts_id,
	STRING_AGG('#'+B.active_alarm,'&char(10)&') [active alarm]
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
	LEFT JOIN [dbo].[00_LIST_OAM] C on (B.mrbts_id = C.mrbtsId)
GROUP BY
	C.[Tower Index],
	C.mrbts_name,
	B.mrbts_id

--==================================detail=========================================
select A.[Tower Index],a.mrbts_name,FORMAT([Alarm Time],'dd-MMM-yy HH:mm')[Alarm Time],Severity,[Cancel Time],[Supplementary Information],[Diagnostic Info]
from
	[dbo].[CHECK_ActiveAlarm] A
		left join [dbo].[00_LIST_OAM]B on (A.mrbts_id=B.mrbtsId)
/*
where
	A.[Tower Index] in ('JAW-JT-SLW-3258')
		--and [Alarm Time] between '20220912 10:00:00' and '20220912 11:59:59'
*/
order by
	[Alarm Time] DESC,
	case
		when Severity = 'Critical' then 1
		when Severity = 'Major' then 2
		when Severity = 'Minor' then 3
		else 4
	end
	,[Supplementary Information]
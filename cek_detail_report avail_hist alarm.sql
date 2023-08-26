select B.[Tower Index],a.mrbts_name,format([Alarm Time],'dd-MMM-yy HH:mm')ALARM_TIME,format([Cancel Time],'dd-MMM-yy HH:mm')CANCEL_TIME,cast(round(datediff(MINUTE,[Alarm Time],[Cancel Time])/60,0,1) as nvarchar(max)) + ' hour ' + cast(datediff(MINUTE,[Alarm Time],[Cancel Time])%60 as nvarchar(max))+' min'[aging],Severity,[Supplementary Information],[Diagnostic Info]
from
	[dbo].[CHECK_AlarmHistory] A
		left join [dbo].[00_LIST_OAM]B on (A.mrbts_id=B.mrbtsId)

where
	B.[Tower Index] in ('JAW-JT-TMG-4002')
		--and
		--FORMAT([Cancel Time],'yyyyMMdd HH') in ('20220912 09')

order by
	mrbts_id,
	[Alarm Time] DESC,
	case
		when Severity = 'Critical' then 1
		when Severity = 'Major' then 2
		when Severity = 'Minor' then 3
		else 4
	end,
	[Supplementary Information]
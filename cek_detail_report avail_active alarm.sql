select A.[Tower Index],a.mrbts_name,FORMAT([Alarm Time],'dd-MMM-yy HH:mm')[Alarm Time],Severity,[Cancel Time],[Supplementary Information],[Diagnostic Info]
from
	[dbo].[CHECK_ActiveAlarm] A
		left join [dbo].[00_LIST_OAM]B on (A.mrbts_id=B.mrbtsId)

where
	A.[Tower Index] in ('JAW-JT-KRG-2181','JAW-JT-RBG-1808','JAW-JT-SKT-2047','JAW-JT-JPA-0712','JAW-JT-RBG-1774','JAW-JT-JPA-8200','JAW-JT-BYL-3001','JAW-JT-BYL-4003','JAW-YO-BTL-0681','JAW-JT-SKT-2141','JAW-YO-WNO-0449','JAW-JT-KDL-0856','JAW-JT-KDL-0792','JAW-YO-WNO-0641','JAW-YO-WNO-0617','JAW-YO-WNO-0608','JAW-YO-WNO-0475','JAW-YO-WNO-0470','JAW-YO-BTL-0053','JAW-JT-MKD-3602','JAW-JT-DMK-0569','JAW-JT-DMK-0619','JAW-JT-KDS-3501','JAW-JT-PWD-0037','JAW-JT-PWD-0042','JAW-JT-SKT-2048','JAW-JT-SMG-0542','JAW-JT-SMG-0613','JAW-JT-SMG-2328','JAW-JT-SMG-2453','JAW-JT-SMG-2466','JAW-JT-SMG-2481','JAW-JT-SKH-1904','JAW-JT-SKH-2012','JAW-JT-SKH-2019','JAW-JT-KDL-0857','JAW-JT-MKD-1118','JAW-JT-SKH-1905','JAW-JT-PTI-1424')
		--and [Alarm Time] between '20220912 10:00:00' and '20220912 11:59:59'

order by
	mrbts_id,
	[Alarm Time] DESC,
	case
		when Severity = 'Critical' then 1
		when Severity = 'Major' then 2
		when Severity = 'Minor' then 3
		else 4
	end
	,[Supplementary Information]
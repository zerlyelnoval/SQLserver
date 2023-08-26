update [dbo].CHECK_ActiveAlarm
set 
	[dbo].CHECK_ActiveAlarm.[Tower Index] = b.[Tower Index],
	[dbo].CHECK_ActiveAlarm.mrbts_name = b.mrbts_name,
	[dbo].CHECK_ActiveAlarm.mrbts_id = b.mrbtsId
from
	[dbo].CHECK_ActiveAlarm
		left join [00_LIST_OAM] b on ([dbo].CHECK_ActiveAlarm.mrbtsId_bscId = b.mrbtsId)
		where [dbo].CHECK_ActiveAlarm.obj_name1 = 'MRBTS' and [dbo].CHECK_ActiveAlarm.mrbts_id is null;

update [dbo].CHECK_ActiveAlarm
set 
	[dbo].CHECK_ActiveAlarm.mrbts_name = c.name,
	[dbo].CHECK_ActiveAlarm.mrbts_id = c.mrbtsId
from
	[dbo].CHECK_ActiveAlarm
		left join [dbo].[A_GNBCF] b on ([dbo].CHECK_ActiveAlarm.mrbtsId_bscId = b.[bscId] and [dbo].CHECK_ActiveAlarm.bcfId = b.[bcfId])
			left join [dbo].[A_MRBTS] c on (b.[mrbtsId]=c.[mrbtsId])
		where [dbo].CHECK_ActiveAlarm.obj_name1 = 'BSC' and [dbo].CHECK_ActiveAlarm.mrbts_id is null;
drop table if exists #sitelist

select
	A.RC,
	A.Kabupate [Kabupaten],
	A.[Tower Index],
	A.mrbts_name,
	A.mrbtsId,
	A.ip_oam,
	B.lnBtsId,
	B.cellName,
	B.lnCelId,
	case
		when C.operationalState = 0 then 'initializing'
		when C.operationalState = 1 then 'commissioned'
		when C.operationalState = 2 then 'notCommisioned'
		when C.operationalState = 3 then 'configured'
		when C.operationalState = 4 then 'integrated to RAN'
		when C.operationalState = 5 then 'onAir'
		when C.operationalState = 6 then 'test'
	end [lnbts_opState],
	case
		when B.administrativeState = 1 then 'unlocked'
		when B.administrativeState = 2 then 'shutting down'
		when B.administrativeState = 3 then 'locked'
	end [lncel_adminState],
	case
		when B.operationalState = 0 then 'disable'
		when B.operationalState = 1 then 'enable'
	end [lncel_opState],
	case
		when B.energySavingState = 0 then 'notEnergySaving'
		when B.energySavingState = 1 then 'energySaving'
		when B.energySavingState = 2 then 'reducedEnergySaving'
		when B.energySavingState = 3 then 'switchingOff'
		when B.energySavingState = 4 then 'switchingOffRTX'
		when B.energySavingState = 5 then 'switchingOnTX'
	end [lncel_energySaving]
into #sitelist
from
	[dbo].[00_LIST_OAM]A
		left join [dbo].[A_LTE_MRBTS_LNBTS_LNCEL]B on (A.mrbtsId = B.mrbtsId)
		left join [dbo].[A_LTE_MRBTS_LNBTS]C on (A.mrbtsId = C.mrbtsId)
	--left join [dbo].[RC2_A_EQM_MRBTS_EQM_APEQM_RMOD]D on (A.mrbtsId = D.mrbtsId))

drop table if exists #band


select A.mrbtsId,A.[lnBtsId],A.[lnCelId],
		case
			when earfcnDL between 0 and 599 then 'L2100'
			when earfcnDL between 1200 and 1949 then 'L1800'
			when earfcnDL between 3450 and 3799 then 'L900'
		end [band],
		A.dlChBw/10 [bandwidth]
into #band
from
	[dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD]A



select A.*,
	   E.band,
	   E.bandwidth
from
	#sitelist A
		LEFT JOIN #band E on (A.mrbtsId=E.mrbtsId and A.lnBtsId=E.[lnBtsId] and A.lnCelId=E.[lnCelId])
ORDER BY
	A.RC,
	A.Kabupaten,
	A.[Tower Index],
	A.lnCelId

drop table if exists #band
drop table if exists #sitelist

drop table if exists #antl_rmod

select a.mrbtsId,a.antl_r_id,a.configDN,b.productName,RIGHT(b.configDN,LEN(b.configDN)-patindex('%/RMOD-%',b.configDN))[RMOD_ID]
into #antl_rmod
from
	[dbo].[A_EQM_R_APEQM_R_RMOD_R_ANTL_R]a
	left join [dbo].[A_EQM_R_APEQM_R_RMOD_R]b on (a.mrbtsId=b.mrbtsId and a.rmod_r_id=b.rmod_r_id)

select 
		C.[Tower Index],
		A.mrbtsId,
		C.mrbts_name,
		A.lnBtsId,
		B.name,
		B.cellName,
		A.lnCelId,
		case A.dlMimoMode
			when 0 then 'singleTX'
			when 10 then 'TXDiv'
			when 11 then '4-way TXDiv'
			when 30 then 'Dynamic Open Loop MIMO'
			when 40 then 'Closed Loop Mimo'
			when 41 then '4T2R'
			when 42 then '8T2R'
			when 43 then '4T4R'
			when 44 then '8T4R'
			when 45 then '16T2R'
			else 'UNKNOWN'
		end [MimoType],
		case
			when earfcnDL between 0 and 599 then 'L2100'
			when earfcnDL between 1200 and 1949 then 'L1800'
			when earfcnDL between 3450 and 3799 then 'L900'
		end + ' (' + CAST(A.dlChBw/10 AS nvarchar) + ')' [band]
from
	(select*from[dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD])A
	left join (select*from [dbo].[A_LTE_MRBTS_LNBTS_LNCEL])B
				ON (A.mrbtsId=B.mrbtsId and A.lnBtsId=B.lnBtsId and A.lnCelId=B.lnCelId)
	right join (SELECT*FROM [dbo].[00_LIST_OAM]
				WHERE
					[Tower Index] in ('JAW-JT-SMG-2481','JAW-JT-SMG-0542','JAW-JT-SKT-2054','JAW-JT-SMG-0596','JAW-JT-KRG-2154','JAW-JT-KRG-2151','JAW-JT-UNR-2708','JAW-JT-SKT-2047','JAW-JT-PWD-0002','JAW-JT-WSB-2905','JAW-JT-SKH-1973','JAW-JT-MKD-1134','JAW-JT-KLN-1003','JAW-JT-WSB-2496','JAW-JT-SKH-1984','JAW-JT-KLN-0920','JAW-JT-SKH-1881'))C
			ON (A.mrbtsId=C.mrbtsId)
order by
	c.[Tower Index],A.lnCelId

drop table if exists #antl_rmod
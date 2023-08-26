drop table if exists #antl_rmod;
drop table if exists #temp_rc;

--===========================================RC2=================================================

select a.mrbtsId,a.antl_r_id,a.configDN,b.productName,RIGHT(b.configDN,LEN(b.configDN)-patindex('%/RMOD-%',b.configDN))[RMOD_ID]
into #antl_rmod
from
	[dbo].[A_EQM_R_APEQM_R_RMOD_R_ANTL_R]a
	left join [dbo].[A_EQM_R_APEQM_R_RMOD_R]b on (a.mrbtsId=b.mrbtsId and a.rmod_r_id=b.rmod_r_id)

select distinct d.[Tower Index],d.[mrbts_name],a.mrbtsId,b.RMOD_ID,b.productName,b.antl_r_id[port_number],RIGHT(a.antlDN,LEN(a.antlDN)-patindex('%/ANTL-%',a.antlDN))[antl_id]/*,a.direction*/,c.name [lncel_name],a.lCellId,c.distName [distName_lncell],a.antlDN,b.configDN
INTO #temp_rc
from
	[dbo].[A_MNL_CELLMAPPING_LCELL_CHANNELGROUP_CHANNEL]a
	left join #antl_rmod b on (a.antlDN=b.configDN)
	left join [dbo].[A_LTE_MRBTS_LNBTS_LNCEL]c on (a.mrbtsId=c.mrbtsId and a.lCellId=c.lnCelId)
	left join [dbo].[00_LIST_OAM]d on (a.mrbtsId=d.mrbtsId)

drop table if exists #antl_rmod;
--=======================================UNION=====================================
select [Tower Index],
	mrbts_name,
	mrbtsId,
	RMOD_ID,
	productName,
	port_number,
	antl_id,
	STRING_AGG(lncel_name,' | ') within group(order by lncel_name) [lncel],
	configDN
from (select*from #temp_rc)a
where
	a.[Tower Index] in ('JAW-JT-SMG-2481','JAW-JT-SMG-0542','JAW-JT-SKT-2054','JAW-JT-SMG-0596','JAW-JT-KRG-2154','JAW-JT-KRG-2151','JAW-JT-UNR-2708','JAW-JT-SKT-2047','JAW-JT-PWD-0002','JAW-JT-WSB-2905','JAW-JT-SKH-1973','JAW-JT-MKD-1134','JAW-JT-KLN-1003','JAW-JT-WSB-2496','JAW-JT-SKH-1984','JAW-JT-KLN-0920','JAW-JT-SKH-1881')
group by
[Tower Index],
	mrbts_name,
	mrbtsId,
	RMOD_ID,
	productName,
	port_number,
	antl_id,
	configDN
order by [Tower Index],RMOD_ID,port_number


drop table if exists #temp_rc;

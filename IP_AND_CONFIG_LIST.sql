drop table if exists #temp1;
drop table if exists #temp2;
drop table if exists #temp3;
drop table if exists #temp4;
drop table if exists #temp5;
drop table if exists #config;
drop table if exists #detailconfig;


TRUNCATE TABLE [dbo].[00_LIST_OAM]

select
	rc,
	RIGHT([distName],LEN([distName])-PATINDEX('%/MRBTS-%',[distName])) as AddressDN,
	localIpAddr
INTO #temp3
from
	[dbo].[A_TNL_TNL_IPNO_IPIF_IPADDRESSV4];

select
	a.rc,
	a.mrbtsId,
	a.mPlaneIpv4AddressDN,
	b.localIpAddr
into #temp4
from
	[dbo].[A_MNL_MRBTS_MNL_MNLENT_MPLANENW] a
		left join #temp3 b on (a.mPlaneIpv4AddressDN = b.AddressDN);


SELECT tmp.*
INTO #temp1
FROM (select
	rc,
	mrbtsId,
	iif(CHARINDEX(' ',productName)>0,
		SUBSTRING([productName],1,CHARINDEX(' ',productName)-1),
		productName)[nameModule]
from
	[dbo].[A_EQM_R_APEQM_R_CABINET_R_SMOD_R]
union all
select
	rc,
	mrbtsId,
	iif(CHARINDEX(' ',productName)>0,
	SUBSTRING([productName],1,CHARINDEX(' ',productName)-1),
	productName)[nameModule]
from
	[dbo].[A_EQM_R_APEQM_R_CABINET_R_BBMOD_R]
union all
select
	rc,
	mrbtsId,
	iif(CHARINDEX(' ',productName)>0,
	SUBSTRING([productName],1,CHARINDEX(' ',productName)-1),
	productName)[nameModule]
from
	[dbo].[A_EQM_R_APEQM_R_RMOD_R])tmp;

SELECT * 
INTO #temp2
FROM
(
	SELECT * FROM #temp1
) t
PIVOT(
	COUNT(nameModule)
	FOR nameModule IN (
		[ASIA],[ASIB],[Flexi],[FSMF],[ABIA],[ABIO],[FBBA],[FBBC],[FRGP],[FRGP-CR],[FXEB],[FXDA],[FXDB],[FXED],[FRGU],[FXDD],[AREA],[ARGA],[ARDA],[ARDB],[AHDB],[AHEGC]	
	)
) AS pivot_table;


-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>CONFIG<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SELECT rc, mrbtsId, STRING_AGG(band, '+') WITHIN GROUP (ORDER BY
	CASE
		WHEN patindex('%G900%',band)>0 then 1
		WHEN patindex('%G1800%',band)>0 then 2
		WHEN patindex('%L900%',band)>0 then 3
		WHEN patindex('%L1800%',band)>0 then 4
		WHEN patindex('%L2100%',band)>0 then 5
		ELSE 6
	END)[config]
INTO #config
FROM (
	select distinct 
		A.rc,
		C.[mrbtsId], 
		CASE frequencyBandInUse
			WHEN 0 THEN 'G900'
			WHEN 1 THEN 'G1800'
			ELSE 'UNKOWN'
		END [band]
	from
		[dbo].[A_BTS] A
			left join [dbo].[A_BCF] B ON (A.BSCId = B.BSCId AND A.BCFId = B.BCFId)
			inner join [dbo].[A_GNBCF]C ON (A.BSCId=C.bscId AND A.BCFId=C.bcfId)
	UNION
	select 
			A.rc,
			A.mrbtsId,
			case
				when earfcnDL between 0 and 599 then 'L2100'
				when earfcnDL between 1200 and 1949 then 'L1800'
				when earfcnDL between 3450 and 3799 then 'L900'
			end [band]
	from
		[dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD]A
	group by
		A.rc,A.mrbtsId,A.dlMimoMode,A.earfcnDL
	) T
GROUP BY rc,mrbtsId



SELECT rc,mrbtsId, STRING_AGG(band, ' + ') WITHIN GROUP (ORDER BY
	CASE
		WHEN patindex('%G900%',band)>0 then 1
		WHEN patindex('%G1800%',band)>0 then 2
		WHEN patindex('%L900%',band)>0 then 3
		WHEN patindex('%L1800%',band)>0 then 4
		WHEN patindex('%L2100%',band)>0 then 5
		ELSE 6
	END) [detail_config]
INTO #detailconfig
FROM (
	select distinct 
		A.rc,
		C.[mrbtsId], 
		CASE frequencyBandInUse
			WHEN 0 THEN 'G900'
			WHEN 1 THEN 'G1800'
			ELSE 'UNKOWN'
		END [band]
	from
		[dbo].[A_BTS] A
			left join [dbo].[A_BCF] B ON (A.BSCId = B.BSCId AND A.BCFId = B.BCFId)
			inner join [dbo].[A_GNBCF]C ON (A.BSCId=C.bscId AND A.BCFId=C.bcfId)
	UNION
	select 
			A.rc,
			A.mrbtsId,
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
			end + '_' +
			case
				when earfcnDL between 0 and 599 then 'L2100'
				when earfcnDL between 1200 and 1949 then 'L1800'
				when earfcnDL between 3450 and 3799 then 'L900'
			end + ' (' + CAST(SUM(A.dlChBw)/10 AS nvarchar) + ')' [band]
	from
		[dbo].[A_LTE_MRBTS_LNBTS_LNCEL_LNCEL_FDD]A
	group by
		A.rc,A.mrbtsId,A.dlMimoMode,A.earfcnDL
	) T
GROUP BY rc,mrbtsId

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--INSERT INTO [dbo].[00_LIST_OAM]
SELECT
	a.rc,
	b.siteId,
	a.mrbtsId,
	b.name,
	c.localIpAddr as ip_oam,
	IIF(CHARINDEX('+',a.sf_config)>0,LEFT(a.sf_config,LEN(a.sf_config)-1),'') AS sf_config,
	IIF(CHARINDEX('+',a.rf_config)>0,LEFT(a.rf_config,LEN(a.rf_config)-1),'') AS rf_config,
	d.config,
	e.detail_config
INTO #temp5
FROM (select
	rc,
	mrbtsId,
	IIF(ASIA>0,cast(ASIA as nvarchar(10))+'xASIA+','')+
	IIF(ASIB>0,cast(ASIB as nvarchar(10))+'xASIB+','')+
	IIF(Flexi>0,cast(Flexi as nvarchar(10))+'xFlexi+','')+
	IIF(FSMF>0,cast(FSMF as nvarchar(10))+'xFSMF+','')+
	IIF(ABIA>0,cast(ABIA as nvarchar(10))+'xABIA+','')+
	IIF(ABIO>0,cast(ABIO as nvarchar(10))+'xABIO+','')+
	IIF(FBBC>0,cast(FBBC as nvarchar(10))+'xFBBC+','')+
	IIF(FBBA>0,cast(FBBA as nvarchar(10))+'xFBBA+','') AS sf_config,

	IIF(FRGP>0,cast(FRGP as nvarchar(10))+'xFRGP+','')+
	IIF([FRGP-CR]>0,cast([FRGP-CR] as nvarchar(10))+'xFRGP-CR+','')+
	IIF(FXEB>0,cast(FXEB as nvarchar(10))+'xFXEB+','')+
	IIF(FXDA>0,cast(FXDA as nvarchar(10))+'xFXDA+','')+
	IIF(FXDB>0,cast(FXDB as nvarchar(10))+'xFXDB+','')+
	IIF(FXED>0,cast(FXED as nvarchar(10))+'xFXED+','')+
	IIF(FRGU>0,cast(FRGU as nvarchar(10))+'xFRGU+','')+
	IIF(FXDD>0,cast(FXDD as nvarchar(10))+'xFXDD+','')+
	IIF(AHDB>0,cast(AHDB as nvarchar(10))+'xAHDB+','')+
	IIF(AREA>0,cast(AREA as nvarchar(10))+'xAREA+','')+
	IIF(ARGA>0,cast(ARGA as nvarchar(10))+'xARGA+','')+
	IIF(ARDA>0,cast(ARDA as nvarchar(10))+'xARDA+','')+
	IIF(ARDB>0,cast(ARDB as nvarchar(10))+'xARDB+','')+
	IIF(AHEGC>0,cast(AHEGC as nvarchar(10))+'xAHEGC+','') AS rf_config
from
	#temp2) a
		left join [dbo].[A_MRBTS] b on (a.mrbtsId = b.mrbtsId)
		left join #temp4 c on (a.mrbtsId = c.mrbtsId)
		left join #config d on (a.mrbtsId = d.mrbtsId)
		left join #detailconfig e on (a.mrbtsId = e.mrbtsId)
/*
where
	a.mrbtsId in ('524830')
*/
order by
	b.siteId


--=============================================ADD ADMIN STATE====================================
drop table if exists #tblResult
drop table if exists #out

select a.rc,b.mrbtsId,
	STRING_AGG(case a.adminState
		when 1 then 'U'
		when 3 then 'L'
		else cast(a.adminState as nvarchar)
	end,'') within group (order by a.BTSId) [adminState]
into #tblResult
from
	[dbo].[A_BTS] a
		right join [dbo].[A_GNBCF]b on (a.BSCId = b.BSCId and a.BCFId = b.bcfId)
group by
	a.rc,b.mrbtsId;

--=====================================LTE ADMIN STATE=============================

insert into #tblResult
select a.rc,a.mrbtsId,
	STRING_AGG(case a.administrativeState
		when 1 then 'U'
		when 2 then 'S'
		when 3 then 'L'
	end,'') within group (order by a.lnCelId) [adminState]
from
	[dbo].[A_LTE_MRBTS_LNBTS_LNCEL] a
group by
	a.rc,a.mrbtsId;

--==================================OUT ADMIN STATE================================

select rc,mrbtsId, string_agg(adminState,'')[adminState]
into #out
from
	#tblResult
group by
	rc,mrbtsId;


--====================================================================================
drop table if exists #tmpLIST_SITE
SELECT *
INTO #tmpLIST_SITE
FROM(
	select distinct [Tower Index Final][Tower Index],SBTSID,upper(Kabupaten)[Kabupaten],upper(Kecamatan)[Kecamatan]
	from [dbo].[2G_LLD]
/*
	where [Tower Index] in ('JAW-JT-KJN-0951','JAW-JT-KJN-0985')
*/
	union
	select distinct [Tower Index Final][Tower Index],SBTSID,upper(Kabupaten)[Kabupaten],upper(Kecamatan)[Kecamatan]
	from [dbo].[4G_LLD]
/*
	where [Tower Index] in ('JAW-JT-KJN-0951','JAW-JT-KJN-0985')
*/
)A


insert into [dbo].[00_LIST_OAM]
SELECT b.rc [RC],a.[Tower Index],g.integrationInfo [Tower Index (dump)],a.Kabupaten,a.Kecamatan,a.SBTSID [mrbtsId], b.name [mrbts_name], e.name [bsc_name], e.BSCId, d.bcfId, c.ip_oam,f.adminState,c.sf_config [sm_config],c.rf_config, c.[config], c.[detail_config],'PLMN-PLMN/MRBTS-'+cast(b.mrbtsId as nvarchar(10))[format_ws_4g],'PLMN-PLMN/BSC-'+cast(d.bscId as nvarchar(10))+'/BCF-'+cast(d.bcfId as nvarchar(10))[format_ws_2g]
FROM
	#tmpLIST_SITE a
		RIGHT JOIN [dbo].[A_MRBTS] b ON (a.SBTSID=b.mrbtsId)
		LEFT JOIN #temp5 c ON (b.mrbtsId=c.mrbtsId)
		left join [dbo].[A_GNBCF] d on (b.mrbtsId = d.mrbtsId)
		left join [dbo].[A_BSC] e on (d.bscId = e.BSCId)
		left join #out f on (b.mrbtsId = f.mrbtsId)
		left join [dbo].[A_MRBTSDESC]g ON (b.mrbtsId = g.mrbtsId)

SELECT [RC]
      ,[Tower Index]
	  ,[Tower Index (dump)]
      ,[Kabupate][Kabupaten]
	  ,[Kecamatan]
      ,[mrbtsId]
      ,[mrbts_name]
      ,[bsc_name]
      ,[BSCId]
      ,[bcfId]
      ,[ip_oam]
	  ,'https://'+[ip_oam] [ip_oam (copas version)]
	  ,cellState
      ,[sf_config]
      ,[rf_config]
      ,[config]
      ,[detail_config]
      ,[format_ws_4g]
      ,[format_ws_2g]
  FROM [dbo].[00_LIST_OAM]
ORDER BY
	Kabupate, Kecamatan, RC, [Tower Index];


drop table if exists #tblResult
drop table if exists #out
drop table if exists #tmpLIST_SITE
drop table if exists #detailconfig;
drop table if exists #config;
drop table if exists #temp5;
drop table if exists #temp4;
drop table if exists #temp3;
drop table if exists #temp2;
drop table if exists #temp1;
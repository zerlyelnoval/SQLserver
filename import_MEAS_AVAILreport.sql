--TRUNCATE TABLE [dbo].[MEAS_2G_AVAIL_H];
TRUNCATE TABLE [dbo].[MEAS_4G_AVAIL_H];
--===========import meas daily 2g hourly=========
/*
use nokia_xl2;
go
insert into [dbo].[MEAS_2G_AVAIL_H]
	([PERIOD_START_TIME],
	 [BSC name],
	 [BCF name],
	 [BTS name],
	 [BSCId],
	 [BCFId],
	 [BTSId],
	 [DN],
	 [TCH_Availability_Num],
	 [TCH_Availability_Den]
)
	select 
		[PERIOD_START_TIME],
		[BSC name],
		[BCF name],
		[BTS name],
		SUBSTRING(DN,PATINDEX('%BSC-%',DN)+4,PATINDEX('%/BCF%',DN)-(PATINDEX('%BSC-%',DN)+4)) [BSCId],
		SUBSTRING(DN,PATINDEX('%BCF-%',DN)+4,PATINDEX('%/BTS%',DN)-(PATINDEX('%BCF-%',DN)+4)) [BCFId],
		RIGHT(DN, LEN(DN) - (PATINDEX('%BTS-%',DN)+3)) [BTSId],
		[DN],
		[TCH_Availability_Num],
		[TCH_Availability_Den]
	from OPENROWSET(BULK 'D:\nokia_xl\MEAS\zzz_2g_kpi-nokia_berli-KPI_2G_PAC-20230331_09.csv', formatfile = 'D:\nokia_xl\sql\MeasNumDen_2g_xl_20220718.xml', firstrow=2) as t1;

--===========import meas daily 4g hourly=========
use [nokia_xl2];
go
insert into [dbo].[MEAS_4G_AVAIL_H]
	(
	 [PERIOD_START_TIME],
	 [MRBTS name],
	 [LNBTS name],
	 [LNCEL name],
	 [mrbtsId],
	 [lnBtsId],
	 [lnCelId],
	 [DN],
	 [Radio_Network_Avail_Num],
	 [Radio_Network_Avail_Den]
)
	select 
		[PERIOD_START_TIME],
		[MRBTS name],
		[LNBTS name],		
		[LNCEL name],
		SUBSTRING([DN],PATINDEX('%MRBTS-%',[DN])+6,PATINDEX('%/LNBTS-%',[DN])-(PATINDEX('%/MRBTS-%',[DN])+7))[mrbtsId],
		SUBSTRING([DN],PATINDEX('%LNBTS-%',[DN])+6,PATINDEX('%/LNCEL%',[DN])-(PATINDEX('%/LNBTS-%',[DN])+7))[lnBtsId],
		RIGHT([DN],len([DN])-(PATINDEX('%/LNCEL%',[DN])+6))[lnCelId],
		[DN],
		[Radio_Network_Avail_Num],
		[Radio_Network_Avail_Den]
	from OPENROWSET(BULK 'D:\nokia_xl\MEAS\zzz_4g-nokia_berli-KPI_4G_PAC-20230331_09.csv', formatfile = 'D:\nokia_xl\sql\MeasNumDen_4g_xl_20221718.xml', firstrow=2) as t1;
*/
--=================================RC3=============================================
--=================================================================================
--===========import meas daily 2g hourly=========
/*
use [nokia_xl2];
go
insert into [dbo].[MEAS_2G_AVAIL_H]
	([PERIOD_START_TIME],
	 [BSC name],
	 [BCF name],
	 [BTS name],
	 [BSCId],
	 [BCFId],
	 [BTSId],
	 [DN],
	 [TCH_Availability_Num],
	 [TCH_Availability_Den]
)
	select 
		[PERIOD_START_TIME],
		[BSC name],
		[BCF name],
		[BTS name],
		SUBSTRING(DN,PATINDEX('%BSC-%',DN)+4,PATINDEX('%/BCF%',DN)-(PATINDEX('%BSC-%',DN)+4)) [BSCId],
		SUBSTRING(DN,PATINDEX('%BCF-%',DN)+4,PATINDEX('%/BTS%',DN)-(PATINDEX('%BCF-%',DN)+4)) [BCFId],
		RIGHT(DN, LEN(DN) - (PATINDEX('%BTS-%',DN)+3)) [BTSId],
		[DN],
		[TCH_Availability_Num],
		[TCH_Availability_Den]
	from OPENROWSET(BULK 'D:\nokia_xl\MEAS\zzz_rc3_2g_avail-mnoc_user-KPI_2G_PAC-20230331_09.csv', formatfile = 'D:\nokia_xl\sql\MeasNumDen_2g_xl_20220718.xml', firstrow=2) as t1;
*/

--===========import meas daily 4g hourly=========
use [nokia_xl2];
go
insert into [dbo].[MEAS_4G_AVAIL_H]
	(
	 [PERIOD_START_TIME],
	 [MRBTS name],
	 [LNBTS name],
	 [LNCEL name],
	 [mrbtsId],
	 [lnBtsId],
	 [lnCelId],
	 [DN],
	 [Radio_Network_Avail_Num],
	 [Radio_Network_Avail_Den]
)
	select 
		[PERIOD_START_TIME],
		[MRBTS name],
		[LNBTS name],		
		[LNCEL name],
		SUBSTRING([DN],PATINDEX('%MRBTS-%',[DN])+6,PATINDEX('%/LNBTS-%',[DN])-(PATINDEX('%/MRBTS-%',[DN])+7))[mrbtsId],
		SUBSTRING([DN],PATINDEX('%LNBTS-%',[DN])+6,PATINDEX('%/LNCEL%',[DN])-(PATINDEX('%/LNBTS-%',[DN])+7))[lnBtsId],
		RIGHT([DN],len([DN])-(PATINDEX('%/LNCEL%',[DN])+6))[lnCelId],
		[DN],
		[Radio_Network_Avail_Num],
		[Radio_Network_Avail_Den]
	from OPENROWSET(BULK 'F:\nokia_xl\mini MS\Meas\zzz_avail_4g_hourly-mnoc_user-KPI_4G_PAC-2023_07_15-11_15_13__210.csv', formatfile = 'F:\nokia_xl\sql\MeasNumDen_4g_xl_20221718.xml', firstrow=2) as t1;


--===================================RC2============================================
--==================================================================================
--===========import meas daily 2g hourly=========
/*
use [nokia_xl2];
go
insert into [dbo].[MEAS_2G_AVAIL_H]
	([PERIOD_START_TIME],
	 [BSC name],
	 [BCF name],
	 [BTS name],
	 [BSCId],
	 [BCFId],
	 [BTSId],
	 [DN],
	 [TCH_Availability_Num],
	 [TCH_Availability_Den]
)
	select 
		[PERIOD_START_TIME],
		[BSC name],
		[BCF name],
		[BTS name],
		SUBSTRING(DN,PATINDEX('%BSC-%',DN)+4,PATINDEX('%/BCF%',DN)-(PATINDEX('%BSC-%',DN)+4)) [BSCId],
		SUBSTRING(DN,PATINDEX('%BCF-%',DN)+4,PATINDEX('%/BTS%',DN)-(PATINDEX('%BCF-%',DN)+4)) [BCFId],
		RIGHT(DN, LEN(DN) - (PATINDEX('%BTS-%',DN)+3)) [BTSId],
		[DN],
		[TCH_Availability_Num],
		[TCH_Availability_Den]
	from OPENROWSET(BULK 'D:\nokia_xl\MEAS\zzz_avail_2g_hourly-mnoc_user-KPI_2G_PAC-20230331_09.csv', formatfile = 'D:\nokia_xl\sql\MeasNumDen_2g_xl_20220718.xml', firstrow=2) as t1;
*/

--===========import meas daily 4g hourly=========
use [nokia_xl2];
go
insert into [dbo].[MEAS_4G_AVAIL_H]
	(
	 [PERIOD_START_TIME],
	 [MRBTS name],
	 [LNBTS name],
	 [LNCEL name],
	 [mrbtsId],
	 [lnBtsId],
	 [lnCelId],
	 [DN],
	 [Radio_Network_Avail_Num],
	 [Radio_Network_Avail_Den]
)
	select 
		[PERIOD_START_TIME],
		[MRBTS name],
		[LNBTS name],		
		[LNCEL name],
		SUBSTRING([DN],PATINDEX('%MRBTS-%',[DN])+6,PATINDEX('%/LNBTS-%',[DN])-(PATINDEX('%/MRBTS-%',[DN])+7))[mrbtsId],
		SUBSTRING([DN],PATINDEX('%LNBTS-%',[DN])+6,PATINDEX('%/LNCEL%',[DN])-(PATINDEX('%/LNBTS-%',[DN])+7))[lnBtsId],
		RIGHT([DN],len([DN])-(PATINDEX('%/LNCEL%',[DN])+6))[lnCelId],
		[DN],
		[Radio_Network_Avail_Num],
		[Radio_Network_Avail_Den]
	from OPENROWSET(BULK 'F:\nokia_xl\mini MS\Meas\zzz_rc3_4g_avail-mnoc_user-KPI_4G_PAC-2023_07_15-11_25_25__160.csv', formatfile = 'F:\nokia_xl\sql\MeasNumDen_4g_xl_20221718.xml', firstrow=2) as t1;
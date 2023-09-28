Use master 
go

CREATE_DATABASE_[Cloud_Datacentre_Planning]
_CONTAINMENT_=_NONE
_ON__PRIMARY_
_NAME_=_N'Cloud_Datacentre_Planning',_FILENAME_=_N'K:\MSSQL\Data\Cloud_Datacentre_Planning.mdf'_,_SIZE_=_2097152KB_,_FILEGROWTH_=_1048576KB_
_LOG_ON_
_NAME_=_N'Cloud_Datacentre_Planning_log',_FILENAME_=_N'L:\MSSQL\Log\Cloud_Datacentre_Planning_log.ldf'_,_SIZE_=_1048576KB_,_FILEGROWTH_=_204800KB_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_COMPATIBILITY_LEVEL_=_150
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_ANSI_NULL_DEFAULT_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_ANSI_NULLS_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_ANSI_PADDING_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_ANSI_WARNINGS_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_ARITHABORT_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_AUTO_CLOSE_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_AUTO_SHRINK_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_AUTO_CREATE_STATISTICS_ONINCREMENTAL_=_OFF
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_AUTO_UPDATE_STATISTICS_ON_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_CURSOR_CLOSE_ON_COMMIT_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_CURSOR_DEFAULT__GLOBAL_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_CONCAT_NULL_YIELDS_NULL_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_NUMERIC_ROUNDABORT_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_QUOTED_IDENTIFIER_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_RECURSIVE_TRIGGERS_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET__DISABLE_BROKER_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_AUTO_UPDATE_STATISTICS_ASYNC_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_DATE_CORRELATION_OPTIMIZATION_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_PARAMETERIZATION_SIMPLE_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_READ_COMMITTED_SNAPSHOT_OFF_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET__READ_WRITE_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_RECOVERY_FULL_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET__MULTI_USER_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_PAGE_VERIFY_CHECKSUM__
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_TARGET_RECOVERY_TIME_=_60_SECONDS_
GO
ALTER_DATABASE_[Cloud_Datacentre_Planning]_SET_DELAYED_DURABILITY_=_DISABLED_
GO
USE_[Cloud_Datacentre_Planning]
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_SET_LEGACY_CARDINALITY_ESTIMATION_=_Off;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_FOR_SECONDARY_SET_LEGACY_CARDINALITY_ESTIMATION_=_Primary;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_SET_MAXDOP_=_0;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_FOR_SECONDARY_SET_MAXDOP_=_PRIMARY;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_SET_PARAMETER_SNIFFING_=_On;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_FOR_SECONDARY_SET_PARAMETER_SNIFFING_=_Primary;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_SET_QUERY_OPTIMIZER_HOTFIXES_=_Off;
GO
ALTER_DATABASE_SCOPED_CONFIGURATION_FOR_SECONDARY_SET_QUERY_OPTIMIZER_HOTFIXES_=_Primary;
GO
USE_[Cloud_Datacentre_Planning]
GO
IF_NOT_EXISTS_SELECT_name_FROM_sys.filegroups_WHERE_is_default=1_AND_name_=_N'PRIMARY'_ALTER_DATABASE_[Cloud_Datacentre_Planning]_MODIFY_FILEGROUP_[PRIMARY]_DEFAULT
GO

--_Create_Tables

USE_[Cloud_Datacentre_Planning]
GO


/****** Object:  Table [dbo].[vInfo$]    Script Date: 15/03/2022 14:22:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SoD].[vInfo](
	[VM] [nvarchar](255) NULL,
	[Powerstate] [nvarchar](255) NULL,
	[Template] [nvarchar](255) NULL,
	[Config_status] [nvarchar](255) NULL,
	[DNS_Name] [nvarchar](255) NULL,
	[Connection_state] [nvarchar](255) NULL,
	[Guest_state] [nvarchar](255) NULL,
	[Heartbeat] [nvarchar](255) NULL,
	[Consolidation_Needed] [nvarchar](255) NULL,
	[PowerOn] [datetime] NULL,
	[Suspend_time] [nvarchar](255) NULL,
	[Creation_date] [datetime] NULL,
	[Change_Version] [datetime] NULL,
	[CPUs] [float] NULL,
	[Memory] [float] NULL,
	[NICs] [float] NULL,
	[Disks] [float] NULL,
	[min_Required_EVC_Mode_Key] [nvarchar](255) NULL,
	[Latency_Sensitivity] [nvarchar](255) NULL,
	[EnableUUID] [nvarchar](255) NULL,
	[CBT] [nvarchar](255) NULL,
	[Primary_IP_Address] [nvarchar](255) NULL,
	[Network_1] [nvarchar](255) NULL,
	[Network_2] [nvarchar](255) NULL,
	[Network_3] [nvarchar](255) NULL,
	[Network_4] [nvarchar](255) NULL,
	[NumMonitors] [float] NULL,
	[VideoRamKB] [float] NULL,
	[ResourcePool] [nvarchar](255) NULL,
	[Folder] [nvarchar](255) NULL,
	[vApp] [nvarchar](255) NULL,
	[DASProtection] [nvarchar](255) NULL,
	[FT_State] [nvarchar](255) NULL,
	[FT_Latency] [nvarchar](255) NULL,
	[FT_Bandwidth] [float] NULL,
	[FT_Sec_Latency] [float] NULL,
	[ProvisionedMB] [float] NULL,
	[InUseMB] [float] NULL,
	[UnsharedMB] [float] NULL,
	[HA_RestartPriority] [nvarchar](255) NULL,
	[HA_IsolationResponse] [nvarchar](255) NULL,
	[HA_VM_Monitoring] [nvarchar](255) NULL,
	[ClusterRule] [nvarchar](255) NULL,
	[ClusterRuleName] [nvarchar](255) NULL,
	[BootRequired] [nvarchar](255) NULL,
	[BootDelay] [float] NULL,
	[BootRetryDelay] [float] NULL,
	[BootRetryEnabled] [nvarchar](255) NULL,
	[BootBIOS_setup] [nvarchar](255) NULL,
	[Firmware] [nvarchar](255) NULL,
	[HW_Version] [float] NULL,
	[HW_UpgradeStatus] [nvarchar](255) NULL,
	[HW_UpgradePolicy] [nvarchar](255) NULL,
	[HW_Target] [nvarchar](255) NULL,
	[Path] [nvarchar](255) NULL,
	[LogDirectory] [nvarchar](255) NULL,
	[SnapshotDirectory] [nvarchar](255) NULL,
	[SuspendDirectory] [nvarchar](255) NULL,
	[Annotation] [nvarchar](255) NULL,
	[LastBackup] [nvarchar](255) NULL,
	[LastBackup1] [nvarchar](255) NULL,
	[va_mseg] [nvarchar](255) NULL,
	[va_mseg_epi] [nvarchar](255) NULL,
	[va_mseg_vlan] [nvarchar](255) NULL,
	[XdConfig] [nvarchar](255) NULL,
	[Datacenter] [nvarchar](255) NULL,
	[Cluster] [nvarchar](255) NULL,
	[Host] [nvarchar](255) NULL,
	[OSAccording_to_theConfigurationFile] [nvarchar](255) NULL,
	[OSAccording_to_theVMwareTools] [nvarchar](255) NULL,
	[VM_ID] [nvarchar](255) NULL,
	[VM_UUID] [nvarchar](255) NULL,
	[VI_SDK_Server type] [nvarchar](255) NULL,
	[VI_SDK_API Version] [nvarchar](255) NULL,
	[VI_SDK_Server] [nvarchar](255) NULL,
	[VI_SDK_UUID] [nvarchar](255) NULL
	) ON [PRIMARY] 
GO


CREATE TABLE [SoD].[SCW_AddedInfo](
	[VM] [nvarchar](255) NULL,
	[Scope] [nvarchar](255) NULL,
	[Non_Production_Yes_No] [nvarchar](255) NULL,
	[Impending_Hardware_Refresh_Yes_No] [nvarchar](255) NULL,
	[BackupServerYesNo] [nvarchar](255) NULL,
	[ApplicationWorkloadTag] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL,
	[SoftwareName] [nvarchar](max) NULL,
	[Make] [nvarchar](255) NULL,
	[Version] [nvarchar](255) NULL,
	[Certero_OperatingSystem] [nvarchar](255) NULL,
	[Certero_ZoneId] [nvarchar](255) NULL,
	[Certero_ZoneDescription] [nvarchar](255) NULL,
	[Certero_Name] [nvarchar](255) NULL,
	[Host_Location] [nvarchar](255) NULL,
	[ApplicationWorkloadTag1] [nvarchar](255) NULL,
	[Wave] [nvarchar](255) NULL,
	[Domain] [nvarchar](255) NULL,
	[ServerInfo] [nvarchar](255) NULL,
	[MonitoredInSolarwinds] [nvarchar](255) NULL,
	[Type_Of_Server] [nvarchar](255) NULL,
	[Environment] [nvarchar](255) NULL,
	[SQL_Version] [nvarchar](255) NULL,
	[Customer] [nvarchar](255) NULL,
	[Directorate] [nvarchar](255) NULL,
	[Service_Line] [nvarchar](255) NULL,
	[Owner] [nvarchar](255) NULL,
	[vCPU] [float] NULL,
	[Utilization_PcentPeak] [float] NULL,
	[Utilization_PcentAvg] [float] NULL,
	[MemoryGB] [float] NULL,
	[Utilization_PcentPeak1] [float] NULL,
	[Utilization_PcentAvg1] [float] NULL,
	[DiskSpaceGB] [float] NULL,
	[Utilization_PcentPeak2] [float] NULL,
	[Utilization_PcentAvg2] [float] NULL,
	[vNIC] [float] NULL,
	[UtilizationMBpsPeak] [nvarchar](255) NULL,
	[UtilizationMBpsAvg] [nvarchar](255) NULL,
	[GroupingOption1] [nvarchar](255) NULL,
	[GroupingOption2] [nvarchar](255) NULL,
	[Decomm_Keep_Cloud] [nvarchar](255) NULL,
	[Deleted] [nvarchar](255) NULL,
	[ApplicationArchitecture] [nvarchar](255) NULL,
	[ApplicationCodeAndVersion] [nvarchar](255) NULL,
	[DatabaseRequirements] [nvarchar](255) NULL,
	[BackupOptionsSQL_Windows_Both] [nvarchar](255) NULL,
	[IAAS_PAAS_SAAS] [nvarchar](255) NULL,
	[Comments1] [nvarchar](255) NULL,
	[Timeframe] [nvarchar](255) NULL,
	[Dependency] [nvarchar](255) NULL
) ON [PRIMARY] 
GO

CREATE TABLE [SoD].[SCW_ServerCosts](
	[VM] [nvarchar](255) NULL,
	[SCW_Server_Cost_Annually] [money] NULL,
	[SCW_Server_Cost_PCM] [money] NULL,
	[CPU] [float] NULL,
	[RAM_in_GB] [float] NULL,
	[Total_Storage_TB] [float] NULL,
	[CPU_Cost] [money] NULL,
	[Ram_Cost] [money] NULL,
	[Storage_Cost] [money] NULL,
	[Backup_Cost] [money] NULL,
	[5PcentCostDell_HostRackingNetworkingPowerAC] [money] NULL,
	[Windows_Licence_Cost] [money] NULL,
	[Total_Server_Cost] [money] NULL
) ON [PRIMARY] 
GO


CREATE TABLE [SoD].[Microsoft_Info](
	[VM] [nvarchar](255) NULL,
	[DNS_Name1] [nvarchar](255) NULL,
	[Provisioned_MB1] [float] NULL,
	[In_Use_MB1] [float] NULL,
	[Unshared_MB1] [float] NULL,
	[Current_CPU] [float] NULL,
	[Current_RAM_in_GB] [float] NULL,
	[Oversized_CPU] [float] NULL,
	[Oversized_RAM] [float] NULL,
	[Undersized_CPU] [float] NULL,
	[Undersized_RAM] [float] NULL,
	[CPU_Difference] [float] NULL,
	[RAM_Difference] [float] NULL,
	[Rightsized_CPU] [float] NULL,
	[Rightsized_RAM] [float] NULL,
	[Total_StorageTB1] [float] NULL,
	[Prod_Dev_Test] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[OS] [nvarchar](255) NULL,
	[CPU Util % Peak] [float] NULL,
	[CPU Util % Average] [float] NULL,
	[Mem Util % Peak] [float] NULL,
	[Mem Util % Average] [float] NULL,
	[Storage Util % Peak] [float] NULL,
	[Storage Util % Average] [float] NULL,
	[Nic Util % Peak] [nvarchar](255) NULL,
	[Nic Util % Average] [nvarchar](255) NULL,
	[CSU SQL Licence Cost (Yearly)] [money] NULL,
	[CSU CPU Cost (Yearly)] [money] NULL,
	[CSU Ram Cost (Yearly)] [money] NULL,
	[CSU Compute Cost (Yearly)] [money] NULL,
	[CSU Compute Costs (Monthly)] [money] NULL,
	[CSU Storage Cost (Yearly)] [money] NULL,
	[CSU Storage Cost (Monthly)] [money] NULL,
	[CSU Backup Cost (Yearly)] [money] NULL,
	[5% cost of a Dell host , racking, networking, power , AC1] [money] NULL,
	[CSU Windows Licence Cost (Yearly)] [money] NULL,
	[CSU Operational Cost (Yearly)] [money] NULL,
	[vRealise Licensing Costs (Year 1)] [money] NULL,
	[CSU Depreciation costs (Yearly over 5 years)] [money] NULL,
	[CSU Total Server Cost (excludes SQL Licences)] [money] NULL,
	[CSU As Is Annual Cost (Inc SQL Licenses)] [money] NULL,
	[CSU As Is PCM Cost (Inc SQL Licenses)] [money] NULL
) ON [PRIMARY]
GO


USE [Cloud_Datacentre_Planning]
GO



INSERT INTO [SoD].[vInfo]
           ([VM]
           ,[Powerstate]
           ,[Template]
           ,[Config_status]
           ,[DNS_Name]
           ,[Connection_state]
           ,[Guest_state]
           ,[Heartbeat]
           ,[Consolidation_Needed]
           ,[PowerOn]
           ,[Suspend_time]
           ,[Creation_date]
           ,[Change_Version]
           ,[CPUs]
           ,[Memory]
           ,[NICs]
           ,[Disks]
           ,[min_Required_EVC_Mode_Key]
           ,[Latency_Sensitivity]
           ,[EnableUUID]
           ,[CBT]
           ,[Primary_IP_Address]
           ,[Network_1]
           ,[Network_2]
           ,[Network_3]
           ,[Network_4]
           ,[NumMonitors]
           ,[VideoRamKB]
           ,[ResourcePool]
           ,[Folder]
           ,[vApp]
           ,[DASProtection]
           ,[FT_State]
           ,[FT_Latency]
           ,[FT_Bandwidth]
           ,[FT_Sec_Latency]
           ,[ProvisionedMB]
           ,[InUseMB]
           ,[UnsharedMB]
           ,[HA_RestartPriority]
           ,[HA_IsolationResponse]
           ,[HA_VM_Monitoring]
           ,[ClusterRule]
           ,[ClusterRuleName]
           ,[BootRequired]
           ,[BootDelay]
           ,[BootRetryDelay]
           ,[BootRetryEnabled]
           ,[BootBIOS_setup]
           ,[Firmware]
           ,[HW_Version]
           ,[HW_UpgradeStatus]
           ,[HW_UpgradePolicy]
           ,[HW_Target]
           ,[Path]
           ,[LogDirectory]
           ,[SnapshotDirectory]
           ,[SuspendDirectory]
           ,[Annotation]
           ,[LastBackup]
           ,[LastBackup1]
           ,[va_mseg]
           ,[va_mseg_epi]
           ,[va_mseg_vlan]
           ,[XdConfig]
           ,[Datacenter]
           ,[Cluster]
           ,[Host]
           ,[OSAccording_to_theConfigurationFile]
           ,[OSAccording_to_theVMwareTools]
           ,[VM_ID]
           ,[VM_UUID]
           ,[VI_SDK_Server type]
           ,[VI_SDK_API Version]
           ,[VI_SDK_Server]
           ,[VI_SDK_UUID])
Select		[VM],
			[Powerstate],
			[Template],
			[Config status],
			[DNS Name],
			[Connection state],
			[Guest state],
			[Heartbeat],
			[Consolidation Needed],
			[PowerOn],
			[Suspend time],
			[Creation date],
			[Change Version],
			[CPUs],
			[Memory],
			[NICs],
			[Disks],
			[min Required EVC Mode Key ],
			[Latency Sensitivity],
			[EnableUUID],
			[CBT],
			[Primary IP Address],
			[Network #1],
			[Network #2],
			[Network #3],
			[Network #4],
			[Num Monitors],
			[Video Ram KB],
			[Resource pool],
			[Folder],
			[vApp],
			[DAS protection],
			[FT State],
			[FT Latency],
			[FT Bandwidth],
			[FT Sec# Latency],
			[Provisioned MB],
			[In Use MB],
			[Unshared MB],
			[HA Restart Priority],
			[HA Isolation Response],
			[HA VM Monitoring],
			[Cluster rule(s)],
			[Cluster rule name(s)],
			[Boot Required],
			[Boot delay],
			[Boot retry delay],
			[Boot retry enabled],
			[Boot BIOS setup],
			[Firmware],
			[HW version],
			[HW upgrade status],
			[HW upgrade policy],
			[HW target],
			[Path],
			[Log directory],
			[Snapshot directory],
			[Suspend directory],
			[Annotation],
			[Last backup],
			[Last Backup1],
			[va#mseg],
			[va#mseg#epi],
			[va#mseg#vlan],
			[XdConfig],
			[Datacenter],
			[Cluster],
			[Host],
			[OS according to the configuration file],
			[OS according to the VMware Tools],
			[VM ID],
			[VM UUID],
			[VI SDK Server type],
			[VI SDK API Version],
			[VI SDK Server],
			[VI SDK UUID]
From vInfo$
GO


USE [Cloud_Datacentre_Planning]
GO

INSERT INTO [SoD].[SCW_AddedInfo]
           ([VM]
           ,[Scope]
           ,[Non_Production_Yes_No]
           ,[Impending_Hardware_Refresh_Yes_No]
           ,[BackupServerYesNo]
           ,[ApplicationWorkloadTag]
           ,[Comments]
           ,[SoftwareName]
           ,[Make]
           ,[Version]
           ,[Certero_OperatingSystem]
           ,[Certero_ZoneId]
           ,[Certero_ZoneDescription]
           ,[Certero_Name]
           ,[Host_Location]
           ,[ApplicationWorkloadTag1]
           ,[Wave]
           ,[Domain]
           ,[ServerInfo]
           ,[MonitoredInSolarwinds]
           ,[Type_Of_Server]
           ,[Environment]
           ,[SQL_Version]
           ,[Customer]
           ,[Directorate]
           ,[Service_Line]
           ,[Owner]
           ,[vCPU]
           ,[Utilization_PcentPeak]
           ,[Utilization_PcentAvg]
           ,[MemoryGB]
           ,[Utilization_PcentPeak1]
           ,[Utilization_PcentAvg1]
           ,[DiskSpaceGB]
           ,[Utilization_PcentPeak2]
           ,[Utilization_PcentAvg2]
           ,[vNIC]
           ,[UtilizationMBpsPeak]
           ,[UtilizationMBpsAvg]
           ,[GroupingOption1]
           ,[GroupingOption2]
           ,[Decomm_Keep_Cloud]
           ,[Deleted]
           ,[ApplicationArchitecture]
           ,[ApplicationCodeAndVersion]
           ,[DatabaseRequirements]
           ,[BackupOptionsSQL_Windows_Both]
           ,[IAAS_PAAS_SAAS]
           ,[Comments1]
           ,[Timeframe]
           ,[Dependency])
Select		[VM],
		[Scope]
      ,[Non Production_(Yes/No)]
      ,[Impending Hardware Refresh?_(Yes/No)]
      ,[Backup Server?_(Yes/No)]
      ,[Application/ Workload Tag_(open text field)]
      ,[Comments]
      ,[Software Name]
      ,[Make ]
      ,[Version]
      ,[Certero_OperatingSystem]
      ,[Certero_ZoneId]
      ,[Certero_ZoneDescription]
      ,[Certero_Name]
      ,[Host Location]
      ,[Application/ Workload Tag_(open text field)1]
      ,[Wave_(open text field)]
      ,[Domain]
      ,[Server Info]
      ,[Monitored in Solarwinds]
      ,[Type Of Server]
      ,[Environment]
      ,[SQL Version]
      ,[Customer]
      ,[Directorate]
      ,[Service Line]
      ,[Owner]
      ,[vCPU]
      ,[Utilization % (Peak)]
      ,[Utilization % (Avg)]
      ,[Memory (GB)]
      ,[Utilization % (Peak)1]
      ,[Utilization % (Avg)1]
      ,[Disk Space (GB)]
      ,[Utilization % (Peak)2]
      ,[Utilization % (Avg)2]
      ,[vNIC]
      ,[Utilization MBps (Peak)]
      ,[Utilization MBps (Avg)]
      ,[Grouping Option 1]
      ,[Grouping Option 2]
      ,[Decomm_Keep_Cloud ]
      ,[Deleted]
      ,[Application Architecture]
      ,[Application Code & Version]
      ,[Database Requirements]
      ,[Backup Options (SQL/Windows/Both)]
      ,[IAAS_PAAS_SAAS]
      ,[Comments1]
      ,[Timeframe]
      ,[Dependency]
From	vInfo$
GO

USE [Cloud_Datacentre_Planning]
GO

INSERT INTO [SoD].[SCW_ServerCosts]
           ([VM]
           ,[SCW_Server_Cost_Annually]
           ,[SCW_Server_Cost_PCM]
           ,[CPU]
           ,[RAM_in_GB]
           ,[Total_Storage_TB]
           ,[CPU_Cost]
           ,[Ram_Cost]
           ,[Storage_Cost]
           ,[Backup_Cost]
           ,[5PcentCostDell_HostRackingNetworkingPowerAC]
           ,[Windows_Licence_Cost]
           ,[Total_Server_Cost])
Select	[VM],
		[SCW Server Cost Annually], 
		[SCW Server Cost PCM],
		[CPU],
		[RAM in GB],
		[Total Storage TB],
		[CPU Cost],
		[Ram Cost],
		[Storage Cost],
		[Backup Cost],
		[5% cost of a Dell host , racking, networking, power , AC],
		[Windows Licence Cost],
		[Total Server Cost ]
From vInfo$
GO


USE [Cloud_Datacentre_Planning]
GO

INSERT INTO [SoD].[Microsoft_Info]
           ([VM]
           ,[DNS_Name1]
           ,[Provisioned_MB1]
           ,[In_Use_MB1]
           ,[Unshared_MB1]
           ,[Current_CPU]
           ,[Current_RAM_in_GB]
           ,[Oversized_CPU]
           ,[Oversized_RAM]
           ,[Undersized_CPU]
           ,[Undersized_RAM]
           ,[CPU_Difference]
           ,[RAM_Difference]
           ,[Rightsized_CPU]
           ,[Rightsized_RAM]
           ,[Total_StorageTB1]
           ,[Prod_Dev_Test]
           ,[Type]
           ,[OS]
           ,[CPU Util % Peak]
           ,[CPU Util % Average]
           ,[Mem Util % Peak]
           ,[Mem Util % Average]
           ,[Storage Util % Peak]
           ,[Storage Util % Average]
           ,[Nic Util % Peak]
           ,[Nic Util % Average]
           ,[CSU SQL Licence Cost (Yearly)]
           ,[CSU CPU Cost (Yearly)]
           ,[CSU Ram Cost (Yearly)]
           ,[CSU Compute Cost (Yearly)]
           ,[CSU Compute Costs (Monthly)]
           ,[CSU Storage Cost (Yearly)]
           ,[CSU Storage Cost (Monthly)]
           ,[CSU Backup Cost (Yearly)]
           ,[5% cost of a Dell host , racking, networking, power , AC1]
           ,[CSU Windows Licence Cost (Yearly)]
           ,[CSU Operational Cost (Yearly)]
           ,[vRealise Licensing Costs (Year 1)]
           ,[CSU Depreciation costs (Yearly over 5 years)]
           ,[CSU Total Server Cost (excludes SQL Licences)]
           ,[CSU As Is Annual Cost (Inc SQL Licenses)]
           ,[CSU As Is PCM Cost (Inc SQL Licenses)])
Select	[VM],
		[DNS Name1],
		[Provisioned MB1],
		[In Use MB1],
		[Unshared MB1],
		[Current CPU],
		[Current RAM in GB],
		[Oversized CPU],
		[Oversized RAM],
		[Undersized CPU],
		[Undersized RAM],
		[CPU Difference],
		[RAM Difference],
		[Rightsized CPU],
		[Rightsized RAM],
		[Total Storage TB1],
		[Prod / Dev / Test etc],
		[Type],
		[O/S],
		[CPU Util % Peak],
		[CPU Util % Average],
		[Mem Util % Peak],
		[Mem Util % Average],
		[Storage Util % Peak],
		[Storage Util % Average],
		[Nic Util % Peak],
		[Nic Util % Average],
		[CSU SQL Licence Cost (Yearly)],
		[CSU CPU Cost (Yearly)],
		[CSU Ram Cost (Yearly)],
		[CSU Compute Cost (Yearly)],
		[CSU Compute Costs (Monthly)],
		[CSU Storage Cost (Yearly)],
		[CSU Storage Cost (Monthly)],
		[CSU Backup Cost (Yearly)],
		[5% cost of a Dell host , racking, networking, power , AC1],
		[CSU Windows Licence Cost (Yearly)],
		[CSU Operational Cost (Yearly)],
		[vRealise Licensing Costs (Year 1)],
		[CSU Depreciation costs (Yearly over 5 years)],
		[CSU Total Server Cost (excludes SQL Licences)],
		[CSU As Is Annual Cost (Inc SQL Licenses)],
		[CSU As Is PCM Cost (Inc SQL Licenses)]
From	vInfo$
GO

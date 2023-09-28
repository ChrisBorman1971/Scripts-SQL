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

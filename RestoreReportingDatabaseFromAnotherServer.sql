-- RestoreReportingDatabaseFromAnotherServer.sql    rm     26/01/16
--
--

-- This runs as a 3-step maintenance job on XSW-00-CCSQL03
--
-- It attempts to drop 2 databases on the reporting box XSW-00-CCSQL03 and
-- then restore the databases from the latest backups on prod XSW-00-CCSQL01 
--
-- Next it adds the reporting user not on the PROD box to both databases
--
-- And runs a stored procedure in the CC_Reporting_Data database to refresh the data
--
-- Whole thing is in RestoreOHCP_OHAUDIT&OHCP_OHPORTAL.sql, these are just the steps
--
-- 
-- This can, however lead to some strange behaviour.  If there are problems with the backup
-- On XSW-00-CCSQL01, the restore job on XSW-00-CCSQL03 can throw some strange errors.
-- If a full backup of the OHCP_OHAUDIT and OHCP_OHPORTAL is taken on CCSQL01 other than on 
-- a Sunday, the job will fail as the full backup will have a later date than the diff.
-- Hilariously, the restore job does not check for this until after it has dropped the 
-- copies on CCSQL03.  In this case, the process is to run a diff on CCSQL01, then run the 
-- restore job on CCSQL03.  The last time I did this (20/11/16) I ran the individual steps of 
-- job separately.  If the restore job does not complete, the Reporting Services site on
-- Connecting Care shows no data.  This is most crucila at week and month end.


----------------------------------------------------------
-- Step 1.  Restore database - This is the interesting bit
--
----------------------------------------------------------

USE [Master]
GO

DECLARE @db_name VARCHAR(50) -- database name  
DECLARE @db_path VARCHAR(600) -- path for backup files 
DECLARE @db_datapath VARCHAR(600) -- path for backup files 
DECLARE @db_logpath VARCHAR(600) -- path for backup files 
DECLARE @db_devtype VARCHAR(10)
DECLARE @db_logicalname VARCHAR(600)
DECLARE @db_physicalname VARCHAR(600)
DECLARE @db_physicalname_diff VARCHAR(600)
DECLARE @tmpstr NVARCHAR(600)
DECLARE @tmpstr2 NVARCHAR(600)
DECLARE @tmpstr3 NVARCHAR(100)
DECLARE @server_name VARCHAR(50)
DECLARE @RestoreDB varchar(75)
DECLARE @RestoreDB_diff varchar(75)
DECLARE @date datetime
DECLARE @date_diff datetime

SET @db_path = '\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak'  -- Set this to the required path
--SET @db_devtype = ' From DISK' 
SET @server_name = 'XSW-00-CCSQL01'


DECLARE db_cursor CURSOR FOR  
-- Select statement for all User databases
--SELECT name FROM [XSW-00-CCSQL01].master.dbo.sysdatabases WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') 

-- Select statement for a single User database
SELECT name FROM [XSW-00-CCSQL01].master.dbo.sysdatabases WHERE name IN ('OHCP_OHAUDIT', 'OHCP_OHPORTAL') 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @db_name   
IF (SELECT DATENAME(WEEKDAY,GETDATE())) = 'Monday'
	WHILE @@FETCH_STATUS = 0   
	BEGIN  
		SET @tmpstr3 = 'Drop Database ' + @db_name 
		EXECUTE sp_executesql @tmpstr3
		PRINT 'Drop Database Completed'
		SET @date = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = 'D')
		SET @RestoreDB = (SELECT [name] + '.fbak' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = 'D' and [backup_finish_date] >= @date)
		SET @db_datapath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 1)
		SET @db_physicalname = @db_path + '\' +  @server_name + '\' + @RestoreDB
		SET @db_logpath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 2)
		SET @tmpstr = 'RESTORE DATABASE ' + '[' + @db_name + ']' + ' FROM DISK = N''' + @db_physicalname + ''' WITH  FILE = 1,  MOVE N''' + @db_name + ''' TO N''' + @db_datapath + ''', MOVE N''' + @db_name + '_log'' TO N''' + @db_logpath + ''',  NOUNLOAD,  REPLACE,  STATS = 5;' 
	--	PRINT @tmpstr
		EXECUTE sp_executesql @tmpstr
		FETCH NEXT FROM db_cursor INTO @db_name   
	END   
ELSE
	WHILE @@FETCH_STATUS = 0   
	BEGIN  
		SET @tmpstr3 = 'Drop Database ' + @db_name 
		EXECUTE sp_executesql @tmpstr3
		PRINT 'Drop Database Completed'
		SET @date = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = 'D')
		SET @date_diff = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = 'I')
		SET @server_name = 'XSW-00-CCSQL01'
		SET @RestoreDB = (SELECT [name] + '.fbak' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = 'D' and [backup_finish_date] >= @date)
		SET @RestoreDB_diff = (SELECT [name] + '.dbak' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = 'I' and [backup_finish_date] >= @date_diff)
		SET @db_datapath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 1)
		SET @db_physicalname = @db_path + '\' +  @server_name + '\' + @RestoreDB
		SET @db_physicalname_diff = @db_path + '\' +  @server_name + '\' + @RestoreDB_diff
		SET @db_logpath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 2)
		SET @tmpstr = 'RESTORE DATABASE ' + '[' + @db_name + ']' + ' FROM DISK = N''' + @db_physicalname + ''' WITH  FILE = 1,  MOVE N''' + @db_name + ''' TO N''' + @db_datapath + ''', MOVE N''' + @db_name + '_log'' TO N''' + @db_logpath + ''',  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5;' 
		SET @tmpstr2 = 'RESTORE DATABASE ' + '[' + @db_name + ']' + ' FROM DISK = N''' + @db_physicalname_diff + ''' WITH  FILE = 1,  MOVE N''' + @db_name + ''' TO N''' + @db_datapath + ''', MOVE N''' + @db_name + '_log'' TO N''' + @db_logpath + ''',  NOUNLOAD,  STATS = 5;' 

--		PRINT @tmpstr
		EXECUTE sp_executesql @tmpstr
--		PRINT @tmpstr2
		EXECUTE sp_executesql @tmpstr2
		FETCH NEXT FROM db_cursor INTO @db_name   
	END   

CLOSE db_cursor  
DEALLOCATE db_cursor

----------------------------------------------------------
-- Step 2.  Add in Reporting Services users
----------------------------------------------------------

USE [OHCP_OHPORTAL]
GO
CREATE USER [CCP_Reporting] FOR LOGIN [CCP_Reporting]
GO
USE [OHCP_OHPORTAL]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CCP_Reporting]
GO


USE [OHCP_OHAUDIT]
GO
CREATE USER [CCP_Reporting] FOR LOGIN [CCP_Reporting]
GO
USE [OHCP_OHAUDIT]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CCP_Reporting]
GO

----------------------------------------------------------
-- Step 3.  Refresh Reporting Data
----------------------------------------------------------

USE [CC_Reporting_Data]
GO

exec [dbo].[uspRefreshReportingData]

----------------------------------------------------------
-- Step 3.  [dbo].[uspRefreshReportingData]
----------------------------------------------------------

USE [CC_Reporting_Data]
GO

/****** Object:  StoredProcedure [dbo].[uspRefreshReportingData]    Script Date: 26/01/2016 15:04:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[uspRefreshReportingData]
AS
BEGIN
   
	IF OBJECT_ID('dbo.UserAccount', 'U') IS NOT NULL
		DROP TABLE dbo.UserAccount;
 
	IF OBJECT_ID('dbo.UserAccountEventDay', 'U') IS NOT NULL
		DROP TABLE dbo.UserAccountEventDay;


	ALTER DATABASE CC_Reporting_Data SET RECOVERY BULK_LOGGED;

	SELECT * INTO #TEMPUser FROM dbo.TEMPUserView;

	CREATE INDEX IDX_TEMPUser_Username ON #TEMPUser(Username);

	SELECT * INTO #TEMPEventDay FROM dbo.TEMPEventView;

	CREATE NONCLUSTERED INDEX IDX_TEMPEventDay_Username_LicenseDate ON #TEMPEventDay(Username,LicenseDate);

	SELECT U.[UserDSExtractTime],
		   U.[Username],
		   U.[UserID],
		   U.[ConcertoAccount],
		   U.[IsUserDeleted],
		   U.[UserEmailDomain],
		   U.[AccountCreationDate],
		   U.[AccountCreationMonth],
		   U.[AccountCreationMonthName],
		   U.[AccountCreationQuarter],
		   U.[AccountCreationQuarterName],
		   U.[AccountCreationYear],
		   U.[AccountCreationLastDayOfMonth],
		   U.[AccountCreationLastDayOfQuarter],
		   U.[lastLoginTime],
		   U.[accountTimeoutDays],
		   U.[accountTimeoutDate],
		   U.[OrganisationCode],
		   U.[OrganisationName],
		   U.[OrganisationShortName],
		   U.[OrganisationType],
		   U.[UserFullName],
		   U.[UserEmail],
		   U.[GPPracticeCode],
		   U.[PMPracticeCode],
		   U.[UserService],
		   U.[UserRoleName],
		   U.[UrgentCareRole],
		   U.[ConsultantRole],
		   U.[AdminRole],
		   U.[SysAdminRole],
		   U.[SocialCareRole],
		   U.[GPRole],
		   U.[PracticeMgrRole],
		   U.[CommunityRole],
		   U.[HelpdeskRole],
		   T.LastPrevSuccessfulLoginDate,
		   T.TotalSuccessfulLogins,
		   T.TotalPatientViews,
		   T.TotalNumRoleChangesAfter2m,
		   T.LastDeactivationDate,
		   ISNULL(C.CurrentLicenseStatus,'deleted') AS CurrentLicenseStatus,
		   C.CurrentDeactivationDate,
		   C.CurrentDaysToDeactivation
	  INTO dbo.UserAccount
	  FROM #TEMPUser U LEFT OUTER JOIN 
		   (
			-- get aggregate measures from all events  
			SELECT Username,
				   MAX([PrevSuccessfulLoginDate]) AS LastPrevSuccessfulLoginDate,
				   SUM([NumSuccessfulLogins]) AS TotalSuccessfulLogins,
				   SUM([NumUniquePatientViews]) AS TotalPatientViews,
				   SUM([NumRoleChangesAfter2m]) AS TotalNumRoleChangesAfter2m,
				   MAX([DeactivationDate]) AS LastDeactivationDate
			  FROM #TEMPEventDay
			 GROUP BY Username
			) T 
			ON U.Username = T.Username
			LEFT OUTER JOIN
			(
			 -- get measures from yesterday event
			 SELECT Username,
					LicenseStatus AS CurrentLicenseStatus,
					DeactivationDate AS CurrentDeactivationDate,
					DaysToDeactivation AS CurrentDaysToDeactivation
			   FROM #TEMPEventDay
			  WHERE LicenseDate = DATEADD(d,-1, CAST(GETDATE() AS DATE))
			) C
			ON U.Username = C.Username;

     SELECT U.[UserDSExtractTime],
			U.[Username],
			U.[UserID],
			U.[ConcertoAccount],
			U.[IsUserDeleted],
			U.[UserEmailDomain],
			U.[AccountCreationDate],
			U.[AccountCreationMonth],
			U.[AccountCreationMonthName],
			U.[AccountCreationQuarter],
			U.[AccountCreationQuarterName],
			U.[AccountCreationYear],
			U.[AccountCreationLastDayOfMonth],
			U.[AccountCreationLastDayOfQuarter],
			U.[lastLoginTime],
			U.[accountTimeoutDays],
			U.[accountTimeoutDate],
			U.[OrganisationCode],
			U.[OrganisationName],
			U.[OrganisationShortName],
			U.[OrganisationType],
			U.[UserFullName],
			U.[UserEmail],
			U.[GPPracticeCode],
			U.[PMPracticeCode],
			U.[UserService],
			U.[UserRoleName],
			U.[UrgentCareRole],
			U.[ConsultantRole],
			U.[AdminRole],
			U.[SysAdminRole],
			U.[SocialCareRole],
			U.[GPRole],
			U.[PracticeMgrRole],
			U.[CommunityRole],
			U.[HelpdeskRole],
			E.[EventDSExtractTime],
			--E.[UserName],
			E.[LicenseStartDate],
			E.[LicenseEndDate],
			E.[LicenseEndDateIsNullToday],
			E.[LicenseDate],
			E.[LicenseMonth],
			E.[LicenseMonthName],
			E.[LicenseQuarter],
			E.[LicenseQuarterName],
			E.[LicenseYear],
			E.[LicenseLastDayOfMonth],
			E.[LicenseLastDayOfQuarter],
			E.[IsLicenseStartDate],
			E.[IsLicenseEndDate],
			E.[IsLoginAttempted],
			E.[NumSuccessfulLogins],
			E.[NumFailedLogins],
			E.[NumUniquePatientViews],
			E.[NumPasswordChangesMade],
			E.[PrevSuccessfulLoginDate],
			E.[DaysFromPrevSuccessfulLoginOrLicenseStart],
			E.[LicenseStatus],
			E.[DeactivationDate],
			E.[DaysToDeactivation],
			E.[NumRoleChangesAfter2m]
       INTO dbo.UserAccountEventDay
       FROM #TEMPUser U LEFT OUTER JOIN
	        #TEMPEventDay E
			ON U.Username = E.Username;
			
	CREATE INDEX IDX_UserAccount_Username ON dbo.UserAccount(Username);
	
	CREATE NONCLUSTERED INDEX IDX_LicenseEvent_Username_LicenseDate ON dbo.UserAccountEventDay(LicenseDate, Username, OrganisationCode);
				 
	/*
	-- runtime at 2016-01-04 approx 1:10 minutes, 1,988 rows
	SELECT * INTO dbo.CCUsers FROM [dbo].[UsersView];

	-- runtime at 2016-01-14 approx 1:11 minutes, 41,690 rows
	SELECT * INTO dbo.CCUserLoginsDayLevel FROM [dbo].[CCUserLoginsDayLevelView];

    SELECT UserOrganisation,  EventMonth, EventMonthName,  EventQuarter, EventQuarterName, EventYear, Count(1) AS NumOfEvents
      INTO CCOrganisationLoginsMonthLevel 
      FROM dbo.CCUserLoginsDayLevel
	  WHERE EventDate IS NOT NULL AND NumLoginSuccess > 0
     GROUP BY UserOrganisation, EventMonth, EventMonthName,  EventQuarter, EventQuarterName, EventYear
     ORDER BY UserOrganisation, EventYear, EventMonth;

	-- runtime at 2016-01-14 approx 2:02 minutes, 525,470 rows
	SELECT * INTO #CCUserLicensesDayLevel FROM [dbo].[CCUserLicensesDayLevelView];

	SELECT 
	   U.*
	  --,LC.[Username]
      ,LC.[LicenseCreateDate]
      ,LC.[LicenseRemoveDate]a
      ,LC.[LicenseRemoveDateIsNullToday]
      ,LC.[LicenseDate]
      ,LC.[LicenseMonth]
      ,LC.[LicenseMonthName]
      ,LC.[LicenseQuarter]
      ,LC.[LicenseQuarterName]
      ,LC.[LicenseYear]
      ,LC.[LicenseLastDayOfMonth]
      ,LC.[LicenseLastDayOfQuarter]
	  ,LG.NumLoginSuccess
	  ,LG.NumUniquePtViews
	  ,(SELECT DATEDIFF(d, MAX(EventDate), LC.LicenseDate)
	     FROM [CC_Reporting_Data].[dbo].[CCUserLoginsDayLevel] LGX
		WHERE LGX.NumLoginSuccess > 0
		  AND LC.Username = LGX.Username 
		  AND LC.LicenseDate >= LGX.EventDate) AS DaysSincePrevLogin
	  ,(SELECT CASE 
	                -- if a user hasn't logged in for over 90 days then they are inactive
	                WHEN ISNULL(DATEDIFF(d, MAX(EventDate), LC.LicenseDate),91) > 90 
					THEN 'inactive'
				    ELSE 'active' 
				END
	     FROM [CC_Reporting_Data].[dbo].[CCUserLoginsDayLevel] LGX
		WHERE LGX.NumLoginSuccess > 0
		  AND LC.Username = LGX.Username AND LC.LicenseDate >= LGX.EventDate) AS LicenseActivityStatus
  INTO dbo.CCUserLicensesLoginsDayLevel
  FROM [CC_Reporting_Data].dbo.CCUsers U INNER JOIN
       #CCUserLicensesDayLevel LC 
	    ON U.Username = LC.Username
       LEFT OUTER JOIN  [CC_Reporting_Data].[dbo].[CCUserLoginsDayLevel] LG 
	     ON LC.Username = LG.Username AND LC.LicenseDate = LG.EventDate

	SELECT UserOrganisation, 
	       LicenseMonth, 
		   LicenseMonthName,  
		   LicenseQuarter, 
		   LicenseQuarterName, 
		   LicenseYear, 
	       ISNULL([active],0) + ISNULL([inactive],0)  AS NumOfLicenses, 
		   ISNULL([active],0) AS NumOfActiveLicenses,  
		   ISNULL([inactive],0) AS NumOfInactiveLicenses
	  INTO CCOrganisationLicensesLoginsMonthLevel
	  FROM 
	     ( SELECT UserOrganisation,  LicenseMonth, LicenseMonthName,  LicenseQuarter, LicenseQuarterName, LicenseYear, LicenseActivityStatus, Count(1) AS NumOfLicenses
		     FROM dbo.CCUserLicensesLoginsDayLevel
		    WHERE LicenseDate = LicenseLastDayOfMonth
		    GROUP BY UserOrganisation,  LicenseMonth, LicenseMonthName,  LicenseQuarter, LicenseQuarterName, LicenseYear, LicenseActivityStatus
		 ) AS SourceTable
	     PIVOT 
	     (
			 SUM(NumOfLicenses)
			 FOR LicenseActivityStatus IN ([active],[inactive])
		 ) AS PivotTable
	*/
	ALTER DATABASE CC_Reporting_Data SET RECOVERY FULL;
	
END;






GO




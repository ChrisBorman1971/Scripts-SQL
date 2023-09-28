-- SetStatisticsOnOff.sql     rm      25/08/15
--
-- stats appear on messages tab in SSMS

Set Statistics time on
Set statistics io on

  select 1 from 2 where 3  -- sql to execute and time

Set Statistics time off
Set statistics io off
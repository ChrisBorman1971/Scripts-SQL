-- FindDisabledIndexes.sql     rm       01/07/15
--
-- Finds disabled indexes in a database.
-- To enable, rebuild them

select
    sys.objects.name as [Object Name],
    sys.indexes.name as [Index Name]
from sys.indexes
    inner join sys.objects on sys.objects.object_id = sys.indexes.object_id
where sys.indexes.is_disabled = 1
order by
    sys.objects.name,
    sys.indexes.name



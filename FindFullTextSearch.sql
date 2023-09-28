-- FindFullTextSearch.sql    rm    11/05/16
--
-- Handy hints relating to FTS from 666054eBook.pdf

-- Is full textsearch enabled? 1 = Yes, 0 means a return to the installation disk
SELECT SERVERPROPERTY('IsFullTextInstalled');

-- Which filters (aka ifilters) are installed? 2 ways to find out...
--
-- system stored procedure
EXEC sys.sp_help_fulltext_system_components 'filter';

-- Or sys.fulltext_document_types
SELECT document_type, path
FROM sys.fulltext_document_types;

-- Other filter packs can be installed, eg MS Office 2012 to give .docx and .xlsx filters
-- from http://www.microsoft.com/en-us/download/details.aspx?id=17062
--
-- They have to be installed onto the target SQl Server box and then 
-- Registered in SQl Server by using
EXEC sys.sp_fulltext_service 'load_os_resources', 1;

-- Check which languages are supported using
SELECT lcid, name
FROM sys.fulltext_languages
ORDER BY name;

-- Find stoplists and the stopwords therein
SELECT stoplist_id, name
FROM sys.fulltext_stoplists;

SELECT stoplist_id, stopword, language
FROM sys.fulltext_stopwords;

-- Load a thesaurus file after manually editing it, eg the English one on my local instance
-- at C:\Program Files\Microsoft SQL Server\MSSQL11.RICHLOCAL\MSSQL\FTData\tseng.xml

EXEC sys.sp_fulltext_load_thesaurus_file 1033;







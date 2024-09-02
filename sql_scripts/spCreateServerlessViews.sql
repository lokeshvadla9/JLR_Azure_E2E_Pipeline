USE jlr_gold_db;
GO

CREATE OR ALTER PROCEDURE CreateServerlessView 
    @ViewName NVARCHAR(100)
AS
BEGIN
    DECLARE @statement NVARCHAR(MAX);

    SET @statement = N'CREATE OR ALTER VIEW ' + QUOTENAME(@ViewName) + ' AS
        SELECT *
        FROM
        OPENROWSET(
            BULK ''https://datalakejlr.dfs.core.windows.net/gold/public/' + @ViewName + '/'', 
            FORMAT = ''DELTA''
        ) AS [result];';

    EXEC sp_executesql @statement;
END;
GO
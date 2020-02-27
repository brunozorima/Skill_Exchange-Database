﻿/*
Deployment script for FYP_CONCEPT

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "FYP_CONCEPT"
:setvar DefaultFilePrefix "FYP_CONCEPT"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key aa05f62c-ced3-4ecb-a1ba-1cb12ae80a0d is skipped, element [dbo].[Exchange].[Rec] (SqlSimpleColumn) will not be renamed to Recipient_Id';


GO
PRINT N'Creating [dbo].[Exchange]...';


GO
CREATE TABLE [dbo].[Exchange] (
    [Id]                     INT       NOT NULL,
    [Sender_Id]              INT       NOT NULL,
    [Recipient_Id]           INT       NOT NULL,
    [Status]                 TINYINT   NULL,
    [Opened_TimeStamp]       TIMESTAMP NULL,
    [Last_Message_TimeStamp] TIMESTAMP NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[ExchangeMessage]...';


GO
CREATE TABLE [dbo].[ExchangeMessage] (
    [Id]           INT            NOT NULL,
    [Sender_Id]    INT            NOT NULL,
    [Recipient_Id] INT            NOT NULL,
    [Body]         NVARCHAR (MAX) NOT NULL,
    [TimeStamp]    TIMESTAMP      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Exchange]...';


GO
ALTER TABLE [dbo].[Exchange]
    ADD DEFAULT 0 FOR [Status];


GO
PRINT N'Creating unnamed constraint on [dbo].[Exchange]...';


GO
ALTER TABLE [dbo].[Exchange] WITH NOCHECK
    ADD FOREIGN KEY ([Sender_Id]) REFERENCES [dbo].[ApplicationUser] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Exchange]...';


GO
ALTER TABLE [dbo].[Exchange] WITH NOCHECK
    ADD FOREIGN KEY ([Recipient_Id]) REFERENCES [dbo].[ApplicationUser] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[ExchangeMessage]...';


GO
ALTER TABLE [dbo].[ExchangeMessage] WITH NOCHECK
    ADD FOREIGN KEY ([Sender_Id]) REFERENCES [dbo].[ApplicationUser] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[ExchangeMessage]...';


GO
ALTER TABLE [dbo].[ExchangeMessage] WITH NOCHECK
    ADD FOREIGN KEY ([Recipient_Id]) REFERENCES [dbo].[ApplicationUser] ([Id]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'aa05f62c-ced3-4ecb-a1ba-1cb12ae80a0d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('aa05f62c-ced3-4ecb-a1ba-1cb12ae80a0d')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Exchange'), OBJECT_ID(N'dbo.ExchangeMessage'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO

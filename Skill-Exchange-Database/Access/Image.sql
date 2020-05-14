CREATE TABLE [dbo].[Image]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(255) NULL, 
    [Size] INT NULL, 
    [ImageData] VARBINARY(MAX) NULL
)

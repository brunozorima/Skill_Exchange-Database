CREATE TABLE [dbo].[ExchangeMessage]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Sender_Id] INT NOT NULL,
	[Exchange_Id] INT NOT NULL, 
    [Body] NVARCHAR(MAX) NOT NULL, 
    [TimeStamp] DATETIME NULL, 
	FOREIGN KEY (Sender_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY ([Exchange_Id]) REFERENCES [dbo].[Exchange](Id) ON DELETE CASCADE
)

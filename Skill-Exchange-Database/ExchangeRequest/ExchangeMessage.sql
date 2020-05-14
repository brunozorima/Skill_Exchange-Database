CREATE TABLE [dbo].[ExchangeMessage]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Sender_Id] INT NOT NULL REFERENCES [dbo].[ApplicationUser](Id),
	[Exchange_Id] INT NOT NULL REFERENCES [dbo].[Exchange](Id) ON DELETE CASCADE, 
    [Body] NVARCHAR(400) NOT NULL, 
    [TimeStamp] DATETIME NULL
)
GO 
CREATE INDEX [IX_ExchangeMessage_Sender_Id] ON [dbo].[ExchangeMessage]([Sender_Id])
GO 
CREATE INDEX [IX_ExchangeMessage_Exchange_Id] ON [dbo].[ExchangeMessage]([Exchange_Id])
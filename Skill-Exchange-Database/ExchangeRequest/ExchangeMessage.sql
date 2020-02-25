CREATE TABLE [dbo].[ExchangeMessage]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Sender_Id] INT NULL,
	[Recipient_Id] INT NULL, 
    [Body] NVARCHAR(MAX) NULL, 
    [TimeStamp] TIMESTAMP NULL, 
)

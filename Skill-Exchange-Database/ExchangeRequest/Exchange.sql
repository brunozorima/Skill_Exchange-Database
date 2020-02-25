CREATE TABLE [dbo].[Exchange]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Sender_Id] INT NULL, 
    [Recipient_Id] INT NULL, 
    [Opened_TimeStamp] TIMESTAMP NULL 
)

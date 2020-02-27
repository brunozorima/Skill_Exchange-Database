CREATE TABLE [dbo].[ExchangeMessage]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Sender_Id] INT NOT NULL,
	[Recipient_Id] INT NOT NULL, 
    [Body] NVARCHAR(MAX) NOT NULL, 
    [TimeStamp] DATETIME NULL, 
	FOREIGN KEY (Sender_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY (Recipient_Id) REFERENCES [dbo].[ApplicationUser](Id)
)

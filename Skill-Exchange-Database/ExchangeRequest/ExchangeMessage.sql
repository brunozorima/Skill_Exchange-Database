CREATE TABLE [dbo].[ExchangeMessage]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Sender_Id] INT NOT NULL,
	[Recipient_Id] INT NOT NULL, 
    [Body] NVARCHAR(MAX) NOT NULL, 
    [TimeStamp] TIMESTAMP NULL, 
	FOREIGN KEY (Sender_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY (Recipient_Id) REFERENCES [dbo].[ApplicationUser](Id)
)

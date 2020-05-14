CREATE TABLE [dbo].[Exchange]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Sender_Id] INT NOT NULL REFERENCES [dbo].[ApplicationUser](Id), 
    [Recipient_Id] INT NOT NULL REFERENCES [dbo].[ApplicationUser](Id), 
	[Status] TINYINT NULL DEFAULT 0,
    [Opened_TimeStamp] DATETIME NULL,
	[Last_Message_TimeStamp] DATETIME NULL
)
GO 
CREATE INDEX [IX_Exchange_Sender_Id] ON [dbo].[Exchange]([Sender_Id])
GO 
CREATE INDEX [IX_Exchange_Recipient_Id] ON [dbo].[Exchange]([Recipient_Id])
CREATE TABLE [dbo].[Exchange]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Sender_Id] INT NOT NULL, 
    [Recipient_Id] INT NOT NULL, 
	[Status] TINYINT NULL DEFAULT 0,
    [Opened_TimeStamp] DATETIME NULL,
	[Last_Message_TimeStamp] DATETIME NULL, 
    FOREIGN KEY (Sender_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY (Recipient_Id) REFERENCES [dbo].[ApplicationUser](Id)

)

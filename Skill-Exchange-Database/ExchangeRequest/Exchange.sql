CREATE TABLE [dbo].[Exchange]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Sender_Id] INT NOT NULL, 
    [Recipient_Id] INT NOT NULL, 
	[Status] TINYINT NULL DEFAULT 0,
    [Opened_TimeStamp] TIMESTAMP NULL,
	[Last_Message_TimeStamp] TIMESTAMP NULL, 
    FOREIGN KEY (Sender_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY (Recipient_Id) REFERENCES [dbo].[ApplicationUser](Id)

)

CREATE TABLE [dbo].[Person_Need_Skill]
(
	Person_Id INT NOT NULL, 
	Skill_Id INT NOT NULL,
	PRIMARY KEY (Person_Id,Skill_Id),
	FOREIGN KEY (Person_Id) REFERENCES [dbo].[ApplicationUser](Id),
	FOREIGN KEY (Skill_Id) REFERENCES [dbo].[Skill](Id) 
)

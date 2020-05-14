CREATE TABLE [dbo].[Person_Has_Skill]
(
	Person_Id INT NOT NULL REFERENCES [dbo].[ApplicationUser](Id), 
	Skill_Id INT NOT NULL REFERENCES [dbo].[Skill](Id)
)
GO 
CREATE INDEX [IX_Person_Has_Skill_Person_Id] ON [dbo].[Person_Has_Skill](Person_Id)
GO 
CREATE INDEX [IX_Person_Has_Skill_Skill_Id] ON [dbo].[Person_Has_Skill](Skill_Id)
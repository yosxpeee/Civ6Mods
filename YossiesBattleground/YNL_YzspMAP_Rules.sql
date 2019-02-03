--
INSERT OR IGNORE INTO Maps (Domain,File,Name,Description,WorldBuilderOnly,RequiresUniqueLeaders,SortIndex)
	SELECT	'Maps:Expansion1Maps', File,Name,Description,WorldBuilderOnly,RequiresUniqueLeaders,SortIndex
	FROM Maps WHERE Domain <> 'Maps:Expansion1Maps';
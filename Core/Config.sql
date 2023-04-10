-- Config
-- Author: Anagram
-- DateCreated: 4/9/2023 2:16:21 PM
--------------------------------------------------------------

INSERT INTO Players (Domain, CivilizationType, CivilizationName, CivilizationIcon, CivilizationAbilityName, CivilizationAbilityDescription, CivilizationAbilityIcon, LeaderType, LeaderName, LeaderIcon, LeaderAbilityName, LeaderAbilityDescription, LeaderAbilityIcon)
VALUES	(	
		-- Civilization
		'Players:Expansion2_Players', -- Domain
		'CIVILIZATION_GRAM_EAGLELAND', -- CivilizationType
		'LOC_CIVILIZATION_GRAM_EAGLELAND_NAME', -- CivilizationName
		'ICON_CIVILIZATION_GRAM_EAGLELAND', -- CivilizationIcon
		'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY_NAME', -- CivilizationAbilityName
		'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY_DESC', -- CivilizationAbilityDescription
		'ICON_CIVILIZATION_GRAM_EAGLELAND', -- CivilizationAbilityIcon
		
		-- Leader
		'LEADER_GRAM_NESS', -- LeaderType
		'LOC_LEADER_GRAM_NESS_NAME', -- LeaderName
		'ICON_LEADER_GRAM_NESS', -- LeaderIcon (Portrait)
		'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_NAME', -- LeaderAbilityName
		'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_DESC', -- LeaderAbilityDescription
		'ICON_LEADER_GRAM_NESS' -- LeaderAbilityIcon
		);



INSERT INTO PlayerItems
		(Domain, CivilizationType, LeaderType, Type, Icon, Name, Description, SortIndex	)
VALUES	(
		'Players:Expansion2_Players', -- Domain
		'CIVILIZATION_GRAM_EAGLELAND', -- CivilizationType
		'LEADER_GRAM_NESS', -- LeaderType
		'UNIT_GRAM_PSYCHIC', -- Type
		'ICON_UNIT_GRAM_PSYCHIC', -- Icon
		'LOC_UNIT_GRAM_PSYCHIC_NAME', -- Name
		'LOC_UNIT_GRAM_PSYCHIC_DESC', -- Description
		10	-- SortIndex
		),
		
		(
		'Players:Expansion2_Players', -- Domain
		'CIVILIZATION_GRAM_EAGLELAND', -- CivilizationType
		'LEADER_GRAM_NESS', -- LeaderType
		'UNIT_GRAM_ESCARGOMAN', -- Type
		'ICON_GRAM_ESCARGOMAN', -- Icon
		'LOC_UNIT_GRAM_ESCARGOMAN_NAME', -- Name
		'LOC_UNIT_GRAM_ESCARGOMAN_DESC', -- Description
		20 -- SortIndex
		);
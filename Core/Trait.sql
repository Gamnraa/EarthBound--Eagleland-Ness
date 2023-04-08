-- Civilization_Trait
-- Author: Anagram
-- DateCreated: 4/8/2023 2:57:23 PM
--------------------------------------------------------------
--Eagleland establishes itself as Suzerain over any City-State that has none for at least 5 consecutive turns (limited by amount of cities Eageland controls)
--Ness receives 50 diplomatic favor and Culture when discovering Natural Wonders. +1 Diplomatic Favor per turn, +3 Combat Strength to Psychics for every 8th of the world's Natural Wonders under his control
--Most of these functionalities will be coded in Lua

INSERT INTO Types
			(Type,														Kind		)
VALUES		('TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVREIGNITY',			'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',						'KIND_TRAIT');

INSERT INTO Traits
			(TraitType,													Name,														Description												)
VALUES		('TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVREIGNITY',			'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVREIGNITY_NAME',	'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVREIGNITY_DESC'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',						'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_NAME',				'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_DESC');

INSERT INTO CivilizationTraits
			(CivilizationType,						TraitType										)
VALUES		('CIVILIZATION_GRAM_EAGLELAND',			'TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVREIGNITY'	);

INSERT INTO LeaderTraits
			(LeaderType,			TraitType							)
VALUES		('LEADER_GRAM_NESS',	'TRAIT_LEADER_GRAM_NESS_EARTHBOUND'	);

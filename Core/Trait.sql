-- Civilization_Trait
-- Author: Anagram
-- DateCreated: 4/8/2023 2:57:23 PM
--------------------------------------------------------------
--Eagleland establishes itself as Suzerain over any City-State that has none for at least 5 consecutive turns (limited by amount of cities Eageland controls)
--Ness receives 50 diplomatic favor and Culture when discovering Natural Wonders. Naural Wonders provide +1 Diplomatic Favor per turn, +3 Combat Strength to Psychics for every 8th of the world's Natural Wonders under his control
--Most of these functionalities will be coded in Lua

INSERT INTO Types
			(Type,														Kind		)
VALUES		('TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY',			'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',						'KIND_TRAIT'),

			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_1',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_2',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_3',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_4',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_5',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_6',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_7',						'KIND_TRAIT'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND_8',						'KIND_TRAIT');

INSERT INTO Traits
			(TraitType,													Name,														Description												)
VALUES		('TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY',			'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY_NAME',	'LOC_TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY_DESC'),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',						'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_NAME',				'LOC_TRAIT_LEADER_GRAM_NESS_EARTHBOUND_DESC');



INSERT INTO CivilizationTraits
			(CivilizationType,						TraitType										)
VALUES		('CIVILIZATION_GRAM_EAGLELAND',			'TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY'	);



INSERT INTO LeaderTraits
			(LeaderType,			TraitType							)
VALUES		('LEADER_GRAM_NESS',	'TRAIT_LEADER_GRAM_NESS_EARTHBOUND'	);



INSERT INTO TraitModifiers
			(TraitType,									ModifierId									)
VALUES		('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',		'GRAM_NESS_DIPLO_FAVOR_NATURAL_WONDERS'		);



INSERT INTO Modifiers
			(ModifierId,										ModifierType,									OwnerRequirementSetId							)
VALUES		('GRAM_NESS_DIPLO_FAVOR_NATURAL_WONDERS',			'MODIFIER_GRAM_FAVOR_NATURAL_WONDERS'			'REQSET_GRAM_CITY_OWNS_NATURAL_WONDER'			);



INSERT INTO DynamicModifiers
			(ModifierType,								CollectionType,				EffectType										)
VALUES		('MODIFIER_GRAM_FAVOR_NATURAL_WONDERS',		'COLLECTION_OWNER_CITY',	'EFFECT_ADJUST_PLAYER_EXTRA_FAVOR_PER_TURN'		);



INSERT INTO ModifierArguments
			(ModifierId									Name,			Value		)
VALUES		('GRAM_NESS_DIPLO_FAVOR_NATURAL_WONDERS',	'Amount',		'1'			);
		


INSERT INTO RequirementSets
			(RequirementSetId,							RequirementSetType					)
VALUES		('REQSET_GRAM_CITY_OWNS_NATURAL_WONDER',		'REQUIREMENTSET_TEST_ANY'			);



INSERT INTO Requirements
			(RequirementId,									RequirementType)
VALUES		'REQUIREMENT_GRAM_CITY_OWNS_NATURAL_WONDER',	'REQUIREMENT_CITY_HAS_FEATURE'	);



INSERT INTO RequirementArguments
			(RequirementId,									Name,				Value			)
SELECT		'REQUIREMENT_GRAM_CITY_OWNS_NATURAL_WONDER',	'FeatureType',		FeatureType	
FROM Features WHERE NaturalWonder = '1';	



INSERT INTO RequirementSetRequirements
			(RequirementSetId,								RequirementId								)
VALUES		('REQSET_GRAM_CITY_OWNS_NATURAL_WONDER',		'REQUIREMENT_GRAM__CITY_OWNS_NATURAL_WONDER');
-- Civilization_Trait
-- Author: Anagram
-- DateCreated: 4/8/2023 2:57:23 PM
--------------------------------------------------------------
--Eagleland establishes itself as Suzerain over any City-State that has none for at least 5 consecutive turns (limited by amount of cities Eageland controls)
--Ness receives 50 diplomatic favor and Culture when discovering Natural Wonders. Naural Wonders provide +1 Diplomatic Favor per turn, +3 Combat Strength to Psychics for every 8th of the world's Natural Wonders under his control
--Most of these functionalities will be coded in Lua

INSERT INTO Types
			(Type,														Kind			)
VALUES		('TRAIT_CIVILIZATION_GRAM_EAGLELAND_SOVEREIGNTY',			'KIND_TRAIT'	),
			('TRAIT_LEADER_GRAM_NESS_EARTHBOUND',						'KIND_TRAIT'	),

			('MODIFIER_GRAM_FAVOR_NATURAL_WONDERS',						'KIND_MODIFIER'	),
			('MODIFIER_GRAM_NESS_GIVE_DIPLO_FAVOR',						'KIND_MODIFIER'	),
			('MODIFIER_GRAM_NESS_GIVE_CULTURE',							'KIND_MODIFIER'	);

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
			(ModifierId,										ModifierType,									
			OwnerRequirementSetId,								SubjectRequirementSetId						)
VALUES		('GRAM_NESS_DIPLO_FAVOR_NATURAL_WONDERS',			'MODIFIER_GRAM_FAVOR_NATURAL_WONDERS',			
			'REQSET_GRAM_MAP_HAS_NATURAL_WONDER',				'REQSET_GRAM_CITY_OWNS_NATURAL_WONDER'		),
			('GRAM_NESS_GIVE_DIPLO_FAVOR',						'MODIFIER_GRAM_NESS_GIVE_DIPLO_FAVOR'		),
			NULL,												NULL										),
			('GRAM_NESS_GIVE_CULTURE',							'MODIFIER_GRAM_NESS_GIVE_CULTURE'			),
			NULL,												NULL										);



INSERT INTO DynamicModifiers
			(ModifierType,								CollectionType,					EffectType										)
VALUES		('MODIFIER_GRAM_FAVOR_NATURAL_WONDERS',		'COLLECTION_PLAYER_CITIES',		'EFFECT_ADJUST_PLAYER_EXTRA_FAVOR_PER_TURN'		),
			('MODIFIER_GRAM_GIVE_DIPLO_FAVOR',			'COLLECTION_OWNER',				'EFFECT_ADD_PLAYER_FAVOR'						),
			('MODIFIER_GRAM_GIVE_CULTURE',				'COLLECTION_OWNER',				'EFFECT_ADJUST_PLAYER_YIELD_CHANGE'				);



INSERT INTO ModifierArguments
			(ModifierId,								Name,			Value		)
VALUES		('GRAM_NESS_DIPLO_FAVOR_NATURAL_WONDERS',	'Amount',		'2'			),
			('GRAM_NESS_GIVE_DIPLO_FAVOR',				'Amount',		'50'		),
			('GRAM_NESS_GIVE_CULTURE',					'Amount',		'50'		);
		


INSERT INTO RequirementSets
			(RequirementSetId,								RequirementSetType					)
VALUES		('REQSET_GRAM_CITY_OWNS_NATURAL_WONDER',		'REQUIREMENTSET_TEST_ANY'			),
			('REQSET_GRAM_MAP_HAS_NATURAL_WONDER',			'REQUIREMENTSET_TEST_ANY'			);



INSERT INTO Requirements
			(RequirementId,									RequirementType						)
SELECT		'REQUIREMENT_GRAM_CITY_OWNS_' || FeatureType,	'REQUIREMENT_CITY_HAS_FEATURE'	
FROM Features WHERE NaturalWonder = '1';


INSERT INTO Requirements
			(RequirementId,									RequirementType						)
SELECT		'REQUIREMENT_GRAM_MAP_HAS_' || FeatureType,		'REQUIREMENT_MAP_HAS_FEATURE'	
FROM Features WHERE NaturalWonder = '1';



INSERT INTO RequirementArguments
			(RequirementId,			Name,				Value					)
SELECT		R1.RequirementId,		'FeatureType',		F1.FeatureType	
FROM Requirements R1, Features F1 WHERE R1.RequirementId LIKE 'REQUIREMENT_GRAM_CITY_OWNS_%' AND substr(R1.RequirementId, 28) = F1.FeatureType AND  F1.NaturalWonder = '1';	



INSERT INTO RequirementArguments
			(RequirementId,			Name,				Value					)
SELECT		R1.RequirementId,		'FeatureType',		F1.FeatureType	
FROM Requirements R1, Features F1 WHERE R1.RequirementId LIKE 'REQUIREMENT_GRAM_MAP_HAS_%' AND substr(R1.RequirementId, 26) = F1.FeatureType AND  F1.NaturalWonder = '1';	



INSERT INTO RequirementSetRequirements
			(RequirementSetId,							RequirementId	)
SELECT		'REQSET_GRAM_CITY_OWNS_NATURAL_WONDER',		RequirementId
FROM Requirements WHERE RequirementId LIKE 'REQUIREMENT_GRAM_CITY_OWNS_%';



INSERT INTO RequirementSetRequirements
			(RequirementSetId,							RequirementId	)
SELECT		'REQSET_GRAM_MAP_HAS_NATURAL_WONDER',		RequirementId
FROM Requirements WHERE RequirementId LIKE 'REQUIREMENT_GRAM_MAP_HAS_%';
-- Units
-- Author: Anagram
-- DateCreated: 4/8/2023 4:41:47 PM
--------------------------------------------------------------

INSERT INTO Types
			(Type,									Kind			)
VALUES		('UNIT_GRAM_PSYCHIC',					'KIND_UNIT'		),
			('TRAIT_LEADER_GRAM_PSYCHIC',			'KIND_TRAIT'	),
			('ABILITY_GRAM_PSYCHIC',				'KIND_ABILITY'	),

			('UNIT_GRAM_ESCARGOMAN',				'KIND_UNIT'		),
			('TRAIT_CIVILIZATION_GRAM_ESCARGOMAN',	'KIND_TRAIT'	),
			('ABILITY_GRAM_ESCARGOMAN',				'KIND_ABILITY'	);



INSERT INTO Tags
			(Tag,						Vocabulary				)
VALUES		('CLASS_GRAM_PSYCHIC',		'ABILITY_CLASS'			),
			('CLASS_GRAM_ESCARGOMAN',	'ABILITY_CLASS'			);



INSERT INTO TypeTags
			(Type,						Tag						)
VALUES		('UNIT_GRAM_PSYCHIC',		'CLASS_GRAM_PSYCHIC'	),
			('ABILITY_GRAM_PSYCHIC',	'CLASS_GRAM_PSYCHIC'	),

			('UNIT_GRAM_ESCARGOMAN',	'CLASS_GRAM_ESCARGOMAN'	),
			('ABILITY_GRAM_ESCARGOMAN',	'CLASS_GRAM_ESCARGOMAN'	);



INSERT INTO TypeTags (Type,			Tag)
SELECT		'UNIT_GRAM_ESCARGOMAN', Tag
FROM		TypeTags
WHERE		Type = 'UNIT_BUILDER';



INSERT INTO Traits
			(TraitType,									Name,										Description								)
VALUES		('TRAIT_LEADER_GRAM_PSYCHIC',				'LOC_LEADER_GRAM_PSYCHIC_NAME',				'LOC_LEADER_GRAM_PSYCHIC_DESC'			),
			('TRAIT_CIVILIZATION_GRAM_ESCARGOMAN',		'LOC_CIVILIZATION_GRAM_ESCARGOMAN_NAME',	'LOC_CIVLIZATION_GRAM_ESCARGOMAN_DESC'	);



INSERT INTO LeaderTraits
			(LeaderType,					TraitType							)
VALUES		('LEADER_GRAM_NESS',			'TRAIT_LEADER_GRAM_PSYCHIC'			);



INSERT INTO CivilizationTraits
			(CivilizationType,				TraitType								)	
VALUES		('CIVILIZATION_GRAM_EAGLELAND',	'TRAIT_CIVILIZATION_GRAM_ESCARGOMAN'	);



INSERT INTO Units 
				(UnitType,			
				Name,
				Description,
				TraitType,
				BaseMoves, Combat, BaseSightRange,	ZoneOfControl,	Domain,			FormationClass,
				PromotionClass,						Maintenance,	CanTrain,		Cost							)
VALUES			('UNIT_GRAM_PSYCHIC',
				'LOC_UNIT_GRAM_PSYCHIC_NAME',	
				'LOC_UNIT_GRAM_PSYCHIC_DESC',
				'TRAIT_LEADER_GRAM_PSYCHIC',
				2,			18,		2,				1,				'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',
				'PROMOTION_CLASS_MELEE',			1,				0,		0										);		
				
INSERT INTO	UnitAiInfos
			(UnitType,				AiType				)
VALUES		('UNIT_GRAM_PSYCHIC',	'UNITTYPE_MELEE'	),
			('UNIT_GRAM_PSYCHIC',	'UNITAI_COMBAT'		);		



INSERT INTO Units
				(UnitType,
				Name,
				Description,
				TraitType,
				BaseMoves,	BaseSightRange,	ZoneOfControl,	Domain,	FormationClass,	AdvisorType,	CanCapture, 
				Cost,	CostProgressionModel,	CostProgressionParam1,	PurchaseYield,	BuildCharges)
SELECT			'UNIT_GRAM_ESCARGOMAN',
				'LOC_UNIT_GRAM_ESCARGOMAN_NAME',
				'LOC_UNIT_GRAM_ESCARGOMAN_DESC',
				'TRAIT_CIVILIZATION_GRAM_ESCARGOMAN',
				BaseMoves,	BaseSightRange,	ZoneOfControl,	Domain,	FormationClass,	AdvisorType,	CanCapture, 
				30,		CostProgressionModel,	CostProgressionParam1,	PurchaseYield,	BuildCharges + 1
FROM			Units
WHERE			UnitType = 'UNIT_BUILDER';

INSERT INTO UnitAiInfos
			(UnitType,					AiType				)
VALUES		('UNIT_GRAM_ESCARGOMAN',	'UNITTYPE_CIVILIAN'	),
			('UNIT_GRAM_ESCARGOMAN',	'UNITAI_BUILD'	);

INSERT INTO UnitReplaces
			(CivUniqueUnitType,			ReplacesUnitType)
VALUES		('UNIT_GRAM_ESCARGOMAN',	'UNIT_BUILDER'	);

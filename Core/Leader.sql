-- Leader
-- Author: Anagram
-- DateCreated: 4/8/2023 5:50:42 PM
--------------------------------------------------------------

INSERT INTO Types
			(Type,										Kind			)
VALUES		('LEADER_GRAM_NESS',						'KIND_LEADER'	),
			('TRAIT_AGENDA_GRAM_NATURALLY_FRIENDLY',	'KIND_TRAIT'	);



INSERT INTO Leaders
			(LeaderType				Name,							InheritFrom,			SceneLayers	)
VALUES		('LEADER_GRAM_NESS',	'LOC_LEADER_GRAM_NESS_NAME',	'LEADER_DEFAULT',		4			);



INSERT INTO CivilizationLeaders
			(CivilzationType,					LeaderType,					CapitalName						)
VALUES		('CIVILIZATION_GRAM_EAGLELAND',		'LEADER_GRAM_NESS',			'LOC_CITY_NAME_GRAM_EAGLELAND_1');



INSERT INTO LeaderQuotes
			(LeaderType,			Quote										)
VALUES		('LEADER_GRAM_NESS',	'LOC_PEDIA_LEADERS_PAGE_GRAM_NESS_QUOTE'	);



INSERT INTO Agendas
			(AgendaType,								Name,											Description									)
VALUES		('AGENDA_GRAM_NATURALLY_FRIENDLY',			'LOC_AGENDA_GRAM_NATURALLY_FRIENDLY_NAME',		'LOC_AGENDA_GRAM_NATURALLY_FRIENDLY_DESC'	);



INSERT INTO Traits
			(TraitType,									Name											Description									)
VALUES		('TRAIT_AGENDA_GRAM_NATURALLY_FRIENDLY',	'LOC_AGENDA_GRAM_NATURALLY_FRIENDLY_NAME',		'LOC_AGENDA_GRAM_NATURALLY_FRIENDLY_DESC'	);



INSERT INTO AgendaTraits
			(AgendaType,							TraitType										)
VALUES		('AGENDA_GRAM_NATURALLY_FRIENDLY',		'TRAIT_AGENDA_GRAM_NATURALLY_FRIENDLY'			);	



INSERT INTO HistoricalAgendas
			(LeaderType					AgendaType								)
VALUES		('LEADER_GRAM_NESS',		'AGENDA_GRAM_NATURALLY_FRIENDLY'		);



INSERT INTO ExclusiveAgendas
			(AgendaOne,									AgendaTwo				)
VALUES		('AGENDA_GRAM_NATURALLY_FRIENDLY',			'AGENDA_PARANOID'		);



INSERT INTO AgendaPreferredLeaders
			(AgendaType,								LeaderType,						PercentChance	)
VALUES		('AGENDA_NATURALIST',						'LEADER_GRAM_NESS',				66				);



INSERT INTO TraitModifiers
			(TraitType,									ModifierId										)
VALUES		('TRAIT_AGENDA_GRAM_NATURALLY_FRIENDLY',	'AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET'	),
			('TRAIT_AGENDA_GRAM_NATURALLY_FRIENDLY',	'AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET'	);



INSERT INTO Modifiers
			(ModifierId,										ModifierType									SubjectRequireMentSetId					)
VALUES		('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'REQSET_GRAM_NATURALLY_FRIENDLY_UNMET'	),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER',	'REQSET_GRAM_NATURALLY_FRIENDLY_MET'	);



INSERT INTO ModifierStrings
			(ModifierId,										Context,	Text								)
VALUES		('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'	),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'Sample',	'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'	);



INSERT INTO ModifierArguments
			(ModifierId,										Name,							Value												),
VALUES		('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'InitialValue',					0												),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'MaxValue',						0													),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'StatementKey',					'LOC_DIPLO_WARNING_LEADER_GRAM_NESS_REASON_ANY'		),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET',	'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_GRAM_NATURALLY_FRIENDLY_UNMET'	),

			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'InitialValue',					5													),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'MaxValue',						40													),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'IncrementValue',				5													),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'IncrementTurns',				15													),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'StatementKey',					'LOC_DIPLO_KUDO_LEADER_GRAM_NESS_REASON_ANY'		),
			('AGENDA_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET',		'SimpleModifierDescription',	'LOC_DIPLO_MODIFIER_GRAM_NATURALLY_FRIENDLY_MET'	);



INSERT INTO RequirementSets
			(RequirementSetId,									RequirementSetType				)
VALUES		('REQSET_GRAM_NATURALLY_FRIENDLY_UNMET',			'REQUIREMENTSET_TEST_ALL'		),
			('REQSET_GRAM_NATURALLY_FRIENDLY_MET',				'REQUIREMENTSET_TEST_ALL'		);



INSERT INTO RequirementSetRequirements
			(RequirementSetId									RequirmentId							)
VALUES		('REQSET_GRAM_NATURALLY_FRIENDLY_UNMET',			'REQUIRES_MET_10_TURNS_AGO'				),
			('REQSET_GRAM_NATURALLY_FRIENDLY_UNMET',			'REQUIRES_MAJOR_CIV_OPPONENT'			),
			('REQSET_GRAM_NATURALLY_FRIENDLY_UNMET',			'REQUIRES_WARMONGER_TRIGGER'			), 

			('REQSET_GRAM_NATURALLY_FRIENDLY_MET',				'REQUIRES_PLAYERS_HAVE_MET'				),
			('REQSET_GRAM_NATURALLY_FRIENDLY_MET',				'REQUIRES_MAJOR_CIV_OPPONENT'			);
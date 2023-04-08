-- Colors
-- Author: Anagram
-- DateCreated: 4/8/2023 1:59:55 PM
--------------------------------------------------------------

INSERT INTO Colors
			(Type,								Color			)
			--Vibrant Red/Blue
VALUES		('COLOR_GRAM_EAGLELAND_A_PRIMARY',	'97,3,34,255'	),
			('COLOR_GRAM_EAGLELAND_A_SECONDARY','53,44,97,255'	),
			--Faded Red/Blue
			('COLOR_GRAM_EAGLELAND_B_PRIMARY',	'97,38,40,255'	),
			('COLOR_GRAM_EAGLELAND_B_SECONDARY','56,61,80,255'	),
			--Yellow/Blue
			('COLOR_GRAM_EAGLELAND_C_PRIMARY',	'94,80,43,255'	),
			('COLOR_GRAM_EAGLELAND_C_SECONDARY','42,51,75,255'	),
			--Light Sky Blue/Faded Green (old Civ V colors)
			('COLOR_GRAM_EAGLELAND_D_PRIMARY',	'76,85,91,255'	),
			('COLOR_GRAM_EAGLELAND_D_SECONDARY','41,60,34,255'	);

INSERT INTO PlayerColors
			(Type,								Usage,
			PrimaryColor,						SecondaryColor,
			Alt1PrimayColor,					Alt1SecondaryColor,
			Alt2PrimayColor,					Alt2SecondaryColor,
			Alt3PrimayColor,					Alt3SecondaryColor					)
VALUES		('LEADER_GRAM_NESS',					'Unique',
			'COLOR_GRAM_EAGLELAND_A_PRIMARY',	'COLOR_GRAM_EAGLELAND_A_SECONDARY',
			'COLOR_GRAM_EAGLELAND_B_PRIMARY',	'COLOR_GRAM_EAGLELAND_B_SECONDARY',
			'COLOR_GRAM_EAGLELAND_C_PRIMARY',	'COLOR_GRAM_EAGLELAND_C_SECONDARY',
			'COLOR_GRAM_EAGLELAND_D_PRIMARY',	'COLOR_GRAM_EAGLELAND_D_SECONDARY'	);
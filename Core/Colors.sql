-- Colors
-- Author: Anagram
-- DateCreated: 4/8/2023 1:59:55 PM
--------------------------------------------------------------

INSERT INTO Colors
			(Type,								Color				)
			--Vibrant Red/Blue
VALUES		('COLOR_GRAM_EAGLELAND_A_PRIMARY',	'248,8,88,255'		),
			('COLOR_GRAM_EAGLELAND_A_SECONDARY','136,112,248,255'	),
			--Faded Red/Blue
			('COLOR_GRAM_EAGLELAND_B_PRIMARY',	'248,105,118,255'	),
			('COLOR_GRAM_EAGLELAND_B_SECONDARY','144,154,203,255'	),
			--Yellow/Blue
			('COLOR_GRAM_EAGLELAND_C_PRIMARY',	'247,218,103,255'	),
			('COLOR_GRAM_EAGLELAND_C_SECONDARY','101,133,193,255'	),
			--Light Sky Blue/Faded Green (old Civ V colors)
			('COLOR_GRAM_EAGLELAND_D_PRIMARY',	'205,224,239,255'	),
			('COLOR_GRAM_EAGLELAND_D_SECONDARY','116,161,94,255'	);

INSERT INTO PlayerColors
			(Type,								Usage,
			PrimaryColor,						SecondaryColor,
			Alt1PrimaryColor,					Alt1SecondaryColor,
			Alt2PrimaryColor,					Alt2SecondaryColor,
			Alt3PrimaryColor,					Alt3SecondaryColor					)
VALUES		('LEADER_GRAM_NESS',				'Unique',
			'COLOR_GRAM_EAGLELAND_A_PRIMARY',	'COLOR_GRAM_EAGLELAND_A_SECONDARY',
			'COLOR_GRAM_EAGLELAND_B_PRIMARY',	'COLOR_GRAM_EAGLELAND_B_SECONDARY',
			'COLOR_GRAM_EAGLELAND_C_PRIMARY',	'COLOR_GRAM_EAGLELAND_C_SECONDARY',
			'COLOR_GRAM_EAGLELAND_D_PRIMARY',	'COLOR_GRAM_EAGLELAND_D_SECONDARY'	);
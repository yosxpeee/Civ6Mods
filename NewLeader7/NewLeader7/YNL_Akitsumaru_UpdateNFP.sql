-- NFP対応

-- ニハングの戦闘力強化対象に帝国陸軍兵器廠を追加する
-- (なぜかUBが対象にはいってないらしい・・・)
INSERT INTO BuildingModifiers('BuildingType', 'ModifierId')
SELECT * FROM (SELECT 'BUILDING_IMP_ARMY_ARMORY', 'LAHORE_NIHANG_ARMORY_ABILITY') AS TMP
WHERE EXISTS (SELECT Type FROM Types WHERE Type = 'UNIT_LAHORE_NIHANG');

-- NFP�Ή�

-- �j�n���O�̐퓬�͋����Ώۂɒ鍑���R���폱��ǉ�����
-- (�Ȃ���UB���Ώۂɂ͂����ĂȂ��炵���E�E�E)
INSERT INTO BuildingModifiers('BuildingType', 'ModifierId')
SELECT * FROM (SELECT 'BUILDING_IMP_ARMY_ARMORY', 'LAHORE_NIHANG_ARMORY_ABILITY') AS TMP
WHERE EXISTS (SELECT Type FROM Types WHERE Type = 'UNIT_LAHORE_NIHANG');

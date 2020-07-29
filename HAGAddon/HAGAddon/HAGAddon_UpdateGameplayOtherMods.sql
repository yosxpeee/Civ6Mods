-- このSQLファイルは自作の他MODに対して本MODの仕様に合わせこむ処理を行っている。
-- 
-- Update文はキーがなければ更新されずに終わるが、INSERT文はキーがなければエラーになる。
-- これを回避するにはWHERE EXISTSを用いてキーとなるものが存在する場合のみINSERTという形にしなければならない。
-- XMLではそのような記述はできないと思われる。よってSQL直書き。

-- ========== 港湾棲姫 ==========
-- 深海装甲巡洋艦を本MODの仕様に合わせる
INSERT INTO UnitAiInfos('UnitType', 'AiType')
SELECT * FROM (SELECT 'UNIT_YNL_ARMORED_CRUISER', 'UNITTYPE_RANGED') AS TMP
WHERE EXISTS (SELECT Type FROM Types WHERE Type = 'UNIT_YNL_ARMORED_CRUISER');

UPDATE Units
SET Combat = 63, RangedCombat = 63, Range = 2, PromotionClass = 'PROMOTION_CLASS_NAVAL_RANGED'
WHERE UnitType = 'UNIT_YNL_ARMORED_CRUISER';

-- ========== 東北三姉妹 ==========
-- ずんだ弓騎兵のUG先変更
UPDATE UnitUpgrades
Set UpgradeUnit ='UNIT_CROSSBOWMAN'
WHERE Unit = 'UNIT_ZUNKO_HORSE_ARCHER';

-- ========== 長門/陸奥 ==========
-- 後々戦艦とミサイル巡洋艦の仕様変更が入るので、記述の必要あり

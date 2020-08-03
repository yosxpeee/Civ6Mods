-- このSQLファイルは自作の他MODに対して本MODの仕様に合わせこむ処理を行っている。
--
-- 主として説明文の更新なのでSQLにする必要はないのだが、Gameplay側に合わせた。

-- ========== 長門/陸奥 ==========
UPDATE PlayerItems
SET Description = 'LOC_UNIT_UNIQUE_BATTLESHIP_NAGATO_HAGA_DESCRIPTION'
WHERE CivilizationType = 'CIVILIZATION_PEOPLESOFTHESEA' AND LeaderType = 'LEADER_YNL_NAGATO' AND Type = 'UNIT_UNIQUE_BATTLESHIP_NAGATO';

UPDATE PlayerItems
SET Description = 'LOC_UNIT_UNIQUE_BATTLESHIP_NAGATO_HAGA_DESCRIPTION'
WHERE CivilizationType = 'CIVILIZATION_PEOPLESOFTHESEA' AND LeaderType = 'LEADER_YNL_MUTSU' AND Type = 'UNIT_UNIQUE_BATTLESHIP_NAGATO';

--------------------------------------------------------------
-- EraChanged
--------------------------------------------------------------
-- 時代が進んだ時
function EraChanged(playerId, EraId)
	local pPlayer = Players[playerId]
	local playerConfig = PlayerConfigurations[playerId]
	local capitalCity = pPlayer:GetCities():GetCapitalCity()

	if ((playerConfig ~= nil) and (playerConfig:GetCivilizationTypeName() == "CIVILIZATION_PEOPLESOFTHESEA")) then
		local tEraGameInfo = GameInfo.Eras[EraId]
		if ((tEraGameInfo ~= nil) and (tEraGameInfo.EraType ~= "ERA_ANCIENT")) then
			-- 首都の座標に開拓者をPOPさせる
			pPlayer:GetUnits():Create(tonumber(GameInfo.Units["UNIT_BUILDER"].Index), capitalCity:GetX(), capitalCity:GetY())
		end
	end
end

-- ↑の関数をイベントを差し込む
Events.PlayerEraChanged.Add(EraChanged)
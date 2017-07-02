function EraChanged(playerId, EraId)
	local pPlayer = Players[playerId]
	local playerConfig = PlayerConfigurations[playerId]
	local capitalCity = pPlayer:GetCities():GetCapitalCity()

	if playerConfig:GetCivilizationTypeName() == "CIVILIZATION_PEOPLESOFTHESEA" then
		pPlayer:GetUnits():Create(tonumber(GameInfo.Units["UNIT_BUILDER"].Index), capitalCity:GetX(), capitalCity:GetY())
	end
end
Events.PlayerEraChanged.Add(EraChanged)
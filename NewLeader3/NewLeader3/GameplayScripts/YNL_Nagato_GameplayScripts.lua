--------------------------------------------------------------
-- EraChanged
--------------------------------------------------------------
-- ���オ�i�񂾎�
function EraChanged(playerId, EraId)
	local pPlayer = Players[playerId]
	local playerConfig = PlayerConfigurations[playerId]
	local capitalCity = pPlayer:GetCities():GetCapitalCity()

	if ((playerConfig ~= nil) and (playerConfig:GetCivilizationTypeName() == "CIVILIZATION_PEOPLESOFTHESEA")) then
		local tEraGameInfo = GameInfo.Eras[EraId]
		if ((tEraGameInfo ~= nil) and (tEraGameInfo.EraType ~= "ERA_ANCIENT")) then
			-- ��s�̍��W�ɊJ��҂�POP������
			pPlayer:GetUnits():Create(tonumber(GameInfo.Units["UNIT_BUILDER"].Index), capitalCity:GetX(), capitalCity:GetY())
		end
	end
end

-- ���̊֐����C�x���g����������
Events.PlayerEraChanged.Add(EraChanged)
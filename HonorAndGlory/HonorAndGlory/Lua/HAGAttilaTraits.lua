--------------------------------------------------------------
-- HAGAttilaTraits
--------------------------------------------------------------
include("CitySupport");

-- Luaイベントを叩くためのおまじない
ExposedMembers.LuaEvents = LuaEvents

-- 都市を陥落させたとき
function OnCityConquered(iVictoriousPlayer, iNewCityID)
	local pVictoriousPlayer = Players[iVictoriousPlayer]
	if not pVictoriousPlayer then
		return
	end
	local playerConfig = PlayerConfigurations[iVictoriousPlayer]
	local leaderType = playerConfig:GetLeaderTypeName()
	if (leaderType == "LEADER_HAG_ATTILA") then
		local pThisCity = CityManager.GetCity(iVictoriousPlayer, iNewCityID)
		if (not pThisCity) then
			return
		end
		if (pThisCity:GetOriginalOwner() ~= iVictoriousPlayer) then
			-- 都市を破壊する
			local tDidRazeComplete = {}
			tDidRazeComplete[0] = false
			LuaEvents.HAGAttila_GameplayScriptCalled(iVictoriousPlayer, iNewCityID, tDidRazeComplete);
			if (tDidRazeComplete[0] == true) then
				-- 破壊した都市の人口に応じたゴールド(ゲームスピード依存)を入手して強制破壊
				-- このとき参照される人口は都市が陥落して減った後のもの
				local pVictorPlayer = Players[iVictoriousPlayer]
				local eGameSpeed = GameConfiguration.GetGameSpeedType();
				local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier;
				print("iSpeedCostMultiplier: "..tostring(iSpeedCostMultiplier))
				-- iSpeedCostMultiplier
				-- * オンライン：50
				-- * 標準　　　：100
				-- * 非常に遅い：300
				population = pThisCity:GetPopulation()
				print("City Population: "..tostring(population))
				gold = population * iSpeedCostMultiplier * 2
				print("Get gold: "..tostring(gold))
				pVictorPlayer:GetTreasury():ChangeGoldBalance(gold);
				Game.AddWorldViewText(0, "[COLOR_FLOAT_GOLD]+"..gold.." [ICON_Gold][ENDCOLOR]", pThisCity:GetX(), pThisCity:GetY(), 3)
			end
		end
	end
end

-- 地形改善のIndexを取得
function GetGameInfoIndex(table_name, type_name)
	local index;local table = GameInfo[table_name];
	if(table) then
		local t = table[type_name];
		if(t) then
			index = t.Index;
		end
	end
	-- 蛮族の野営地:0が返る
	-- 原住民の集落:9が返る
	return index;
end

-- 原住民の集落or蛮族の野営地にユニットを重ねたとき
function OnImprovementActivated(iX, iY, PlayerID, iUnitID, iImprovementIndex, iImprovementOwner,iActivationType1, ActivationType2)
	local victorConfig = PlayerConfigurations[PlayerID]

	if (victorConfig ~= nil) and (victorConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA") then
		print("Player # " .. PlayerID.. " : activated of " .. iImprovementIndex)
		if iImprovementIndex == GetGameInfoIndex("Improvements", "IMPROVEMENT_BARBARIAN_CAMP") then
			-- 蛮族の野営地ならその近辺に開拓者をPOPさせる
			UnitManager.InitUnitValidAdjacentHex(PlayerID, "UNIT_SETTLER", iX, iY, 1);
		end
	end
end

-- イベントに↑の関数を差し込む
Events.CityInitialized.Add(OnCityConquered)
Events.ImprovementActivated.Add(OnImprovementActivated);

print("HAGAttilaTraits.lua loaded successfully.")
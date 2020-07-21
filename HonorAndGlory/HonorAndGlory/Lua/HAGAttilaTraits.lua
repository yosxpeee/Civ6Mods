--------------------------------------------------------------
-- HAGAttilaTraits
--------------------------------------------------------------
-- 都市を陥落させたとき
function CityWasConquered(VictorID, LoserID, CityID, iCityX, iCityY)
	local playerConfig = PlayerConfigurations[VictorID]

	if playerConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA" then
		local pPlayer = Players[VictorID]
		local pCity =  pPlayer:GetCities():FindID(CityID)
		local sCity_LOC = pCity:GetName()
		print("Player # " .. VictorID.. " : captured the city of " .. Locale.Lookup(sCity_LOC))
		print("Player # " .. LoserID .. " lost the city")
		print("The city is located at (or used to be located at) grid X" .. iCityX .. ", Y" .. iCityY )

		-- 都市の人口に応じたゴールド(ゲームスピード依存)を入手して強制破壊
		-- このとき参照される人口は都市が陥落して減った後のもの
		local eGameSpeed = GameConfiguration.GetGameSpeedType();
		local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier;
		print("iSpeedCostMultiplier: "..tostring(iSpeedCostMultiplier))
		-- iSpeedCostMultiplier
		-- * オンライン：50
		-- * 標準　　　：100
		-- * 非常に遅い：300
		population = pCity:GetPopulation()
		print("City Population: "..tostring(population))
		gold = population * iSpeedCostMultiplier
		print("Get gold: "..tostring(gold))
		pPlayer:GetTreasury():ChangeGoldBalance(gold);
		
		if pPlayer == Game.GetLocalPlayer() then
			--プレイヤー操作時の場合、UI出したままだとアクセス違反がでるっぽいので都市選択を解除してから壊す
			UI.DeselectAllCities();
			CityManager.DestroyCity(pCity)
			UI.PlaySound("RAZE_CITY");
		else
			CityManager.DestroyCity(pCity)
		end
		print("Destroy City: ".. Locale.Lookup(sCity_LOC))
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
	local playerConfig = PlayerConfigurations[PlayerID]

	if playerConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA" then
		print("Player # " .. PlayerID.. " : activated of " .. iImprovementIndex)
		if iImprovementIndex == GetGameInfoIndex("Improvements", "IMPROVEMENT_BARBARIAN_CAMP") then
			-- 蛮族の野営地ならその近辺に開拓者をPOPさせる
			UnitManager.InitUnitValidAdjacentHex(PlayerID, "UNIT_SETTLER", iX, iY, 1);
		end
	end
end

-- イベントに↑の関数を差し込む
Events.ImprovementActivated.Add(OnImprovementActivated);
GameEvents.CityConquered.Add(CityWasConquered)

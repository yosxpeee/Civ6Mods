--------------------------------------------------------------
-- HAGCityNameHuns
--------------------------------------------------------------
function OnCityBuilt( playerID: number, cityID : number, cityX : number, cityY : number )	
	local playerConfig = PlayerConfigurations[playerID]

	if playerConfig:GetCivilizationTypeName() == "CIVILIZATION_HAG_HUNS" then
		local pPlayer = Players[playerID]
		local pBuiltCity = CityManager.GetCity(playerID, cityID);
		local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
		
		print(tostring(cityID))
		-- 書き換える処理
		if (pCapitalCity == nil) then
			print("this is capital city.")
		else
			print("this is not capital city.")

			local results	:table;
			local name		:string;
			-- DB直叩きで自身の文明以外の都市名をランダムで1つ取ってくる
			results = DB.Query("SELECT CityName FROM CityNames WHERE CivilizationType != 'CIVILIZATION_HAG_HUNS' ORDER BY RANDOM() LIMIT 1");
			for i, row in ipairs(results) do
				name = row.CityName;
				break;
			end
			print(Locale.Lookup(name))
			pBuiltCity:SetName(Locale.Lookup(name));
		end
	end
end

-- ゲームイベントに↑の関数を差し込む
-- ※CityBuilt()は都市を落としたときにも動くが、ゲームの進行に影響しないので気にしないこととする
GameEvents.CityBuilt.Add(OnCityBuilt);

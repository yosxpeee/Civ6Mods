--------------------------------------------------------------
-- HAGCityNameHuns
--------------------------------------------------------------
function OnCityBuilt( playerID: number, cityID : number, cityX : number, cityY : number )	
	local playerConfig = PlayerConfigurations[playerID]

	if playerConfig:GetCivilizationTypeName() == "CIVILIZATION_HAG_HUNS" then
		local pPlayer = Players[playerID]
		local pBuiltCity = CityManager.GetCity(playerID, cityID);
		local pCapitalCity = pPlayer:GetCities():GetCapitalCity()

		print("City ID:"..tostring(cityID))
		-- 首都がないときは何もしない(一番最初に建てたとき)
		if (pCapitalCity == nil) then
			print("this is first built.")
			return
		end
		-- 元は他文明の都市だった場合も何もしない
		-- (都市破壊前の占領判定時。最初の首都以外は自動破壊、最初の首都だった場合は書き換えをしないこととする)
		if (pBuiltCity:GetOriginalOwner() ~= pBuiltCity:GetOwner()) then
			print("original owner is not you.")
			return
		end

		-- 書き換える処理
		print("Rename city.")
		local results	:table;
		local name		:string;
		-- DB直叩きで自身の文明以外の都市名をランダムで1つ取ってくる
		-- ※SQLiteにおいてORDER BY RANDOM()は非常に遅いのだが、
		--   MODを大量に入れた状態でも遅いとは感じないのでとりあえず問題はなさそう
		results = DB.Query("SELECT CityName FROM CityNames WHERE CivilizationType != 'CIVILIZATION_HAG_HUNS' ORDER BY RANDOM() LIMIT 1");
		for i, row in ipairs(results) do
			name = row.CityName;
			break;
		end
		print(Locale.Lookup(name))
		pBuiltCity:SetName(Locale.Lookup(name));
	end
end

-- ゲームイベントに↑の関数を差し込む
-- ※CityBuilt()は都市を落としたときにも動く。自分で建てた都市を奪還した場合にも動作してしまうが仕様とする。
--   ・新規建造なのか都市の奪還なのかを区別するAPIがない。
--   ・建てたときの都市名やIDを覚えても判定材料にできない。
--     都市名はプレイヤーであれば自由に変えられる。
--     都市のIDは都市の所属が変わるとIDも変わってしまう。
GameEvents.CityBuilt.Add(OnCityBuilt);

print("HAGCityNameHuns.lua loaded successfully.")

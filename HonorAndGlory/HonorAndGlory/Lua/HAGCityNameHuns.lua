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
		-- ñ“s‚ª‚È‚¢‚Æ‚«‚Í‰½‚à‚µ‚È‚¢(ˆê”ÔÅ‰‚ÉŒš‚Ä‚½‚Æ‚«)
		if (pCapitalCity == nil) then
			print("this is first built.")
			return
		end
		-- Œ³‚Í‘¼•¶–¾‚Ì“ss‚¾‚Á‚½ê‡‚à‰½‚à‚µ‚È‚¢
		-- (“ss”j‰ó‘O‚Ìè—Ì”»’èBñ“sˆÈŠO‚Í©“®”j‰óAñ“s‚¾‚Á‚½ê‡‚Í‘‚«Š·‚¦‚ğ‚µ‚È‚¢‚±‚Æ‚Æ‚·‚é)
		if (pBuiltCity:GetOriginalOwner() ~= pBuiltCity:GetOwner()) then
			print("original owner is not you.")
			return
		end

		-- ‘‚«Š·‚¦‚éˆ—
		print("Rename city.")

		local results	:table;
		local name		:string;
		-- DB’¼’@‚«‚Å©g‚Ì•¶–¾ˆÈŠO‚Ì“ss–¼‚ğƒ‰ƒ“ƒ_ƒ€‚Å1‚Âæ‚Á‚Ä‚­‚é
		-- ¦SQLite‚É‚¨‚¢‚ÄORDER BY RANDOM()‚Í”ñí‚É’x‚¢‚Ì‚¾‚ªA
		--   MOD‚ğ‘å—Ê‚É“ü‚ê‚½ó‘Ô‚Å‚à’x‚¢‚Æ‚ÍŠ´‚¶‚È‚¢‚Ì‚Å‚Æ‚è‚ ‚¦‚¸–â‘è‚Í‚È‚³‚»‚¤
		results = DB.Query("SELECT CityName FROM CityNames WHERE CivilizationType != 'CIVILIZATION_HAG_HUNS' ORDER BY RANDOM() LIMIT 1");
		for i, row in ipairs(results) do
			name = row.CityName;
			break;
		end
		print(Locale.Lookup(name))
		pBuiltCity:SetName(Locale.Lookup(name));
	end
end

-- ƒQ[ƒ€ƒCƒxƒ“ƒg‚Éª‚ÌŠÖ”‚ğ·‚µ‚Ş
-- ¦CityBuilt()‚Í“ss‚ğ—‚Æ‚µ‚½‚Æ‚«‚É‚à“®‚­B©•ª‚ÅŒš‚Ä‚½“ss‚ğ’DŠÒ‚µ‚½ê‡‚É‚à“®ì‚µ‚Ä‚µ‚Ü‚¤‚ªd—l‚Æ‚·‚éB
GameEvents.CityBuilt.Add(OnCityBuilt);

print("HAGCityNameHuns.lua loaded successfully.")

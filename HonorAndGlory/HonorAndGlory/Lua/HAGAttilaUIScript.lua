--------------------------------------------------------------
-- HAGAttilaUIScript
--------------------------------------------------------------
include("Civ6Common");
include("CitySupport");

-- UIのLuaスクリプトを読み込むためのおまじない
LuaEvents = ExposedMembers.LuaEvents

function HAGAttila_OnHAGAttilaGameplayScriptCalled(iVictorPlayer, iCity, tReturn)
	local pThisCity = CityManager.GetCity(iVictorPlayer, iCity)
	local tParameters = {};
	tParameters[UnitOperationTypes.PARAM_FLAGS] = 3;
	-- 都市を破壊する条件
	-- 破壊するコマンドを開始できること、かつその都市が最初の首都でないか都市国家であること
	local bOriginalCapital = pThisCity:IsOriginalCapital()
	local bCanStartCommand = CityManager.CanStartCommand(pThisCity, CityCommandTypes.DESTROY, tParameters)
	local iOriginOwner = pThisCity:GetOriginalOwner()
	local pOriginPlayer = Players[iOriginOwner]
	local bMajor = pOriginPlayer:IsMajor()
	print("#bCanStart=" .. tostring(bCanStartCommand) .. ", #bOrig=" .. tostring(bOriginalCapital) .. ", #bMajor=" .. tostring(bMajor))
	if (bCanStartCommand and ((bOriginalCapital == false) or (bOriginalCapital == true and bMajor == false))) then
		if iVictorPlayer == Game.GetLocalPlayer() then
			print("Destroy City(Player).")
			UI.DeselectAllCities();
			CityManager.RequestCommand(pThisCity, CityCommandTypes.DESTROY, tParameters);
			UI.PlaySound("RAZE_CITY");
		else
			print("Destroy City(AI).")
			CityManager.RequestCommand(pThisCity, CityCommandTypes.DESTROY, tParameters);
		end
		tReturn[0] = true
	else	
		print("This city can not destroy.")
	end
end

-- イベントが呼ばれたときに呼び出す関数をセット
LuaEvents.HAGAttila_GameplayScriptCalled.Add(HAGAttila_OnHAGAttilaGameplayScriptCalled);

print("HAGAttilaUIScript.lua loaded successfully.")

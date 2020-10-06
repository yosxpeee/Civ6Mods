
include "MapUtilities"

-- ===========================================================================
function InitializeNewGame()

	local gridWidth, gridHeight = Map.GetGridSize();
	AddGoodies(gridWidth, gridHeight);

end

LuaEvents.NewGameInitialized.Add(InitializeNewGame);

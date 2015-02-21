local IniFile = cIniFile()
local PLUGIN
function Initialize( Plugin )
	Plugin:SetName( "HighJump" )
	Plugin:SetVersion( 1.1 )
	local PluginManager = cPluginManager:Get()
	PluginManager.AddHook( cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving )
	PLUGIN = Plugin
	isjump = 0
	if (IniFile:ReadFile("Plugins/HighJump/settings.ini")) then
		JumpSpeed = IniFile:GetValueI("Jump", "speed")
	end
	LOG( "Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion() .. " by Def-System.ovh" )
	return true
end

function OnPlayerMoving(Player)
	if(Player:IsOnGround() == false) and (Player:IsGameModeCreative() == false) and (Player:CanFly() == false) and (isjump ~= 5) then
		Player:SetFlying(true)
		Player:SetFlyingMaxSpeed(JumpSpeed)
		isjump = isjump + 1
	end
	if(Player:IsFlying() == true) and (isjump == 5) then
		Player:SetCanFly(false)
		Player:SetFlying(false)
	end
	if(Player:IsOnGround() == true)then
		isjump = 0
	end
end

---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false
local hole_in_map = false

Config = {}
Config.Commands = true  -- For testing set to false for live server
Config.TeleportME = true -- For testing set to false for live server 

Config.House = true
Config.Bushes = true
Config.Construction = true
Config.Unknow = false

Config.Label = "Emerald Ranch Cabin"
Config.x = 1648.755
Config.y = 473.437
Config.z = 99.8124  

 
----------- turn on the bar ------
function EnableResouresYMAPS()   
    if  Config.House == true then  
        RequestImap(-1377975054) -- Ground for house 
        RequestImap(-574996782)    -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- House Shell/Front Enterence
        RequestImap(1169511062)    -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- House Interior 
        hole_in_map = true
    else 
        RequestImap(-165202905) -- Ground for no house    
        hole_in_map = true
    end 

    if  Config.Construction == true then    
        RequestImap(-1266106154) -- Planks piled up on south wall of house and the fence...
    else 
    end 

    if  Config.Unknow == true then    
        RequestImap(-1965378386)   -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- Grass Over Hole 
    else 

    end 

    if  Config.Bushes == true then   
        RequestImap(897624424) -- Bushes out front
        RequestImap(-1327148782) -- Bushes out back     
    else 
    end 

    -- there's a fence missing 

end

function EnableResouresINTERIORS(x, y, z)  
    --[[ -- template
    local interior = GetInteriorAtCoords(x, y, z)  --- teleportme 1450.0452 372.4734 89.6804
    ActivateInteriorEntitySet(interior, "here_kitty_4_props")  -- 1958681082   -- dragon -- this spawns the cats at emerald 
    --]]
end

----------- turn off the bar ------
function DisableResourcesYMAPS()
    -- none for this set
    RemoveImap(-574996782)    -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- House Shell/Front Enterence
    RemoveImap(1169511062)    -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- House Interior
 
    RemoveImap(-1266106154) -- Planks piled up on south wall of house 

    RemoveImap(897624424) -- Bushes out front
    RemoveImap(-1327148782) -- Bushes out back   

    RemoveImap(-165202905) -- Ground for no house     
    RemoveImap(-1377975054) -- Ground for house    
    RemoveImap(-1965378386)   -- New Hanover -- The Heartland -- Hole/Cabin East of Emerald Station -- unknown
end

function DisableResourcesINTERIORS(x, y, z)  
    --[[ -- template
    local interior = GetInteriorAtCoords(x, y, z)  --- teleportme 1450.0452 372.4734 89.6804  
    DeactivateInteriorEntitySet(interior, "here_kitty_4_props")  -- 1958681082   -- dragon -- this spawns the cats at emerald 
    --]]  
end    
  
-----------------------------------------------------
------ admin commands to control the bar ----------
--- add admind perms later
-----------------------------------------------------
RegisterCommand("turnon_er_cabin", function(source, args)    
    if Config.Commands == true then   
        TriggerEvent( "ER:turnon_er_cabin", "ok" ) 
    else 
        print("Turn On IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ER:turnon_er_cabin')
AddEventHandler('ER:turnon_er_cabin', function(no_String)  
	EnableResouresYMAPS() 
    EnableResouresINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end) 
  
RegisterCommand("turnoff_er_cabin", function(source, args)  
    if Config.Commands == true then       
        TriggerEvent( "ER:turnoff_er_cabin", "ok" ) 
    else 
        print("Turn Off IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ER:turnoff_er_cabin')
AddEventHandler('ER:turnoff_er_cabin', function(no_String)  
	DisableResourcesYMAPS()
    DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end)  

-----------------------------------------------------
---remove all on resource stop---
-----------------------------------------------------
AddEventHandler('onResourceStop', function(resource) 
    if resource == GetCurrentResourceName() then     
        -- when resource stops disable them, admin is restarting the script
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    end
end)

-----------------------------------------------------
--- clear all on resource start ---
-----------------------------------------------------
AddEventHandler('onResourceStart', function(resource) 
    if resource == GetCurrentResourceName() then         
        Citizen.Wait(3000)
        -- interiors loads all of these, so we need to disable them 
        DisableResourcesYMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
        Citizen.Wait(3000)       
        -- because the character is already logged in on resource "re"start
        character_selected = true
    end
end)
 

-----------------------------------------------------
-- Telport admin to the hosue location
-----------------------------------------------------
RegisterCommand("takemeto_er_cabin", function(source, args)    
    if args ~= nil then   
        local data =  source 
        local ped = PlayerPedId() 
        local coords = GetEntityCoords(ped)        
        if Config.TeleportME == true then 
            TriggerEvent( "ER:scottybeammeup", Config.x, Config.y, Config.z )
        else 
            print("Teleport Me is disabled in "..Config.Label)
        end 
    end
end)

RegisterNetEvent('ER:scottybeammeup')
AddEventHandler('ER:scottybeammeup', function(x,y,z)  
    local player = PlayerPedId() 
    Wait(800)
    DoScreenFadeOut(5000) 
    Wait(10000)
    SetEntityCoords(player, x, y, z)
    DoScreenFadeIn(5000)      
end)
 

-----------------------------------------------------
-- Trigger when character is selected
-----------------------------------------------------
RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid) 
	character_selected = true
end)


-----------------------------------------------------
-- Main thread that controls the script
-----------------------------------------------------
Citizen.CreateThread(function() 
    while character_selected == false do 
        Citizen.Wait(1000)
    end 
    DisableResourcesYMAPS() 
    DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    Citizen.Wait(3000)       
    if character_selected == true and interiorsActive == false then 
        -- basically run once after character has loadded in   
        EnableResouresYMAPS() 
        EnableResouresINTERIORS(Config.x, Config.y, Config.z)
        interiorsActive = true
    end
end)


 
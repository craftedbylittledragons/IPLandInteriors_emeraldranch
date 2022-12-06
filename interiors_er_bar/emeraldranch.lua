---------- Manual definitions ---  
local interiorsActive = false
local character_selected = false
Config = {}
Config.Commands = true  -- For testing set to false for live server
Config.TeleportME = true -- For testing set to false for live server
Config.Cats = true 
Config.Chairs = 1 -- options 1 or 2
Config.Curtains = 1 -- options 1 (up) or 2 (down)
Config.Label = "Emerald Ranch Bar"
Config.x = 1450.0452
Config.y = 0372.4734
Config.z = 0089.6804   

----------- turn on the bar ------
function EnableResouresIMAP() 
    -- none for this set
end

function EnableResouresINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  --- teleportme 1450.0452 372.4734 89.6804
    if Config.Curtains == 1 then 
        --- do nothing curtains will be up.
    else  -- curtains down loads 
        ActivateInteriorEntitySet(interior, "eme_saloon_intgroup_curtains") -- 608475431 -- curtains down, if omitted curtains up
    end 
    if Config.Chairs == 1 then 
        ActivateInteriorEntitySet(interior, "eme_saloon_intgroup_furniture")  -- 608475431  -- MK -- chairs are different in each furniture set
    else 
        ActivateInteriorEntitySet(interior, "eme_saloon_intgroup_furniture_mp")  -- 608475431 -- MK -- chairs are different in each furniture set
    end 
    if Config.Cats == true then 
        ActivateInteriorEntitySet(interior, "here_kitty_4_props")  -- 1958681082   -- dragon -- this spawns the cats at emerald 
    end 
end

----------- turn off the bar ------
function DisableResourcesIMAPS()
    -- none for this set
end

function DisableResourcesINTERIORS(x, y, z)  
    local interior = GetInteriorAtCoords(x, y, z)  --- teleportme 1450.0452 372.4734 89.6804
    if Config.Curtains == 1 then 
        --- do nothing curtains will be up.
    else  -- curtains down loads 
        DeactivateInteriorEntitySet(interior, "eme_saloon_intgroup_curtains") -- 608475431 -- curtains down, if omitted curtains up
    end 
    if Config.Chairs == 1 then 
        DeactivateInteriorEntitySet(interior, "eme_saloon_intgroup_furniture")  -- 608475431  -- MK -- chairs are different in each furniture set
    else 
        DeactivateInteriorEntitySet(interior, "eme_saloon_intgroup_furniture_mp")  -- 608475431 -- MK -- chairs are different in each furniture set
    end 
    if Config.Cats == true then 
        DeactivateInteriorEntitySet(interior, "here_kitty_4_props")  -- 1958681082   -- dragon -- this spawns the cats at emerald 
    end  
end    
 

-----------------------------------------------------
------ admin commands to control the bar ----------
--- add admind perms later
-----------------------------------------------------
RegisterCommand("turnonbar", function(source, args)    
    if Config.Commands == true then   
        TriggerEvent( "ERBAR:turnonbar", "ok" ) 
    else 
        print("Turn On IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ERBAR:turnonbar')
AddEventHandler('ERBAR:turnonbar', function(no_String)  
	EnableResouresIMAP() 
    EnableResouresINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end) 
  
RegisterCommand("turnoffbar", function(source, args)  
    if Config.Commands == true then       
        TriggerEvent( "ERBAR:turnoffbar", "ok" ) 
    else 
        print("Turn Off IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('ERBAR:turnoffbar')
AddEventHandler('ERBAR:turnoffbar', function(no_String)  
	DisableResourcesIMAPS()
    DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end)  

-----------------------------------------------------
---remove all on resource stop---
-----------------------------------------------------
AddEventHandler('onResourceStop', function(resource) 
    if resource == GetCurrentResourceName() then     
        -- when resource stops disable them, admin is restarting the script
        DisableResourcesIMAPS() 
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
        DisableResourcesIMAPS() 
        DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
        Citizen.Wait(3000)        
        -- because the character is already logged in on resource "re"start
        character_selected = true
    end
end)
 

-----------------------------------------------------
-- Telport admin to the hosue location
-----------------------------------------------------
RegisterCommand("takemetoemeraldranchbar", function(source, args)    
    if args ~= nil then   
        local data =  source 
        local ped = PlayerPedId() 
        local coords = GetEntityCoords(ped)        
        if Config.TeleportME == true then 
            TriggerEvent( "ERBAR:scottybeammeup", Config.x, Config.y, Config.z )
        else 
            print("Teleport Me is disabled in "..Config.Label)
        end 
    end
end)

RegisterNetEvent('ERBAR:scottybeammeup')
AddEventHandler('ERBAR:scottybeammeup', function(x,y,z)  
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
    if character_selected == true and interiorsActive == false then 
        -- basically run once after character has loadded in  
        EnableResouresIMAP() 
        EnableResouresINTERIORS(Config.x, Config.y, Config.z)
        interiorsActive = true
    end
end)
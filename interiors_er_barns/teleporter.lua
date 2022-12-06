-----------------------------------------------------
-- Telport admin to the hosue location
-----------------------------------------------------
RegisterCommand("takemeto_BizTemplate", function(source, args)    
    if args ~= nil then   
        local data =  source 
        local ped = PlayerPedId() 
        local coords = GetEntityCoords(ped)        
        if Config.TeleportME == true then 
            TriggerEvent( "BizTemplate:scottybeammeup", Config.x, Config.y, Config.z )
        else 
            print("Teleport Me is disabled in "..Config.Label)
        end 
    end
end)

RegisterNetEvent('BizTemplate:scottybeammeup')
AddEventHandler('BizTemplate:scottybeammeup', function(x,y,z)  
    local player = PlayerPedId() 
    Wait(800)
    DoScreenFadeOut(5000) 
    Wait(10000)
    SetEntityCoords(player, x, y, z)
    DoScreenFadeIn(5000)      
end)
 
 
--------------------------------------------------
-- Teleporters -----------------------------------
-------------------------------------------------- 
-- Enter Scene 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)    
        local player_coords = GetEntityCoords(PlayerPedId())   
        if Config.TeleportEnter_On == true then       
            if (Vdist(player_coords.x, player_coords.y, player_coords.z, Config.EnterRoom.x, Config.EnterRoom.y, Config.EnterRoom.z) < Config.TeleportDistance) then -- cords for door go here                
                DrawTxt(Config.TeleporterPrompt, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, Config.definedkey.hash) then -- Checks for key pressed
                    local player = PlayerPedId() 
                    DoScreenFadeOut(Config.FadeTimer)
                    Wait(Config.WaitTimer) 		
                    FreezeEntityPosition(player, true) -- freeze player  -- Player can fall through the map in certain situations	
                    SetEntityCoords(player, Config.ExitRoom.x, Config.ExitRoom.y, Config.ExitRoom.z)
                    SetEntityHeading(player, Config.EnterRoom.h)

                    Wait(Config.WaitTimer) -- wait for ymap to load 
                    DoScreenFadeIn(Config.FadeTimer) 
                    FreezeEntityPosition(player, false) -- unfreeze player. 
                end
            end
        end
    end
end)  -- close thread 
            
           
-- Exit Scene
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
        local player_coords = GetEntityCoords(PlayerPedId())  
        if Config.TeleportExit_On == true then   
            if (Vdist(player_coords.x, player_coords.y, player_coords.z, Config.ExitRoom.x, Config.ExitRoom.y, Config.ExitRoom.z) < Config.TeleportDistance) then -- cords for door go here
                DrawTxt(Config.TeleporterPrompt, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, Config.definedkey.hash) then -- Checks for key pressed
                    local player = PlayerPedId() 
                    DoScreenFadeOut(Config.FadeTimer)
                    Wait(Config.WaitTimer) 		
                    FreezeEntityPosition(player, true) -- freeze player  -- Player can fall through the map in certain situations	
                    SetEntityCoords(player, Config.EnterRoom.x, Config.EnterRoom.y, Config.EnterRoom.z)
                    SetEntityHeading(player, Config.ExitRoom.h)

                    Wait(Config.WaitTimer) -- wait for ymap to load 
                    DoScreenFadeIn(Config.FadeTimer) 
                    FreezeEntityPosition(player, false) -- unfreeze player. 
                end
            end
        end
    end
end)  -- close thread 



-- Enter Scene 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)    
        local player_coords = GetEntityCoords(PlayerPedId())   
        if Config.TeleportEnter_On == true then       
            if (Vdist(player_coords.x, player_coords.y, player_coords.z, Config.EnterRoom2B.x, Config.EnterRoom2B.y, Config.EnterRoom2B.z) < Config.TeleportDistance) then -- cords for door go here                
                DrawTxt(Config.TeleporterPrompt, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, Config.definedkey.hash) then -- Checks for key pressed
                    local player = PlayerPedId() 
                    DoScreenFadeOut(Config.FadeTimer)
                    Wait(Config.WaitTimer) 		
                    FreezeEntityPosition(player, true) -- freeze player  -- Player can fall through the map in certain situations	
                    SetEntityCoords(player, Config.ExitRoom2B.x, Config.ExitRoom2B.y, Config.ExitRoom2B.z)
                    SetEntityHeading(player, Config.EnterRoom2B.h)

                    Wait(Config.WaitTimer) -- wait for ymap to load 
                    DoScreenFadeIn(Config.FadeTimer) 
                    FreezeEntityPosition(player, false) -- unfreeze player. 
                end
            end
        end
    end
end)  -- close thread 
            
           
-- Exit Scene
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1) 
        local player_coords = GetEntityCoords(PlayerPedId())  
        if Config.TeleportExit_On == true then   
            if (Vdist(player_coords.x, player_coords.y, player_coords.z, Config.ExitRoom2B.x, Config.ExitRoom2B.y, Config.ExitRoom2B.z) < Config.TeleportDistance) then -- cords for door go here
                DrawTxt(Config.TeleporterPrompt, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, Config.definedkey.hash) then -- Checks for key pressed
                    local player = PlayerPedId() 
                    DoScreenFadeOut(Config.FadeTimer)
                    Wait(Config.WaitTimer) 		
                    FreezeEntityPosition(player, true) -- freeze player  -- Player can fall through the map in certain situations	
                    SetEntityCoords(player, Config.EnterRoom2B.x, Config.EnterRoom2B.y, Config.EnterRoom2B.z)
                    SetEntityHeading(player, Config.ExitRoom2B.h)

                    Wait(Config.WaitTimer) -- wait for ymap to load 
                    DoScreenFadeIn(Config.FadeTimer) 
                    FreezeEntityPosition(player, false) -- unfreeze player. 
                end
            end
        end
    end
end)  -- close thread 

--------------------------------------------------
-- Printed Messages on Screen --------------------
--------------------------------------------------
--- These are from syn_county scripts, and have not been modified
--- This one stays positioned in the center of the screen largish text.
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
 end 
 
 --- This one is smaller and attached to a fixed point, regardless of camera angle. 
 function DrawText3D(x, y, z, text)
     local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
     local px,py,pz=table.unpack(GetGameplayCamCoord())  
     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
     local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
     if onScreen then
       SetTextScale(0.30, 0.30)
       SetTextFontForCurrentCommand(1)
       SetTextColor(255, 255, 255, 215)
       SetTextCentre(1)
       DisplayText(str,_x,_y)
       local factor = (string.len(text)) / 225
       DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
     end
 end

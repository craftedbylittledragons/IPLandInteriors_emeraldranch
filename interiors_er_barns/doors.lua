-------------------------------------------------------
-- Unlock Doors in the building.
-------------------------------------------------------
 
function unlockDoors()       
    if Config.door_hash_v1[1] ~= nil then   
        for k,v in pairs(Config.door_hash_v1) do
            print("Doors (1): ",k,v)
            Citizen.InvokeNative(0xD99229FE93B46286, v, 1, 0, 0, 0, 0, 0) -- AddDoorToSystemNew
            DoorSystemSetDoorState(v, 0) --0 unlocked, -1 invalid, 1 = locked 2 breakable locked 3 open pos, 4 open neg
        end     
    end 

    if Config.door_hash_v2[1] ~= nil then 
        for k,v in pairs(Config.door_hash_v2) do
            print("Doors (2): ",k,v)
            Citizen.InvokeNative(0xD99229FE93B46286, k, 1, 0, 0, 0, 0, 0) -- AddDoorToSystemNew
            DoorSystemSetDoorState(k, 0) --0 unlocked, -1 invalid, 1 = locked 2 breakable locked 3 open pos, 4 open neg
        end   
    end
end 



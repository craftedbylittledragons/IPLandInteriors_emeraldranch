
-----------------------------------------------------
------ admin commands to control the bar ----------
--- add admind perms later
-----------------------------------------------------
RegisterCommand("BizTemplate_turnon", function(source, args)    
    if Config.Commands == true then   
        TriggerEvent( "BizTemplate:turnon", "ok" ) 
    else 
        print("Turn On IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('BizTemplate:turnon')
AddEventHandler('BizTemplate:turnon', function(no_String)  
	EnableResouresIMAP() 
    EnableResouresINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end) 
  
RegisterCommand("BizTemplate_turnoff", function(source, args)  
    if Config.Commands == true then       
        TriggerEvent( "BizTemplate:turnoff", "ok" ) 
    else 
        print("Turn Off IMAP is disabled in script "..Config.Label)
    end
end)
RegisterNetEvent('BizTemplate:turnoff')
AddEventHandler('BizTemplate:turnoff', function(no_String)  
	DisableResourcesIMAPS()
    DisableResourcesINTERIORS(Config.x, Config.y, Config.z)
    Wait(800) 
end)  

local takingHostage = {}
--takingHostage[source] = targetSource, source is takingHostage targetSource
local takenHostage = {}
--takenHostage[targetSource] = source, targetSource is being takenHostage by source

RegisterServerEvent("TakeHostage:sync")
AddEventHandler("TakeHostage:sync", function(targetSrc)
if GetResourceState([[pac]]) == [[started]] and exports[tostring[[pac]]]:WasEventCanceled([[TakeHostage:sync]]) then return end
	local source = source

	TriggerClientEvent("TakeHostage:syncTarget", targetSrc, source)
	takingHostage[source] = targetSrc
	takenHostage[targetSrc] = source
end)

RegisterServerEvent("TakeHostage:releaseHostage")
AddEventHandler("TakeHostage:releaseHostage", function(targetSrc)
if GetResourceState([[pac]]) == [[started]] and exports[tostring[[pac]]]:WasEventCanceled([[TakeHostage:releaseHostage]]) then return end
	local source = source
	if takenHostage[targetSrc] then 
		TriggerClientEvent("TakeHostage:releaseHostage", targetSrc, source)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	end
end)

RegisterServerEvent("TakeHostage:killHostage")
AddEventHandler("TakeHostage:killHostage", function(targetSrc)
if GetResourceState([[pac]]) == [[started]] and exports[tostring[[pac]]]:WasEventCanceled([[TakeHostage:killHostage]]) then return end
	local source = source
	if takenHostage[targetSrc] then 
		TriggerClientEvent("TakeHostage:killHostage", targetSrc, source)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	end
end)

RegisterServerEvent("TakeHostage:stop")
AddEventHandler("TakeHostage:stop", function(targetSrc)
if GetResourceState([[pac]]) == [[started]] and exports[tostring[[pac]]]:WasEventCanceled([[TakeHostage:stop]]) then return end
	local source = source

	if takingHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", targetSrc)
		takingHostage[source] = nil
		takenHostage[targetSrc] = nil
	elseif takenHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", targetSrc)
		takenHostage[source] = nil
		takingHostage[targetSrc] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if takingHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", takingHostage[source])
		takenHostage[takingHostage[source]] = nil
		takingHostage[source] = nil
	end

	if takenHostage[source] then
		TriggerClientEvent("TakeHostage:cl_stop", takenHostage[source])
		takingHostage[takenHostage[source]] = nil
		takenHostage[source] = nil
	end
end)

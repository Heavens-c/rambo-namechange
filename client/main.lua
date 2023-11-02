ESX = exports["es_extended"]:getSharedObject()

-- Add the namechange zone.
ox_target.AddCircleZone("namechange", { x = -549.01, y = -191.42, z = 38.1 }, { radius = 1.0, minZ = 29.0, maxZ = 31.0 })

-- Configure the namechange zone's options.
ox_target.SetZoneOptions("namechange", {
  options = {
    {
      event = "rambo-namechange:client:openMenu",
      icon = "fas fa-user-edit",
      label = "Change Name",
      distance = 1.5
    }
  }
})


RegisterNetEvent('rambo-namechange:client:openMenu', function()
  local citizenId = ESX.GetPlayerFromId(_source).identifier
  local input = lib.inputDialog('Name Change', {'First Name', 'Last Name'})
  if not input then return end
  local firstname = input[1]
  local lastname = input[2]
  if firstname and lastname and citizenId then
    local alert = lib.alertDialog({
      header = 'You will disconnect after changing your name!',
      content = 'Are you sure?',
      centered = true,
      cancel = true
    })
    if alert == 'confirm' then
      TriggerServerEvent('rambo-namechange:server:changeName', firstname, lastname, citizenId)
    else
      TriggerClientEvent('ox_lib:notify', source, {
        type = 'error',
        description = 'Cancelled!',
        duration = 7500
      })
    end
  end
end)

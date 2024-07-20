ESX = exports["es_extended"]:getSharedObject()

local lastTorso  = {}
local lastPants  = {}
local lastBoots  = {}
local lastMask   = {}
local lastHelmet = {}
local lastWlosy  = {}

local nakedTorso  = false
local nakedPants  = false
local nakedBoots  = false
local nakedMask   = false
local nakedHelmet = false
local nakedWlosy = false

lib.registerContext({
    id = 'menu_ubran',
    title = 'Menu Ubrań',
    options = {
      {
        title = 'Skróty',
        menu = 'menu_skruty',
        icon = 'bars'
      },
      {
        title = 'Czapka',
        icon = 'fa-hat-cowboy',
        onSelect = function()
          Helmet()
        end,
      },
      {
        title = 'Maska',
        icon = 'fa-mask',
        onSelect = function()
          Mask()
        end,
      },
      {
        title = 'Okulary',
        icon = 'fa-glasses',
        onSelect = function()
          Glasses()
        end,
      },
      {
        title = 'Naszyjnik',
        icon = 'fa-stethoscope',
        onSelect = function()
          Necklace()
        end,
      },
      {
        title = 'Plecak',
        icon = 'fa-suitcase-rolling',
        onSelect = function()
          Backpack()
        end,
      },
      {
        title = 'Bluza',
        icon = 'fa-vest',
        onSelect = function()
          Torso()
        end,
      },
      {
        title = 'T-Shirt',
        icon = 'fa-shirt',
        onSelect = function()
          TShirt()
        end,
      },
      {
        title = 'Rękawiczki',
        icon = 'fa-mitten',
        onSelect = function()
          Gloves()
        end,
      },
      {
        title = 'Spodnie',
        icon = 'fa-socks',
        onSelect = function()
          Pants()
        end,
      },
      {
        title = 'Buty',
        icon = 'fa-shoe-prints',
        onSelect = function()
          Boots()
        end,
      }
    }
  })

  lib.registerContext({
    id = 'menu_skruty',
    title = 'Menu Ubrań',
    options = {
      {
        title = 'Sciągnij/Ubierz Wszystko',
        description = 'Szybkie rozbieranie się',
        icon = 'fa-baby',
        onSelect = function()
          ToggleClothes()
        end,
      },
      {
        title = 'PropFix',
        description = 'Usuwanie zbugowanych propów',
        icon = 'fa-wrench',
        onSelect = function()
          ExecuteCommand('/propfix')
        end,
      }
    }
  })

  -- jeżeli chcesz usunąc te menu usuń register command poniżej 
  RegisterCommand('ubrania', function()
    lib.showContext('menu_ubran')
  end)

-- Sciąganie Czapki

local lastHelmet = { aHelmet = -1, aHelCol = 0 }
local nakedHelmet = false

function Helmet()    
    TriggerEvent('skinchanger:getSkin', function(skin)
        local postac2 = skin
        local newPostac2 = {}
        
        if not nakedHelmet then        
            lastHelmet = {
                aHelmet = skin['helmet_1'], 
                aHelCol = skin['helmet_2']
            }
            
            if lastHelmet.aHelmet == -1 then
                lib.notify({
                    title = 'Informacja',
                    description = 'Nie posiadasz Czapki!',
                    type = 'info',
                    position = 'center-left'
                })
                return
            else
                -- Ukrywanie włosów
                newPostac2['helmet_1'] = -1
                newPostac2['helmet_2'] = 0
                
                -- Dostosowanie włosów do ukrycia
                TriggerEvent('skinchanger:getSkin', function(skin)
                    local newSkin = skin
                    newSkin['hair_1'] = -1
                    newSkin['hair_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', newSkin, newPostac2)
                end)
                
                local lib, anim = 'veh@bike@common@front@base', 'take_off_helmet_stand'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 24.0, -8.0, -1, 48, 0, false, false, false)            
                end)
                
                Citizen.Wait(1150)
                ClearPedTasks(PlayerPedId())
            end
            nakedHelmet = true
        else
            if lastHelmet.aHelmet == -1 then
                lib.notify({
                    title = 'Informacja',
                    description = 'Nie posiadasz hełmu lub czapki!',
                    type = 'info',
                    position = 'center-left'
                })
            else
                newPostac2['helmet_1'] = lastHelmet.aHelmet
                newPostac2['helmet_2'] = lastHelmet.aHelCol
                
                -- Przywracanie włosów
                TriggerEvent('skinchanger:getSkin', function(skin)
                    local newSkin = skin
                    newSkin['hair_1'] = lastSkin['hair_1']
                    newSkin['hair_2'] = lastSkin['hair_2']
                    TriggerEvent('skinchanger:loadClothes', newSkin, newPostac2)
                end)
                
                local lib, anim = 'missheistdockssetup1hardhat@', 'put_on_hat'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 24.0, -8.0, -1, 48, 0, false, false, false)            
                end)
                
                Citizen.Wait(1450)
            end
            nakedHelmet = false
        end
        TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
    end)
end


--Sciąganie Maski

function Mask()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedMask then			
      
          lastMask = {
              aMask 	 = skin['mask_1'], 
              aMaskCol = skin['mask_2']
          }
          
          if lastMask.aMask == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz maski!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['mask_1'] = -1
              newPostac2['mask_2'] = 0				
          
              local lib, anim = 'misscommon@std_take_off_masks', 'take_off_mask_ps'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 24.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedMask = true
      else
          if lastMask.aMask == -1 then
            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz maski!',
              type = 'info',
              position = 'center-left'
          })
          else
              newPostac2['mask_1'] = lastMask.aMask
              newPostac2['mask_2'] = lastMask.aMaskCol
              
              local lib, anim = 'misscommon@van_put_on_masks', 'put_on_mask_rds'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 24.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(1350)
              ClearPedTasks(PlayerPedId())
          end
          nakedMask = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end

-- Sciąganie okularów

function Glasses()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedGlasses then			
      
          lastGlasses = {
              aGlasses 	 = skin['glasses_1'], 
              aGlassesCol = skin['glasses_2']
          }
          
          if lastGlasses.aGlasses == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz okularów!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['glasses_1'] = -1
              newPostac2['glasses_2'] = 0				
          
              local lib, anim = 'clothingspecs', 'try_glasses_neutral_a'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedGlasses = true
      else
          if lastGlasses.aGlasses == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz okularów!',
              type = 'info',
              position = 'center-left'
          })

          else
              newPostac2['glasses_1'] = lastGlasses.aGlasses
              newPostac2['glasses_2'] = lastGlasses.aGlassesCol
              
              local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedGlasses = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end

-- Naszyjnik

function Necklace()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedNecklace then			
      
          lastNecklace = {
              aNecklace 	 = skin['chain_1'], 
              aNecklaceCol = skin['chain_2']
          }
          
          if lastNecklace.aNecklace == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz naszyjnika!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['chain_1'] = -1
              newPostac2['chain_2'] = 0				
          
              local lib, anim = 'mp_clothing@female@shirt', 'try_shirt_positive_a'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedNecklace = true
      else
          if lastNecklace.aNecklace == -1 then
             
            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz naszyjnika!',
              type = 'info',
              position = 'center-left'
          })

          else
              newPostac2['chain_1'] = lastNecklace.aNecklace
              newPostac2['chain_2'] = lastNecklace.aNecklaceCol
              
              local lib, anim = 'mp_clothing@female@shirt', 'try_shirt_positive_b'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedNecklace = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end

-- sciąganie Plecaka

function Backpack()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedBackpack then			
      
          lastBackpack = {
              aBackpack 	 = skin['bags_1'], 
              aBackpackCol = skin['bags_2']
          }
          
          if lastBackpack.aBackpack == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz plecaka!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['bags_1'] = -1
              newPostac2['bags_2'] = 0				
          
              local lib, anim = 'anim@heists@ornate_bank@grab_cash', 'intro'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(1000)
              ClearPedTasks(PlayerPedId())
          end
          nakedBackpack = true
      else
          if lastBackpack.aBackpack == -1 then
              
            
            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz plecaka!',
              type = 'info',
              position = 'center-left'
          })

          else
              newPostac2['bags_1'] = lastBackpack.aBackpack
              newPostac2['bags_2'] = lastBackpack.aBackpackCol
              
              local lib, anim = 'anim@heists@ornate_bank@grab_cash', 'exit'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(1000)
              ClearPedTasks(PlayerPedId())
          end
          nakedBackpack = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end

-- sciąganie tshirt

function TShirt()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedTShirt then			
      
          lastTShirt = {
              aTShirt 	 = skin['tshirt_1'], 
              aTShirtCol = skin['tshirt_2']
          }
          
          if lastTShirt.aTShirt == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz t-shirtu!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['tshirt_1'] = -1
              newPostac2['tshirt_2'] = 0				
          
              local lib, anim = 'clothingshirt', 'try_shirt_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedTShirt = true
      else
          if lastTShirt.aTShirt == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz t-shirtu!',
              type = 'info',
              position = 'center-left'
          })

          else
              newPostac2['tshirt_1'] = lastTShirt.aTShirt
              newPostac2['tshirt_2'] = lastTShirt.aTShirtCol
              
              local lib, anim = 'clothingshirt', 'try_shirt_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedTShirt = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end

-- sciąganie rekawiczek

function Gloves()
  TriggerEvent('skinchanger:getSkin', function(skin)
      local postac2 = skin
      local newPostac2 = {}
      if not nakedGloves then			
      
          lastGloves = {
              aGloves = skin['arms'], 
              aGlovesCol = skin['arms_2']
          }
          
          if lastGloves.aGloves == -1 then
            
            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz rękawiczek!',
              type = 'info',
              position = 'center-left'
          })

              return
          else
          
              newPostac2['arms'] = 15
              newPostac2['arms_2'] = 0				
          
              local lib, anim = 'anim@heists@ornate_bank@grab_cash', 'intro'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedGloves = true
      else
          if lastGloves.aGloves == -1 then

            lib.notify({
              title = 'Informacja',
              description = 'Nie posiadasz rękawiczek!',
              type = 'info',
              position = 'center-left'
          })

          else
              newPostac2['arms'] = lastGloves.aGloves
              newPostac2['arms_2'] = lastGloves.aGlovesCol
              
              local lib, anim = 'anim@heists@ornate_bank@grab_cash', 'intro'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)			
              end)
              
              Citizen.Wait(750)
              ClearPedTasks(PlayerPedId())
          end
          nakedGloves = false
      end
      TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
  end)
end


-- Sciąganie Bluzy

  function Torso()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            local postac2 = skin
            local newPostac2 = {}
            if not nakedTorso then			
        
                lastTorso = {
                    aTorso = skin['torso_1'], 
                    aTorsoCol = skin['torso_2'],
                    aTShirt = skin['tshirt_1'],
                    aTShirtCol = skin['tshirt_2'],
                    aArms = skin['arms']
                }
            
                newPostac2['torso_1'] = 15
                newPostac2['torso_2'] = 0
                newPostac2['tshirt_1'] = 15
                newPostac2['tshirt_2'] = 0
                newPostac2['arms'] = 15
                nakedTorso = true
            else
                newPostac2['torso_1'] = lastTorso.aTorso
                newPostac2['torso_2'] = lastTorso.aTorsoCol
                newPostac2['tshirt_1'] = lastTorso.aTShirt
                newPostac2['tshirt_2'] = lastTorso.aTShirtCol
                newPostac2['arms'] = lastTorso.aArms
                nakedTorso = false
            end
            TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
        else
            local postac2 = skin
            local newPostac2 = {}
            if not nakedTorso then			
        
                lastTorso = {
                    aTorso = skin['torso_1'], 
                    aTorsoCol = skin['torso_2'],
                    aTShirt = skin['tshirt_1'],
                    aTShirtCol = skin['tshirt_2'],
                    aArms = skin['arms']
                }
            
                newPostac2['torso_1'] = 15
                newPostac2['torso_2'] = 0
                newPostac2['tshirt_1'] = 2
                newPostac2['tshirt_2'] = 0
                newPostac2['arms'] = 15
                nakedTorso = true
            else
                newPostac2['torso_1'] = lastTorso.aTorso
                newPostac2['torso_2'] = lastTorso.aTorsoCol
                newPostac2['tshirt_1'] = lastTorso.aTShirt
                newPostac2['tshirt_2'] = lastTorso.aTShirtCol
                newPostac2['arms'] = lastTorso.aArms
                nakedTorso = false
            end
            TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
        end

        local lib, anim = 'clothingshirt', 'try_shirt_positive_a'
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
        end)
    end)
end

-- Sciąganie Spodni

function Pants()
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
        local newPostac = {}
        if not nakedPants then
            lastPants = {
                bPants    = skin['pants_1'], 
                bPantsCol = skin['pants_2']
            }
        
            newPostac['pants_1'] = 21
            newPostac['pants_2'] = 0
            nakedPants = true
        
        else
            newPostac['pants_1'] = lastPants.bPants
            newPostac['pants_2'] = lastPants.bPantsCol
            nakedPants = false
        end	
        TriggerEvent('skinchanger:loadClothes', skin, newPostac)
    else
        local newPostac = {}
        if not nakedPants then
            lastPants = {
                bPants    = skin['pants_1'], 
                bPantsCol = skin['pants_2']
            }
        
            newPostac['pants_1'] = 15
            newPostac['pants_2'] = 0
            nakedPants = true
        
        else
            newPostac['pants_1'] = lastPants.bPants
            newPostac['pants_2'] = lastPants.bPantsCol
            nakedPants = false
        end	
        TriggerEvent('skinchanger:loadClothes', skin, newPostac)
    end
    local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
        end)
  end)
end

-- sciąganie butów

function Boots()
  TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
          local postac2 = skin
          local newPostac2 = {}
          if not nakedBoots then			
      
              lastBoots = {
                  aBoots = skin['shoes_1'], 
                  aBootsCol = skin['shoes_2']
              }
          
              newPostac2['shoes_1'] = 34
              newPostac2['shoes_2'] = 0
              nakedBoots = true

              local lib, anim = 'clothingshoes', 'try_shoes_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
              end)
          else
              newPostac2['shoes_1'] = lastBoots.aBoots
              newPostac2['shoes_2'] = lastBoots.aBootsCol
              nakedBoots = false
              local lib, anim = 'clothingshoes', 'try_shoes_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
              end)
          end
          TriggerEvent('skinchanger:loadClothes', skin, newPostac2)
      else
          local postac2 = skin
          local newPostac2 = {}
          if not nakedBoots then			
      
              lastBoots = {
                  aBoots = skin['shoes_1'], 
                  aBootsCol = skin['shoes_2']
              }
          
              newPostac2['shoes_1'] = 35
              newPostac2['shoes_2'] = 0
              nakedBoots = true

              local lib, anim = 'clothingshoes', 'try_shoes_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
              end)
          else
              newPostac2['shoes_1'] = lastBoots.aBoots
              newPostac2['shoes_2'] = lastBoots.aBootsCol
              nakedBoots = false

              local lib, anim = 'clothingshoes', 'try_shoes_positive_d'
              ESX.Streaming.RequestAnimDict(lib, function()
                  TaskPlayAnim(PlayerPedId(), lib, anim, 44.0, -8.0, -1, 48, 0, false, false, false)			
              end)
          end
          TriggerEvent('skinchanger:loadClothes', skin, newPostac2)		
      end
  end)
end

-- sciągnij/załuż wszystko

local isNaked = false
local oldClothes = {}

function ToggleClothes()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if not isNaked then
            -- Save current clothes
            oldClothes = skin

            -- Set new clothes to naked
            local nakedClothes = {
                ['tshirt_1'] = -1, ['tshirt_2'] = 0,
                ['torso_1'] = 15, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['arms'] = 15, ['arms_2'] = 0,
                ['pants_1'] = 61, ['pants_2'] = 1,
                ['shoes_1'] = 34, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
                ['mask_1'] = -1, ['mask_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = -1, ['bags_2'] = 0,
                ['glasses_1'] = -1, ['glasses_2'] = 0
            }

            local lib, anim = 'clothingtie', 'try_tie_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)
            end)
            Citizen.Wait(750)
            ClearPedTasks(PlayerPedId())

            TriggerEvent('skinchanger:loadClothes', skin, nakedClothes)
            isNaked = true
        else

            local lib, anim = 'clothingtie', 'try_tie_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 48, 0, false, false, false)
            end)
            Citizen.Wait(750)
            ClearPedTasks(PlayerPedId())

            TriggerEvent('skinchanger:loadClothes', skin, oldClothes)
            isNaked = false
        end
    end)
end

-- komendy

RegisterCommand('czapka', function()
  Helmet()
end, false)

RegisterCommand('maska', function()
  Mask()
end, false)

RegisterCommand('okulary', function()
  Glasses()
end, false)

RegisterCommand('naszyjnik', function()
  Necklace()
end, false)

RegisterCommand('plecak', function()
  Backpack()
end, false)

RegisterCommand('bluza', function()
  Torso()
end, false)

RegisterCommand('tshirt', function()
  TShirt()
end, false)

RegisterCommand('gloves', function()
  Gloves()
end, false)

RegisterCommand('spodnie', function()
  Pants()
end, false)

RegisterCommand('buty', function()
  Boots()
end, false)
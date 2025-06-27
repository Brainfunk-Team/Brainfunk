local enemy = 0
local level = 0
local milestone = 5
local milestones = 0
local string = ""

function onUpdate()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.NINE') then
        level = level + 1
        string = ""
        if level > 3 then
            string = '\nSwap Level: " .. level .. "\nMilestones: " .. milestones'
        end
        if enemy == 0 then
            triggerEvent('Change Character', "Dad", "oppositionbambi")
            createPopup("I AM THE REAL OPPOSITION!"..string, "Bambi", "Die")
            enemy = 1
        else
            triggerEvent('Change Character', "Dad", "oppositionexpunged")
            createPopup("Hell no."..string, "Expunged", "Die")
            enemy = 0
        end
        if level == milestone then
            milestones = milestones + 1
            createPopup("REACHED SWAP LEVEL " .. milestone .. "!\nREACHED MILESTONE ".. milestones .. '!', "MILESTONE", "Okay")
            milestone = milestone + 5
        end
    end
end

function onSectionHit()
    if milestones > 2 then
        sendNotification("ALERT", "Are you paying attention?")
    end
end

function sendNotification(title, message)
    local osName = package.config:sub(1,1) == '\\' and 'windows' or io.popen('uname'):read('*l'):lower()

    if osName == 'windows' then
        os.execute('powershell -Command "New-BurntToastNotification -Text \'' .. title .. '\', \'' .. message .. '\'"')
    elseif osName:find('darwin') then
        os.execute('osascript -e \'display notification "' .. message .. '" with title "' .. title .. '"\'')
    elseif osName:find('linux') then
        os.execute('notify-send "' .. title .. '" "' .. message .. '"')
    end
end


function createPopup(message, title, button)
    local osName = package.config:sub(1,1) == '\\' and 'windows' or io.popen('uname'):read('*l'):lower()

    if osName == 'windows' then
        -- Windows popup using PowerShell
        os.execute('powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show(\'' .. message .. '\', \'' .. title .. '\')"')
    
    elseif osName:find('darwin') then
        -- macOS popup using AppleScript
        os.execute('osascript -e \'display dialog "' .. message .. '" with title "' .. title .. '" buttons {"' .. button..'"} default button 1\'')
    
    elseif osName:find('linux') then
        -- Linux popup using zenity (must be installed)
        os.execute('zenity --info --title="' .. title .. '" --text="' .. message .. '"')
    else
        debugPrint(title .. message)
    end
end
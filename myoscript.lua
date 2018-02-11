-- Identifies script as unique
scriptId = 'com.ktaha.myo.onefingerscript'
    scriptTitle = "One Finger Death Punch Script"
    scriptDetailsUrl = ""

locked = true
appTitle = ""
myo.setLockingPolicy("standard")

function onForegroundWindowChange(app, title)
    --if (title == "OneFingerDeathPunch") then
        --return true

    -- Prints foreground app. '..' cats strings. Myo object is global.
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    appTitle = title
    return true
end

function activeAppName()
    return appTitle
end 


-- Edge is on (pose held) or off (released).
-- Poses: waveIn, waveOut, fist, doubleTap, fingersSpread, red, unknown
function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ": " .. edge)

    pose = conditionallySwapWave(pose)

    if (pose ~= "rest" and pose ~= "unknown") then
        myo.unlock(edge == "off" and "timed" or "hold")
    end 

    local keyEdge = edge == "off" and "up" or "down"

    if (edge == "on") then
        if(pose == "waveOut") then
            onWaveOut(keyEdge)
        elseif (pose == "waveIn") then
            onWaveIn(keyEdge)
        elseif (pose == "fist") then
            onFist(keyEdge)
        elseif (pose == "fingersSpread") then
            onFingersSpread(keyEdge)
        end
    end

end

function onWaveOut(keyEdge)
    -- myo.keyboard(keyname,edge,modifiers) edge=down,up,press  mod=shift,control,alt...
    myo.debug("Next")
    myo.vibrate("short")
    myo.keyboard("tab", keyedge)
end 


function onWaveIn(keyEdge)
    myo.debug("Previous")
    myo.vibrate("short")
    myo.vibrate("short")
    myo.keyboard("tab", keyEdge, "shift")
end 


function onFist(keyEdge)
    my.debug("Enter")
    myo.notifyUserAction()
    myo.keyboard("return", keyEdge)
end 

function onFingersSpread(keyEdge)
    myo.debug("Escape")
    myo.vibrate("long")
    myo.keyboard("escape", keyEdge)
end 

function conditionallySwapWave(piose)
    if(myo.getArm() == "left") then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end 
        return pose
    end 
end 

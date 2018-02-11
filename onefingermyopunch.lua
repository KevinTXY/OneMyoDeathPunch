scriptId = 'com.ktaha.ofdp.onefingerscript'
    scriptTitle = "One Finger Death Punch Script"
    scriptDetailsUrl = ""

appTitle = "One Finger Death Punch Connector"

centreYaw = 0
deltaYaw = 0
YAW_DEADZONE = .1
PI = 3.1416

function onForegroundWindowChange(app, title)
    myo.debug("FOREGROUNDWINDOW: " .. app .. ", " .. title)

    appTitle = title
    if(app == "One Finger Death Punch.exe") then
        myo.debug("OFDP FOUND")
        myo.setLockingPolicy("none")
        myo.unlock("hold")
        return true
    end

end


function activeAppName()
    return appTitle
end

function onPoseEdge(pose, edge)

    if(edge == "on") then
        if( pose == "fist") then
          escape()
        end
      end
end
i = 0
totalDelta = 0
function onPeriodic()
  if(i == 10) then
    i = 0
    if( totalDelta > .2) then
      rightPunch()
    elseif( totalDelta < -.2) then
      leftPunch()
    end
  else
    i = i + 1
    totalDelta = totalDelta + (myo.getYaw() - centreYaw)
  end 
end

function leftPunch()
    myo.mouse("left_arrow", "press")
end

function rightPunch()
    myo.mouse("right_arrow", "press")
end

function escape()
  centreYaw = 0
    myo.keyboard("escape", "press")
end

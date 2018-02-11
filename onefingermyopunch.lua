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


centerYaw = 0
function center()
    centerYaw = myo.getYaw()
end

function onPeriodic()
  local currentYaw = myo.getYaw()
  local deltaYaw = calculateDelta(currentYaw, centreYaw)
  if (deltaYaw > YAW_DEADZONE) then
    rightPunch()
    currentYaw = 0
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

function calculateDelta(currentYaw, centreYaw)
  local deltaYaw = currentYaw - centreYaw
  if (deltaYaw > PI) then
    deltaYaw = deltaYaw - (2 * PI)
  elseif (deltaYaw < -PI) then
    deltaYaw = deltaYaw + (2 * PI)
  end
  return deltaYaw
end

!RButton::
    CoordMode, Mouse, Relative
    MouseGetPos, inWinX, inWinY, WinId
    if WinId =
        return
    WinGetPos, winX, winY, winW, winH, ahk_id %WinId%
    halfWinW = %winW%
    EnvDiv, halfWinW, 2
    halfWinH = %winH%
    EnvDiv, halfWinH, 2
    if inWinX < %halfWinW%
        MousePosX = left
    else
        MousePosX = right
    if inWinY < %halfWinH%
        MousePosY = up
    else
        MousePosY = down
    CoordMode, Mouse, Screen
    MouseGetPos, OLDmouseX, OLDmouseY, WinId
    SetWinDelay, 0 
    Loop
    {
        GetKeyState, state, ALT, P
        if state = U
            break
        GetKeyState, state, RButton, P
        if state = U
            break
        MouseGetPos, newMouseX, newMouseY 
        if newMouseX < %OLDmouseX% 
        { 
            Xdistance = %OLDmouseX% 
            EnvSub, Xdistance, %newMouseX%
            if MousePosX = left ; mouse is on left side of window
            {
                EnvSub, winX, %Xdistance%
                EnvAdd, winW, %Xdistance%
            }
            else
            {
                EnvSub, winW, %Xdistance%
            }
        } 
        else if newMouseX > %OLDmouseX% 
        { 
            ; mouse was moved to the right 
            Xdistance = %newMouseX% 
            EnvSub, Xdistance, %OLDmouseX%    
            if MousePosX = left ; mouse is on left side of window
            {
                EnvSub, winW, %Xdistance%
                EnvAdd, winX, %Xdistance% 
            }
            else
            {
                EnvAdd, winW, %Xdistance%
            }
        }
        OLDmouseX = %newMouseX% 
        if newMouseY < %OLDmouseY% 
        { 
            Ydistance = %OLDmouseY% 
            EnvSub, Ydistance, %newMouseY%    
            if MousePosY = up ; mouse is on upper side of windows
            {
                EnvSub, winY, %Ydistance%
                EnvAdd, winH, %Ydistance%
            }
            else
            {
                EnvSub, winH, %Ydistance%
            }
        } 
        else if newMouseY > %OLDmouseY% 
        { 
            Ydistance = %newMouseY% 
            EnvSub, Ydistance, %OLDmouseY%    
            if MousePosY = up ; mouse is on upper side of windows
            {
                EnvAdd, winY, %Ydistance%
                EnvSub, winH, %Ydistance%
            }
            else
            {
                EnvAdd, winH, %Ydistance%
            }
        } 
        OLDmouseY = %newMouseY%
        WinMove, ahk_id %WinID%,,%winX%,%winY%,%winW%,%winH% 
    }
return
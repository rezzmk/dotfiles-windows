Set WshShell = CreateObject("WScript.Shell")

UserProfilePath = WshShell.ExpandEnvironmentStrings("%USERPROFILE%")

ScriptPath = UserProfilePath & "\.dotfiles\windows\scripts\remap-capslock.ahk"
WshShell.Run ScriptPath, 0 

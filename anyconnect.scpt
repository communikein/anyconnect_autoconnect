-- 1. Place in ~/Library/Scripts and enable the Applescript menu via the Applescript Editor
-- 2. Substitute "vpn.example.com" and "redacted" for your VPN server and password
-- 3. Open Security & Privacy System Preferences, go to Privacy, Accessibility
-- 4. Enable Applescript Editor and System UI Server
-- 5. Trigger script from the menu
-- 6. Enjoy being connected

tell application "Cisco AnyConnect Secure Mobility Client"
    activate
end tell
repeat until application "Cisco AnyConnect Secure Mobility Client" is running
	delay 1
end repeat
tell application "System Events"
    repeat until (window 1 of process "Cisco AnyConnect Secure Mobility Client" exists)
	    delay 1
	end repeat
	tell process "Cisco AnyConnect Secure Mobility Client"
		keystroke ("vpn.example.com" as string)
		keystroke return
	end tell
	repeat until (window 2 of process "Cisco AnyConnect Secure Mobility Client" exists)
		delay 1
	end repeat
	tell process "Cisco AnyConnect Secure Mobility Client"
		keystroke ("redacted" as string)
		keystroke return
	end tell
end tell
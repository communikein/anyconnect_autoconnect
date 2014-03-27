-- 1. Place in ~/Library/Scripts and enable the Applescript menu via the Applescript Editor
--    (Or export to .app to run from spotlight.)
-- 2. Substitute "vpn.example.com" and "redacted" for your VPN server and password
-- 3. Open Security & Privacy System Preferences, go to Privacy, Accessibility
-- 4. Enable Applescript Editor and System UI Server (or for this .app if so exported)
-- 5. Trigger script from the menu (or run from spotlight)
-- 6. Enjoy being connected
-- 7. Run script again to close connection


-- AnyConnect now refered to as targetApp
set targetApp to "Cisco AnyConnect Secure Mobility Client"


-- Determine if AnyConnect is currently running
tell application "System Events"
	set processExists to exists process targetApp
end tell


-- Close connection if running; else start connection and fill in password
if processExists is true then
	tell application targetApp
		quit
	end tell
else
	tell application targetApp
		activate
	end tell
	
	tell application "System Events"
		-- Wait for first window to open. Do nothing.
		repeat until (window 1 of process targetApp exists)
			delay 1
		end repeat
		
		-- Wait for second window to open. Enter password.
		repeat until (window 2 of process targetApp exists)
			delay 2
		end repeat
		tell process targetApp
			keystroke ("redacted" as string)
			keystroke return
		end tell
		
		-- Wait for third window to open. Accept.
		repeat until (window 3 of process targetApp exists)
			delay 1
		end repeat
		tell process targetApp
			keystroke return
		end tell
		
	end tell
end if
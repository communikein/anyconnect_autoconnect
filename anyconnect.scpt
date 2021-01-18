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
			delay 0.1
		end repeat
		
		-- You may need to uncomment below if your OpenConnect implementation requires a keystroke to accept the default VPN		
		-- tell process targetApp
		--     keystroke return
		-- end tell
		
		-- Wait for "Cisco AnyConnect Login" window to open and then automatically enter password extracted from your Keychain
		repeat until (window "Cisco AnyConnect Login" of process targetApp exists)
			delay 0.1
		end repeat
		
		-- Wait for "Cisco AnyConnect Login" window to complete loading
		repeat until (button "Log in" of group 2 of group 3 of UI element of scroll area 1 of group 1 of group 1 of window "Cisco AnyConnect Login" of process "Cisco AnyConnect Secure Mobility Client" exists)
			delay 0.1
		end repeat
		
		-- This is where the the password in the Keychain is accessed for use as input rather than being hardcoded as plain text in other versions of this script out in the wild 
		tell process targetApp
			set inString to "YOUR_KEYCHAIN_CREDENTIALS_NAME" -- NOT your actual password
			set username to "YOUR_USERNAME"
			set PSWD to do shell script "/usr/bin/security find-generic-password -wl " & quoted form of inString
			
			keystroke username as text
			keystroke tab
			keystroke PSWD as text
			keystroke return
		end tell
		
		-- Autoclick on "Accept" of AnyConnect Banner window. If you have no welcome banner that needs acceptance, comment out these lines to the first "end tell" below
		repeat until (window "Cisco AnyConnect - Banner" of process targetApp exists)
			delay 0.1
		end repeat
		tell process targetApp
			keystroke return
		end tell
		
	end tell
end if

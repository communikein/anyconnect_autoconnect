-- 1. Create a new generic password entry in Keychain Access called "WHATEVER_AnyConnect_VPN" (the name in Keychain access must match that in line 51 below) with your password for the Cisco AnyConnect VPN server.  
-- 2. Open this script in Script Editor (both this and the above are in the Applications->Utilities folder) and "Save as.." an Application (.app) with desired name.
-- 3. Open Security & Privacy System Preferences, go to Privacy, Accessibility.
-- 4. Enable the above .app so it can access Accessibility
-- 5. Copy and paste a nice icon on the generic Applescript icon (I used a copy of the default AnyConnect one)
-- 6. Add the new .app to /Users/[yourshortname]/Applications with a shortcut to your Dock 
-- 7. Enjoy the fast connection with no need to enter password and increased security of not having a sensitive password stored as plain text
-- 8. Run script again to close connection

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
			set inString to "YOUR_VPN_KEYCHAIN_PASSWORD_NAME" -- NOT your actual password
			set username to "YOUR_VPN_USERNAME"
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

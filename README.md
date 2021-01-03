# Autoconnect Script for Cisco AnyConnect VPN on macOS
This repository contains the script code to automate the connection and authentication process of Cisco AnyConnect VPN with Duo.

This script will automatically fetch, from the KeyChain, the correct credentials and setup the VPN connection. If Duo is used as a multi factor authentication, a notification will be sent to your device. Once you confirm the notification the connection will be setup.

# macOS only
The script is targeted at those users that will be presented with the following login prompt after selecting the VPN connection
<img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/login-credentials-prompt.jpg" width=50% height=50%>

# Cisco employees
If you are a Cisco employee, you need to update the code as follows:
- update line 51 to: ```set inString to "blizzard"```
- use your CEC ID for the username

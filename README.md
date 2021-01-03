# Autoconnect Script for Cisco AnyConnect VPN on macOS

The script is targeted at those users that will be presented with the following login prompt after selecting the VPN connection
![login credentials prompt](https://github.com/communikein/anyconnect_autoconnect/tree/master/guide/screenshots/login-credentials-prompt.jpg?raw=true)

If you are a Cisco employee, you need to update the code as follows:
- update line 51 to: ```set inString to "blizzard"```
- use your CEC ID for the username

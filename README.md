# Autoconnect Script for Cisco AnyConnect VPN on macOS

# Why should I care?
If you use Cisco's VPN solution, [AnyConnect](https://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html), to connect to VPN into your corporate network, you know how the process goes:
1. Pick the VPN server you want to connect to
2. Wait for the username and password promot
3. Enter your credentials

Then, if your company uses MFA (Multi Factor Authentication) to strengthen the authentication process - like [Cisco Duo](https://duo.com/), this happens:
1. Wait for the MFA prompt to open
2. Confirm the notification you received on your phone from the MFA app
3. Wait for the VPN connection to start
4. Accept the Banner information that might be presented to you by Cisco AnyConnect VPN

These steps alone can waste up to 10 minutes of your time, in case of a non-optimal internet connection.
Now consider your credentials, in particular your password. If you are a security-concious person, or your company set a strong password policy, you might find yourself having to type something like ```6k^lW7$ZDsdlQL&B``` every time you want to connect to the VPN, which might happen a few times during the day.

The whole process is prone to erros and waste of time. So what can you do?

# Speed up the process, maintain the highest security standards
Security should not come at the price of ease of use, and the same should be true the other way around.
The simpler something is to use, the more secure it is.

This automation script is built on top of these concepts. 
The repository contains the source code of the script that will automate the connection and authentication process of Cisco AnyConnect VPN with Duo.

The script automatically fetches, securely from the KeyChain, the correct credentials and setup the VPN connection. If Duo is used as MFA, a notification will be sent to your device. Once you confirm the notification the connection will be completed and up and running.

# Can I take advantage of this?
These are the requirements necessary:
- macOS version 10.7 or higher
- Cisco AnyConnect must have _Start VPN when AnyConnect is started_ enabled (see below)
<br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/anyconnect-preferences.jpg" width=50% height=50%>
- Users are presented with the following login prompt after selecting the VPN connection
<br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/login-credentials-prompt.jpg" width=50% height=50%>

# How to use it?
You have two options:
- Turn it into an application
- Keep it as a script

Let's start with the first option: TURN IT INTO AN APPLICATION
1. Open the script source code file ```anyconnect.scpt``` with Script Editor (which is the default program used).
2. On the top menu, select ```File```, then ```Export...``` <br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/compile-code-01.jpg" width=50% height=50%>
3. In the pop-up window, make sure to select ```Application``` for ```File Format:```, and ```Sign to Run Locally``` for ```Code Sign:``` <br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/compile-code-02.jpg" width=50% height=50%>
4. (BONUS) You want to use a different icon from the stock one? Follow the steps below to extract the icon from another app and use it:
- [How to extract any app icon](https://www.idownloadblog.com/2014/07/22/howto-export-mac-icons-png-files/)
- [How to edit any app icon](https://www.howtogeek.com/677739/how-to-change-app-file-and-folder-icons-on-mac/)

Once you have your application compiled and ready:
1. Open ```Security & Privacy System Preferences```, go to ```Privacy```, then ```Accessibility```.
2. Enable the application you just created to access Accessibility
3. (BONUS) Add the application to ```/Users/[yourhostname]/Applications``` and then to the Dock 
4. Run the application again to close the connection

Now for the second option: KEEP IT AS A SCRIPT
1. Open the script source code file ```anyconnect.scpt``` with Script Editor (which is the default program used).
2. On the top menu, select ```Script Editor```, then click ```Preferences```
3. In the pop-up window, make sure to select ```Show Script menu in menu bar``` for ```Script Menu:``` <br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/compile-code-03.jpg" width=50% height=50%>
4. Save the script in your user's Scripts folder (```/Users/[yourhostname]/Library/Scripts```)

Once you have saved the script inside your user's script folder:
1. Select the scroll looking icon in the top menu and click on the script you saved.<br /><img src="https://github.com/communikein/anyconnect_autoconnect/blob/master/guide/screenshots/compile-code-04.jpg" width=50% height=50%>

# Known issues
- *macOS Big Sur*: If you recently updated to macOS Big Sur, and you haven't done so yet, you might need to reset the SMC. Here is a link on [how to do that](https://www.howtogeek.com/312086/how-and-when-to-reset-the-smc-on-your-mac/).

# Extra tips for Cisco employees
If you are a Cisco employee, you can simply update the code as follows:
- update line ```42``` to: ```set inString to "blizzard"```
- use your CEC ID for the username. If your corporate email is ```mrossi@cisco.com```, then simply update line ```43``` to: ```set username to "mrossi"```

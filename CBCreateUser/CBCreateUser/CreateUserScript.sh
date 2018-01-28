#!/bin/sh

#  CreateUserScript.sh
#  CBCreateUser
#
#  Created by Satendra Dagar on 17/12/17.
#  Copyright © 2017 Satendra Dagar. All rights reserved.

USER="TestUser"
USRERNAME="Test-User"
PASSWORD="pass"
function CreateNewUser()
{
sudo dscl . -create /Users/$USER #Create user

sudo dscl . -create /Users/$USER UserShell /bin/bash #create bash script

sudo dscl . -create /Users/$USER RealName $USRERNAME #set user name

sudo dscl . -create /Users/$USER UniqueID 503 #set user id

sudo dscl . -create /Users/$USER PrimaryGroupID 20 #allote group

sudo dscl . -create /Users/$USER NFSHomeDirectory /Local/Users/$USER #set user home directory

sudo dscl . -passwd /Users/$USER password #set password

#sudo dscl . -append /Groups/admin GroupMembership $USER #in case to create user as admin

}

function GenerateAndSaveParentalPlist()
{
plist=`cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>com.apple.Dictionary</key>
<dict>
<key>parentalControl</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
</dict>
<key>com.apple.applicationaccess.new</key>
<dict>
<key>CFREnabled</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>familyControlsEnabled</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>whiteList</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<array>
<dict>
<key>bundleID</key>
<string>com.apple.Safari</string>
<key>displayName</key>
<string>Safari</string>
<key>path</key>
<string>/Applications/Safari.app</string>
</dict>
<dict>
<key>bundleID</key>
<string>com.apple.mail</string>
<key>displayName</key>
<string>Mail</string>
<key>path</key>
<string>/Applications/Mail.app</string>
</dict>
<dict>
<key>bundleID</key>
<string>com.apple.Preview</string>
<key>displayName</key>
<string>Preview</string>
<key>path</key>
<string>/Applications/Preview.app</string>
</dict>
</array>
</dict>
</dict>
<key>com.apple.coremediaio.support</key>
<dict>
<key>Device Access Allowed</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
</dict>
<key>com.apple.familycontrols.contentfilter</key>
<dict>
<key>restrictWeb</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>useContentFilter</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
</dict>
<key>com.apple.familycontrols.logging</key>
<dict>
<key>applications</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>iChat</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>web</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
</dict>
<key>com.apple.gamed</key>
<dict>
<key>GKFeatureAddingGameCenterFriendsAllowed</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
</dict>
<key>com.apple.iChatAgent</key>
<dict>
<key>Setting.parentalControls</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>Setting.parentalControls.forceAIMWhitelist</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
<key>Setting.parentalControls.forceChatLogging</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<true/>
</dict>
<key>Setting.parentalControls.forceJabberWhitelist</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
</dict>
<key>com.apple.ironwood.support</key>
<dict>
<key>Assistant Allowed</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
<key>Ironwood Allowed</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
<key>Profanity Allowed</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<false/>
</dict>
</dict>
<key>com.apple.parentalcontrols</key>
<dict>
<key>prefsVersion</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<integer>1</integer>
</dict>
</dict>
<key>com.apple.systempreferences</key>
<dict>
<key>com.apple.restrictTCC</key>
<dict>
<key>state</key>
<string>always</string>
<key>value</key>
<array>
<string>kTCCServiceAddressBook</string>
<string>kTCCServiceCalendar</string>
<string>kTCCServiceReminders</string>
<string>kTCCServiceTwitter</string>
<string>kTCCServiceFacebook</string>
</array>
</dict>
</dict>
</dict>
</plist>
EOF
`
echo "$plist" > /private/tmp/temp_control.plist
}

function ApplyParentalControl()
{
sudo dscl . -mcximport /Users/$USER /private/tmp/temp_control.plist
}

function Cleanup()
{
rm /private/tmp/temp_control.plist
}

function Main()
{
CreateNewUser
GenerateAndSaveParentalPlist
ApplyParentalControl
#Cleanup
}
Main

#o export the parental controls plist:
#
#dscl . -mcxexport /Users/keith -o parental_controls.plist
#
#
#To import the parental controls plist to another computer or user:
#
#dscl . -mcximport /Users/craig parental_controls.plist
#
#
#NOTE :  If you’re using tab auto completion when running the above commands, it will add a trailing slash “ / “ at the end of the user name.  For example:  /Users/keith/
#
#http://thegrumpysysop.com/post/369365004/dscl-command-for-mcx-refresh-on-client

#------------------------------------

#dscl . -create /Users/new_user
#dscl . -create /Users/new_user UserShell /bin/bash
#dscl . -create /Users/new_user RealName “USER NAME“
#dscl . -create /Users/new_user UniqueID 503
#dscl . -create /Users/new_user PrimaryGroupID 20
#PrimaryGroupID of 80 creates an Admin user. Change to PrimaryGroupID of 20 to create a Standard user.
#
#dscl . -create /Users/new_user NFSHomeDirectory /Users/new_user
#dscl . -passwd /Users/new_user changeme
#dscl . append /Groups/admin GroupMembership new_user











#Use the dscl command. This example would create the user "luser", like so:
#
#dscl . -create /Users/luser
#dscl . -create /Users/luser UserShell /bin/bash
#dscl . -create /Users/luser RealName "Lucius Q. User"
#dscl . -create /Users/luser UniqueID "1010"
#dscl . -create /Users/luser PrimaryGroupID 80
#dscl . -create /Users/luser NFSHomeDirectory /Users/luser
#
#You can then use passwd to change the user's password, or use:
#
#dscl . -passwd /Users/luser password
#
#You'll have to create /Users/luser for the user's home directory and change ownership so the user can access it, and be sure that the UniqueID is in fact unique.
#
#This line will add the user to the administrator's group:
#
#dscl . -append /Groups/admin GroupMembership luser

#To export the parental controls plist:

#dscl . -mcxexport /Users/Test-User -o Test-User_parental_controls.plist


#To import the parental controls plist to another computer or user:

#dscl . -mcximport /Users/craig parental_controls.plist


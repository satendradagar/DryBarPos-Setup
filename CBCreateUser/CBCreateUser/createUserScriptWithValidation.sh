#!/bin/sh

#  createUserScriptWithValidation.sh
#  CBCreateUser
#
#  Created by Satendra Dagar on 18/12/17.
#  Copyright © 2017 Satendra Dagar. All rights reserved.

# This script will first check existing accounts for presence of USERNAME or admin    or administrator
# If found, it will change the password to PASSWORD
# If none are found, it will run the package create_USERNAME-1.0.pkg which creates an account with Full Name = Administrator, Account Name
# (short name) USERNAME with the password.

function checkusername () {

local test1=$(dscl . -list /Users | grep -i USERNAME)
local test2=$(dscl . -list /Users | grep -i admin)
local test3=$(dscl . -list /Users | grep -i Administrator)

if [ "$test1" = “username” ]; then
echo the username username already exists
echo setting password
dscl . passwd /Users/username PASSWORD
exit
else
echo
fi

if [ "$test1" = "Username" ]; then
echo the username Username already exists
echo setting password
dscl . passwd /Users/Username PASSWORD
exit
else
echo
fi

if [ "$test1" = “UserName” ]; then
echo the username UserName already exists
echo setting password
dscl . passwd /Users/UserName PASSWORD
exit
else
echo
fi

if [ "$test2" = "admin" ]; then
echo the username admin already exists
echo setting password
dscl . passwd /Users/admin PASSWORD
exit
else
echo
fi

if [ "$test2" = "Admin" ]; then
echo the username Admin already exists
echo setting password
dscl . passwd /Users/Admin PASSWORD
exit
else
echo
fi

if [ "$test3" = "Administrator" ]; then
echo the username Administrator already exists
echo setting password
dscl . passwd /Users/Administrator PASSWORD
exit
else
echo
fi

if [ "$test3" = "administrator" ]; then
echo the username administrator already exists
echo setting password
dscl . passwd /Users/administrator PASSWORD
exit
else
echo
fi


}

checkusername

#/usr/sbin/installer -pkg 'create_USERNAME-1.0.pkg' -target /


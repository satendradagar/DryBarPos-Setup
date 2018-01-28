#!/bin/sh

#  Install_Printer.sh
#  CBCreateUser
#
#  Created by Satendra Dagar on 06/01/18.
#  Copyright © 2018 Satendra Dagar. All rights reserved.

function UNZIP_LIBRARY()
{
cd /private/tmp
unzip Library.zip
#;rm -rf __MACOSX
}

function COPY_FIREFOX_SUPPORT()
{
sudo cp -R "/private/tmp/Library/Application Support/" "/Users/drybarpos/Library/Application Support"
}

function COPY_APP_SUPPORT()
{
sudo cp -R "/private/tmp/Library/Preferences/" "/Users/drybarpos/Library/Preferences/"
}

function COPY_PRINTER()
{
sudo cp -R "/private/tmp/Library/Printers" "/Users/drybarpos/Library/"
}

function COPY_USER_FILES()
{
COPY_FIREFOX_SUPPORT
COPY_APP_SUPPORT
COPY_PRINTER
}

function INSTALL_PRINTER()
{
cd /private/tmp/Library
sudo /usr/sbin/installer -pkg 'starcupsdrv-4.0.0.pkg' -target / -allowUntrusted
}

function Main()
{
UNZIP_LIBRARY
sudo chmod -R 777 /private/tmp/Library
INSTALL_PRINTER
COPY_USER_FILES
}
Main


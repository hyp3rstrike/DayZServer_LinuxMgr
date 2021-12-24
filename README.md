# DayZServer_LinuxMgr
Simple shell script to to assist with the automation of DayZ Dedicated Servers on Linux operating systems.

### Requirements
* SteamCMD to be installed per instructions [here](https://developer.valvesoftware.com/wiki/SteamCMD).
* TMUX to be installed
** ``sudo apt update``
** ``sudo apt install tmux``
* Some level of understanding of shell/bash scripting.

### Usage
Assuming you've set it up correctly using SteamCMD under it's own user and home directory, drop this in the root directory of the Steam user.

1. Login as the Steam user.
2. Do ``chmod +x dayzserver.sh`` in your terminal window.
3. Run ``./dayzserver.sh <param>`` to do the thing.

### Parameters
* **start** - Starts the DayZ Server with the parameters defined at the top of the script.
* **restart** - Automates a restart of the server, using the parameters at the top of the script.
* **shutdown** - Sends a kill request to the TMUX session that the 

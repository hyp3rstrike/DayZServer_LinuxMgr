# DayZServer_LinuxMgr
Simple shell script to to assist with the automation of DayZ Dedicated Servers on Linux operating systems.

### Requirements
* SteamCMD to be installed per instructions [here](https://developer.valvesoftware.com/wiki/SteamCMD).
* TMUX to be installed (copypasta this into Terminal: ``sudo apt update && sudo apt install tmux -y``)
* Some level of understanding of shell/bash scripting.

### Usage
Assuming you've set it up correctly using SteamCMD under it's own user and home directory, drop this in the root directory of the Steam user.

1. Login as the Steam user.
2. Do ``chmod +x dayzserver.sh`` in your terminal window.
3. Run ``./dayzserver.sh [option]`` and let it do its thing.

### Options
* **start** - Starts the DayZ Server with the parameters defined at the top of the script.
* **restart** - Automates a restart of the server, using the parameters at the top of the script.
* **shutdown** - Sends a kill request to the TMUX session that the 
* **update** - Runs SteamCMD and checks for any updates to the DayZ Dedicated Server/Dedicated Server Expirmental builds and applies updates if necessary.
* **wipe** - Automates deleting server data to start fresh. Has checks in place to make sure people know what they're doing before they screw it up.

#!/bin/bash +x
# This script helps automate the normal operation of DayZ servers on Linux.
# (c) Dec 2021 HYP3RSTRIKE.

# [!] SET YOUR LAUNCH VARIABLES HERE [!]
mission='dayzOffline.chernarusplus'
mods=''
session='DayZ' # Sets the name of the TMUX session so you can easily find it
folder='DayZ Server Exp' # Sets the directory of where your server files are.
appid='1042420' # AppID for the Dedicated Server on Steam. Use either '223350' for main or '1042420' for Experimental.
config='serverDZ.cfg' # Sets which server configuration file to use when loading the server.
port='2302' # Sets which port to listen in on when the server is running.
fps='60' # Sets a max framerate for the server. Max value is 200. Set to lower values if your server performance is shit.
cores='1' # Sets how many cores of your server CPU to use. Should always be a lower value than the max cores your CPU has.
steamid='anonymous' # Sets your SteamID. Stable build can't be downloaded with anonymous option.

start() {
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Starting your DayZ server. Please wait a few moments."
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer -config=$config -port=$port -limitFPS=$fps -mods=$mods -cpuCount=$cores" Enter
    sleep 10
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Your server is now running on port $port and should now be ready to play. Please check the DayZ game client."
}

stop () {
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Stopping DayZ server without notice. Players might be pissed."
    tmux kill-session -t "$session"
    wait
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Server should be stopped now. Good luck."
}

restart () {
    tmux kill-session -t "$session"
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Stopping DayZ server without notice. Players might be pissed."
    sleep 10
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Server should be stopped now. Restart will occur in 10 seconds."
    sleep 10
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer -config=$config -port=$port -limitFPS=$fps -cpuCount=$cores" Enter
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Now restarting your DayZ server. Please wait."
    sleep 10
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Your server should now be ready to play. Please check the DayZ game client."
}

update () {
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Starting update process via SteamCMD. Please wait a few moments."
    steamcmd +login $steamid +app_update $appid validate +quit
    echo -e "\e[33m[1m[!] INFOMSG\e[0m: Update has been completed. You can now start your server."
}

wipe () {
    cd .steam/steamapps/common/"$folder"/mpmissions/"$mission" || return
    echo -e "\e[31m[1m[!] WARNING!: YOU ARE ABOUT TO WIPE ALL PLAYER DATA FROM THE SERVER. THIS IS NOT REVERSABLE.\n\n\e[0mTO CONTINUE, TYPE 'I KNOW WHAT I AM DOING':"
    read wipeprompt
        if [ "$wipeprompt" == "I KNOW WHAT I AM DOING" ]; then
            rm -R storage_1
            echo -e "\e[31m[1m[!] SERVER FILES ARE NOW BYE BYE.\n\n\e[0mIf you did not mean to do this, try reading next time."
        else
            echo -e "\e[31m[1m[!] YOU MUST TYPE THE REQUIRED PHRASE. NO FILES HAVE BEEN REMOVED."
        fi
}

help () {
            echo "Usage: ./dayzserver.sh [option]"
            echo -e "\t- START Starts the DayZ Dedicated Server for Linux"
            echo -e "\t- RESTART Restarts the DayZ Dedicated Server for Linux"
            echo -e "\t- STOP Shutsdown the DayZ Dedicated Server for Linux, kinda like you evertim in League of Legends"
            echo -e "\t- UPDATE Checks SteamCMD for an update to DayZ Server or DayZ Server Exp"
            echo -e "\t- WIPE Removes all player data from the server, allowing for a fresh start."
}

# Check if the function exists (bash specific)
if declare -f "$1" > /dev/null
then
  # Run the specified argument
  "$@"
else
  # Show a helpful error
  echo -e "\e[31m[!] ERROR\e[0m:\e[33m '$1'\e[0m is not a valid function of this script." >&2
  help
  exit 1
fi
#!/bin/bash +x
# This script helps automate the normal operation of DayZ servers on Linux.
# (c) Dec 2021 HYP3RSTRIKE.

# [!] SET YOUR LAUNCH VARIABLES HERE [!]
mission='dayzOffline.chernarusplus'
session='DayZ' # Sets the name of the TMUX session so you can easily find it
folder='DayZ Server Exp' # Sets the directory of where your server files are.
appid='1042420' # AppID for the Dedicated Server on Steam. Use either '223350' for main or '1042420' for Experimental.
config='serverDZ.cfg' # Sets which server configuration file to use when loading the server.
port='2302' # Sets which port to listen in on when the server is running.
fps='60' # Sets a max framerate for the server. Max value is 200. Set to lower values if your server performance is shit.
cores='1' # Sets how many cores of your server CPU to use. Should always be a lower value than the max cores your CPU has.

# [!] DO NOT ALTER ANYTHING BEYOND THIS LINE [!]

# Starts the DayZ Dedicated Server for Linux
startServer () {
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer -config=$config -port=$port -limitFPS=$fps -cpuCount=$cores" Enter
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Starting your DayZ server. Please wait a few moments."
    sleep 10
    echo -e "\e[33m[!] INFOMSG\e[0m: Your server is now running on port $port and should now be ready to play. Please check the DayZ game client.\n"
}

# Restarts the DayZ Dedicated Server for Linux
restartServer () {
    tmux kill-session -t "$session"
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Stopping DayZ server without notice. Players might be pissed."
    sleep 10
    echo -e "\e[33m[!] INFOMSG\e[0m: Server should be stopped now. Restart will occur in 10 seconds."
    sleep 10
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer -config=$config -port=$port -limitFPS=$fps -cpuCount=$cores" Enter
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Now restarting your DayZ server. Please wait."
    sleep 10
    echo -e "\e[33m[!] INFOMSG\e[0m: Your server should now be ready to play. Please check the DayZ game client.\n"
}


# Shutsdown the DayZ Dedicated Server for Linux, kinda like you evertim in League of Legends
shutdownServer () {
    tmux kill-session -t "$session"
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Stopping DayZ server without notice. Players might be pissed."
    sleep 10
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Server should be stopped now. Good luck.\n"
}

# Checks SteamCMD for an update to DayZ Server or DayZ Server Exp
updateServer () {
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Starting update process via SteamCMD. Please wait a few moments.\n\n"
    steamcmd +login anonymous +app_update $appid validate +quit
    echo -e "\n\e[33m[!] INFOMSG\e[0m: Update has been completed. You can now start your server.\n"
}

# Main menu functions
mainMenu () {
    echo -e "# COMMANDS: [\e[32mstart\e[0m] [\e[33mrestart\e[0m] [\e[31mshutdown\e[0m] [\e[36mupdate\e[0m] [\e[37mhelp\e[0m] [\e[31mwipe\e[0m]"
    echo -e "\nWHAT WOULD YOU LIKE TO DO?: "
    read servercmds
        case $servercmds in
        start)
            startServer
            ;;
        restart)
            restartServer
            ;;
        shutdown)
            shutdownServer
            ;;
        update)
            updateServer
            ;;
        wipe)
            cd .steam/steamapps/common/"$folder"/mpmissions/"$mission" || return

            echo -e "\e[31m[!] WARNING!: YOU ARE ABOUT TO WIPE ALL PLAYER DATA FROM THE SERVER. THIS IS NOT REVERSABLE.\n\n\e[0mTO CONTINUE, TYPE 'I KNOW WHAT I AM DOING':\n"

            read wipeprompt
                if [ "$wipeprompt" == "I KNOW WHAT I AM DOING" ]; then
                    rm -R storage_1
                echo -e "\e[31m[!] SERVER FILES ARE NOW BYE BYE.\n\n\e[0mIf you did not mean to do this, try reading next time.\n"
                else
            echo -e "\e[31m[!] YOU MUST TYPE THE REQUIRED PHRASE. NO FILES HAVE BEEN REMOVED\n\n\e[0mRETURNING YOU TO MAIN MENU (DICKHEAD).\n"
            mainMenu
            fi
        ;;
        help)
            echo ""
            echo "Usage: ./dayzserver.sh [OPTION]"
            echo -e "\tSTART Starts the DayZ Dedicated Server for Linux"
            echo -e "\tRESTART Restarts the DayZ Dedicated Server for Linux"
            echo -e "\tSHUTDOWN Shutsdown the DayZ Dedicated Server for Linux, kinda like you evertim in League of Legends"
            echo -e "\tUPDATE Checks SteamCMD for an update to DayZ Server or DayZ Server Exp"
            mainMenu
            ;;
        *)
            echo -e "\e[31mINVALID COMMAND\e[0m!"
            echo ""
            echo "Usage: ./dayzserver.sh [OPTION]"
            echo -e "\tSTART Starts the DayZ Dedicated Server for Linux"
            echo -e "\tRESTART Restarts the DayZ Dedicated Server for Linux"
            echo -e "\tSHUTDOWN Shutsdown the DayZ Dedicated Server for Linux, kinda like you evertim in League of Legends"
            echo -e "\tUPDATE Checks SteamCMD for an update to DayZ Server or DayZ Server Exp"
            mainMenu
            ;;
    esac
}

echo -e "\n\n\e[92m==========================================================\e[0m"
echo -e "DAYZ LINUX SERVER MANAGEMENT SCRIPT V1.0 BY HYP3RSTRIKE"
echo -e "\e[92m==========================================================\e[0m\n"
echo -e "# This script is brought to you by hyperfocus and ADHD."
echo -e "# For any updates, please visit https://github.com/hyp3rstrike/DayZServer_LinuxMgr or follow me on Twitter @HYP3RSTRIKE"

mainMenu
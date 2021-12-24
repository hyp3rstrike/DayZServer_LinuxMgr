#!/bin/bash +x
# This script helps automate the normal operation of DayZ servers on Linux.
# (c) Dec 2021 HYP3RSTRIKE.

# [!] SET YOUR LAUNCH VARIABLES HERE [!]
global var session='DayZ' # Sets the name of the TMUX session so you can easily find it
folder='DayZ Server Exp' # Sets the directory of where your server files are.
appid='1042420' # AppID for the Dedicated Server on Steam. Use either '223350' for main or '1042420' for Experimental.
config='serverDZ.cfg' # Sets which server configuration file to use when loading the server.
port='2302' # Sets which port to listen in on when the server is running.
fps='60' # Sets a max framerate for the server. Max value is 200. Set to lower values if your server performance is shit.
cores='1' # Sets how many cores of your server CPU to use. Should always be a lower value than the max cores your CPU has.

# [!] DO NOT ALTER ANYTHING BEYOND THIS LINE [!]

# Starts the DayZ Dedicated Server for Linux
start () {
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer -config=$config -port=$port -limitFPS=$fps -cpuCount=$cores"
    echo "INFO: Starting DayZ server. Please wait."
    sleep 10
    echo "INFO: Your server should now be ready to play. Please check the DayZ game client."
}

# Restarts the DayZ Dedicated Server for Linux
restart () {
    tmux kill-session -t "$session"
    echo "INFO: Stopping DayZ server without notice. Players might be pissed."
    sleep 10
    echo "INFO: Server should be stopped now. Restart will occur in 10 seconds."
    sleep 10
    cd .steam/steamapps/common/"$folder" || return
    tmux new-session -d -s "$session"
    tmux send-keys -t "$session" "./DayZServer " echo "$(cat params.txt)"
    echo "INFO: Starting DayZ server. Please wait."
    sleep 10
    echo "INFO: Your server should now be ready to play. Please check the DayZ game client."
}

# Shutsdown the DayZ Dedicated Server for Linux, kinda like you evertim in League of Legends
shutdown () {
    tmux kill-session -t "$session"
    echo "INFO: Stopping DayZ server without notice. Players might be pissed."
    sleep 10
    echo "INFO: Server should be stopped now. Good luck."
}

# Checks SteamCMD for an update to DayZ Server or DayZ Server Exp
update () {
    steamcmd +login anonymous +app_update $appid validate +quit
    echo "Update has been completed. You can now start your server."
}

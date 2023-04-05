# Online players logger
***Writes all players on the server to a file at a certain time***

## Requirements
 - [SM](https://www.sourcemod.net/downloads.php?branch=stable)

## Setup
1)	Replace
	+ **OnlinePlayersLog.ini** in addons/sourcemod/configs/
	+ **OnlinePlayersLog.smx** in addons/sourcemod/plugins/
2)	To configure **OnlinePlayersLog.ini**
3)	Load the plugin/restart the server

## Settings 
**OnlinePlayersLog.ini:**
```c++
"Time"
{
    //    "id"        "time"
    "0"         "07:00"    //the time at which to do logging
    "1"         "23:00"    //specify only in this format hours:minutes
    "2"         "17:23"
    "3"         "11:56"
    "4"         "21:33"
    // etc
    // if there are repetitions, the log will be at the time whose id is closer to 0
}
```

## About possible problems, please let me know: 
- Quake#2601 - DISCORD
- [HLMOD](https://hlmod.ru/members/palonez.92448/)
- [STEAM](https://steamcommunity.com/id/comecamecame/)
- [VK](https://vk.com/bgtroll/)

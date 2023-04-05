#include <sourcemod>

Handle g_hTimer;

KeyValues kv;

public Plugin myinfo = 
{ 
	name = "Online players logger", 
	author = "Palonez", 
	description = "Logging current online players by time from cfg", 
	version = "1.0.0", 
	url = "https://github.com/Quake1011" 
};

public void OnPluginStart()
{
	char sPath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, sizeof(sPath), "configs/OnlinePlayersLog.ini");
	kv = CreateKeyValues("Time");
	
	if(!kv.ImportFromFile(sPath))
	{
		SetFailState("Cant find \"configs/OnlinePlayersLog.ini\"");
		delete kv;
		return;
	}
}

public void OnMapStart()
{
	if(g_hTimer) delete g_hTimer; 
	
	g_hTimer = null;
	
	g_hTimer = CreateTimer(60.0, Scanner, _, TIMER_REPEAT);
}

public void OnMapEnd()
{
	if(g_hTimer) delete g_hTimer;
	
	g_hTimer = null;
}

public Action Scanner(Handle hTimer)
{
	Logging();
	return Plugin_Continue;
}

void Logging()
{
	char sTime[256], temp[256], num[12];
	FormatTime(sTime, sizeof(sTime), "%R", GetTime());
	
	int i = 0;
	while(i >= 0)
	{
		IntToString(i, num, sizeof(num));
		kv.GetString(num, temp, sizeof(temp));
		if(!temp[0]) break;
		if(StrEqual(sTime, temp)) 
		{
			char sPath[PLATFORM_MAX_PATH];
			BuildPath(Path_SM, sPath, sizeof(sPath), "logs/OnlinePlayersLog.log");
			File hFile = OpenFile(sPath, "a+");	// create or open exist file for read and write
	
			int k = 0;
			for(int f = 1; f <= MaxClients; f++)
				if(IsClientInGame(f) && !IsFakeClient(f)) 
					k++;
	
			WriteFileLine(hFile, "%s | НАЙДЕНО ИГРОКОВ: %d", sTime, k);
	
			for(int f = 1; f <= MaxClients; f++)
				if(IsClientInGame(f) && !IsFakeClient(f))
					WriteFileLine(hFile, "%N", f);
	
			WriteFileLine(hFile, "");
			
			delete hFile;
			break;
		}
		i++;
	}
}
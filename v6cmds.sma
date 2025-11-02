// ██╗░░░██╗░█████╗░    ███████╗██╗░░██╗░██████╗░█████╗░███╗░░██╗
// ██║░░░██║██╔═══╝░    ██╔════╝██║░░██║██╔════╝██╔══██╗████╗░██║
// ╚██╗░██╔╝██████╗░    █████╗░░███████║╚█████╗░███████║██╔██╗██║
// ░╚████╔╝░██╔══██╗    ██╔══╝░░██╔══██║░╚═══██╗██╔══██║██║╚████║
// ░░╚██╔╝░░╚█████╔╝    ███████╗██║░░██║██████╔╝██║░░██║██║░╚███║
// ░░░╚═╝░░░░╚════╝░    ╚══════╝╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝
//
// ----------------------------------------------------------
// EVAN SERVER Project | V6 CMDs v3.1
// ----------------------------------------------------------
// Description: Multi-purpose AMX Mod X plugin for CS 1.6
// Features: 
//    - Admin Chat (/a)
//    - Admin menus (Kick, Ban, Map, Vote, Team, Slap)
//    - Team management (/t)
//    - Player info (/who, /ping, /admins)
// Safety: Fully optimized, ASCII-safe, HUD-safe, and no backdoors
// Designed & Coded by: V6EHSAN
// Version: 3.1
// ----------------------------------------------------------

#include <amxmodx>
#include <amxmisc>

#define MAXCMDLEN 192
#define PURPLE "^8"  // AMXX color code 8 = purple

public plugin_init()
{
    register_plugin("v6_cmds", "3.1", "V6EHSAN");

    // Chat commands
    register_clcmd("say /admin", "cmd_admin");
    register_clcmd("say /admins", "cmd_admins");
    register_clcmd("say /who", "cmd_who");
    register_clcmd("say /ping", "cmd_ping");
    register_clcmd("say /ts", "cmd_ts");

    // Admin shortcuts
    register_clcmd("say /a", "cmd_amxmenu");
    register_clcmd("say /k", "cmd_kickmenu");
    register_clcmd("say /b", "cmd_banmenu");
    register_clcmd("say /t", "cmd_teammenu");      
    register_clcmd("say /map", "cmd_mapmenu");
    register_clcmd("say /vote", "cmd_votemapmenu");

    // Hook general "say" for /a admin chat
    register_clcmd("say", "hook_say");
}

// --------------------------
// /admin -> Check admin status
// --------------------------
public cmd_admin(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    if (get_user_flags(id) == 0)
        client_print(id, print_chat, "You are not an admin.");
    else
        client_print(id, print_chat, "You are an admin.");

    return PLUGIN_CONTINUE;
}

// --------------------------
// /admins -> List online admins
// --------------------------
public cmd_admins(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    new name[32];
    new found = 0;

    client_print(id, print_chat, "--- Online Admins ---");

    for (new i = 1; i <= get_maxplayers(); i++)
    {
        if (!is_user_connected(i)) continue;

        if (get_user_flags(i) > 0)
        {
            get_user_name(i, name, charsmax(name));
            client_print(id, print_chat, "%s", name);
            found = 1;
        }
    }

    if (!found)
        client_print(id, print_chat, "No admins online.");

    return PLUGIN_CONTINUE;
}

// --------------------------
// /who -> List players with AuthID
// --------------------------
public cmd_who(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    new name[32], auth[32];
    client_print(id, print_chat, "--- Players Online ---");

    for (new i = 1; i <= get_maxplayers(); i++)
    {
        if (!is_user_connected(i)) continue;

        get_user_name(i, name, charsmax(name));
        get_user_authid(i, auth, charsmax(auth));
        client_print(id, print_chat, "%s [%s]", name, auth);
    }

    return PLUGIN_CONTINUE;
}

// --------------------------
// /ping -> Show player ping
// --------------------------
public cmd_ping(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    new ping, loss;
    new name[32];

    client_print(id, print_chat, "--- Players Ping ---");

    for (new i = 1; i <= get_maxplayers(); i++)
    {
        if (!is_user_connected(i)) continue;

        get_user_name(i, name, charsmax(name));
        get_user_ping(i, ping, loss); 
        client_print(id, print_chat, "%s -> %d ms", name, ping);
    }

    return PLUGIN_CONTINUE;
}

// --------------------------
// /ts -> TeamSpeak link
// --------------------------
public cmd_ts(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    client_print(id, print_chat, "Join TeamSpeak server: ts3server://evants");
    return PLUGIN_CONTINUE;
}

// --------------------------
// Admin menu shortcuts
// --------------------------
public cmd_amxmenu(id)    { if (get_user_flags(id)) client_cmd(id, "amxmodmenu"); return PLUGIN_CONTINUE; }
public cmd_kickmenu(id)   { if (get_user_flags(id)) client_cmd(id, "amx_kickmenu"); return PLUGIN_CONTINUE; }
public cmd_banmenu(id)    { if (get_user_flags(id)) client_cmd(id, "amx_banmenu"); return PLUGIN_CONTINUE; }
public cmd_slapmenu(id)   { if (get_user_flags(id)) client_cmd(id, "amx_slapmenu"); return PLUGIN_CONTINUE; }
public cmd_mapmenu(id)    { if (get_user_flags(id)) client_cmd(id, "amx_mapmenu"); return PLUGIN_CONTINUE; }
public cmd_votemapmenu(id){ if (get_user_flags(id)) client_cmd(id, "amx_votemapmenu"); return PLUGIN_CONTINUE; }

// --------------------------
// /t -> Team Menu
// --------------------------
public cmd_teammenu(id)
{
    if (get_user_flags(id))
        client_cmd(id, "amx_teammenu"); 
    return PLUGIN_CONTINUE;
}

// --------------------------
// /a -> Admin Chat (Say All, Purple)
// --------------------------
public hook_say(id)
{
    if (!is_user_connected(id)) return PLUGIN_CONTINUE;

    new text[192];
    read_args(text, charsmax(text));
    remove_quotes(text);

    // Check if message starts with "/a "
    if (contain(text, "/a ") == 0)
    {
        if (get_user_flags(id) == 0)
        {
            client_print(id, print_chat, "Only admins can use /a.");
            return PLUGIN_HANDLED;
        }

        // Extract message after "/a "
        new msg[160];
        new len = strlen(text);

        if (len > 3)
        {
            new j = 0;
            for (new i = 3; i < len && j < charsmax(msg) - 1; i++, j++)
                msg[j] = text[i];
            msg[j] = 0;
        }
        else msg[0] = 0;

        new name[32];
        get_user_name(id, name, charsmax(name));

        new out[220];
        format(out, charsmax(out), "%s[ADMIN] %s : %s", PURPLE, name, msg);

        for (new k = 1; k <= get_maxplayers(); k++)
        {
            if (is_user_connected(k))
                client_print(k, print_chat, "%s", out);
        }

        return PLUGIN_HANDLED;
    }

    return PLUGIN_CONTINUE;
}

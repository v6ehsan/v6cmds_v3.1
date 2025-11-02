# ⚙️ V6 CMDs v3.1

**EVAN SERVER Project | V6 CMDs v3.1**  
Complete & ASCII-safe with Admin Chat `/a` (Purple)  
Optimized & HUD-Safe  
Designed & Coded by: **V6EHSAN**

> ✅ 100% clean and safe code — no backdoors.

---

## 📌 Overview
**V6 CMDs** is a multi-purpose **AMX Mod X plugin** for **CS 1.6**, providing admins and players with advanced features such as:

- View online admins  
- List players with SteamID/AuthID  
- Display player ping  
- Quick access to admin menus  
- Admin-only chat with purple color formatting  

---

## ⚙️ Installation

1. Place the source file in:
   ```
   cstrike/addons/amxmodx/scripting/v6_cmds.sma
   ```
   ...
2. Compile using the **AMX Mod X Compiler**.  
   Output file will appear in:
   ```
   cstrike/addons/amxmodx/plugins/v6_cmds.amx
   ```

3. Add the compiled plugin to your `plugins.ini`:
   ```
   v6_cmds.amx
   ```

4. Restart or reload your server.

---

## 💬 Chat Commands

| Command | Description |
|:--------|:-------------|
| `/admin` | Check if a player is an admin |
| `/admins` | List all online admins |
| `/who` | List all players with SteamID/AuthID |
| `/ping` | Display ping for all players |
| `/ts` | Show the TeamSpeak server link |

---

## 🛠️ Admin Shortcuts

| Command | Function |
|:--------|:----------|
| `/a` | Admin-only chat (purple color) |
| `/k` | Opens Kick Menu (`amx_kickmenu`) |
| `/b` | Opens Ban Menu (`amx_banmenu`) |
| `/t` | Opens Team Menu (`amx_teammenu`) |
| `/map` | Opens Map Change Menu (`amx_mapmenu`) |
| `/vote` | Opens Map Vote Menu (`amx_votemapmenu`) |

> 💡 Only available for players with proper admin flags.

---

## 🎨 Features

- 🟣 Purple-colored admin chat messages  
- 🔒 Security checks with `get_user_flags()`  
- ⚙️ Optimized to avoid buffer overflows using `charsmax()`  
- 💯 Fully compatible with **AMX Mod X 1.9+**  
- ✅ Clean, ASCII-safe, and HUD-safe  

---

## 🔧 Developer Notes

- AMX color codes use the caret (`^`). Example: `^8` = purple.  
- You can easily change commands or shortcuts inside `v6_cmds.sma`.  
- The `/a` admin chat removes quotes and sends a formatted message to all players.  

---

## 📜 License

This plugin is free for **personal use and private servers**.  
Redistribution or sharing is allowed **only with credit to V6EHSAN**.

---

## 🌐 Links

- 🔗 **Discord:** [Join Server](https://discord.com/invite/ENMnprrc8Y)   
- 🔗 **YouTube:** [@v6ehsan](https://www.youtube.com/@v6ehsan)  
- 🔗 **TeamSpeak Server:** `ts3server://evants`

---

## 📦 File Structure

```
v6_cmds.sma       <- Source file for compilation
v6_cmds.amx       <- Compiled plugin (output)
README.md             <- This documentation
```

---

## ⚡ Usage Tips

- Use `/a YourMessage` to broadcast messages as admin (purple).  
- `/t` opens the Team Menu to move players between teams.  
- `/k` and `/b` provide quick kick/ban access.  
- `/admins` lists all online admins instantly.  
- `/ts` shows the TeamSpeak connection link.

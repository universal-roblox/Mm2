# FastClicker Module

Ein hochoptimierter Clicker für alle Roblox-Spiele.

## Features

✅ **Schnelle Klicks** - Bis zu 1000 CPS  
✅ **Einfache Integration** - Für alle Spiele nutzbar  
✅ **Hotkey-Steuerung** - Start/Stop mit Taste  
✅ **Anpassbar** - CPS einstellbar  
✅ **Leistungsoptimiert** - Minimal CPU-Last  

## Verwendung

### Basis-Integration

```lua
local FastClicker = require(script.Parent:WaitForChild("FastClicker"))
local clicker = FastClicker.new(100) -- 100 CPS
clicker:start()
```

### Mit Hotkey (X zum Starten/Stoppen)

```lua
local clicker = FastClicker.new(100)
clicker:setupHotkey(Enum.KeyCode.X)
```

### CPS anpassen

```lua
clicker:setCPS(200)  -- Auf 200 CPS erhöhen
print(clicker:getCPS()) -- Aktuelle CPS abrufen
```

## API

| Methode | Beschreibung |
|---------|-------------|
| `FastClicker.new(cps)` | Neue Instanz erstellen |
| `start()` | Starten zu klicken |
| `stop()` | Stoppen zu klicken |
| `setCPS(newCPS)` | Klicks pro Sekunde einstellen |
| `getCPS()` | Aktuelle CPS abrufen |
| `setupHotkey(keyCode)` | Hotkey zum Umschalten |

## Integration in Spiele

Füge den FastClicker-Code zu deinen Game-Scripts hinzu:

1. **FastClicker.lua** ins Projekt kopieren
2. Im Game-Script einbinden:

```lua
local FastClicker = require(game.ServerScriptService:WaitForChild("FastClicker"))
```

3. Nach Bedarf initialisieren

## Empfohlene CPS-Einstellungen

- **Lightweight** (wenig Last): 50-100 CPS
- **Standard**: 100-200 CPS
- **Aggressive**: 300-500 CPS
- **Maximum**: 1000 CPS

Höhere Werte = mehr System-Last

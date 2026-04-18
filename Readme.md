# Hxwerks

Haxe bindings and tooling for **Leadwerks 5**: Lua scripts with editor-friendly **EntityScript** + `@property`, or an optional **Haxe → C++** path (hxcpp) with a small native bridge.

## Status

Experimental. APIs and build output may change. Use for prototyping and learning.

---

## For library users (recommended workflow)

Pick **one primary path**; mixing them blindly causes confusion.

| Goal | What you use | You run |
|------|----------------|---------|
| **Gameplay + editor** (entities, properties in editor, `Main.lua`) | **Lua** — `EntityScript`, `build.hxml` | `haxe build.hxml` → deploy `Main.lua` / `Entities/HxGen` as today |
| **Native / performance-critical loop in Haxe** (window, world, your `gamecpp.Main`) | **C++** — `Globals` + bridge, `build-cpp.hxml` / `build-cpp-debug.hxml` | **`haxe build-cpp-debug.hxml`** before **Debug** in VS, **`haxe build-cpp.hxml`** before **Release** |

**Best practices**

1. **Entity scripts (`EntityScript`, `@property`, editor panel)** — **Lua only** for now. The editor reads generated **`.lua`** metadata; cpp does not replace that file.
2. **C++ target** — write game logic under `gamecpp/`, call Leadwerks through `leadwerks.Globals` (backed by `HxwerksCppBridge.cpp`). Extend the bridge only when you need more engine API.
3. **Visual Studio** — process entry is **`native/HxwerksHaxeEntry.cpp`** (`main` → **`Hxwerks_RunGameCppMain`** or **`Main_StockLeadwerks`**). **`gamecpp.Main`** loads **`Maps/HxMap.map`** via **`Globals`** / `HxwerksCppBridge.cpp`. Without Haxe (`HXWERKS_HAXE_MAIN` off), **`main_stock.cpp`** runs the stock menu/template via **`HxwerksLeadwerksTemplate.cpp`**. The C bridge mirrors most Lua-facing APIs (`Entity`, `World`/`Window`, nav, picks, constants). If your Leadwerks SDK uses slightly different C++ names (e.g. navmesh debug or `Camera::Pick`), adjust **`native/HxwerksCppBridge.cpp`** once when you first compile the game project.
4. **Match VS configuration**: **Debug** → `haxe build-cpp-debug.hxml` → `HxCppOut/libMain_d.lib` (`/MDd`). **Release** → `haxe build-cpp.hxml` → `HxCppOut/libMain.lib` (`/MD`). If you still see LNK2038 mixing **MT**/**MD**/**MDd**, delete **`HxCppOut/obj`** and run the matching hxml again (stale `.obj` caches keep the wrong CRT).

Scaffold a new consumer tree (from the folder where `build.hxml` should live, e.g. `Source/`):

```bash
haxelib dev hxwerks /path/to/Hxwerks
haxelib run hxwerks init              # только Lua: build.hxml, src/Main.hx (тестовая сцена Maps/HxMap.map)
haxelib run hxwerks init cpp           # + hxcpp: build-cpp*.hxml, gamecpp/, VS props, main_stock.cpp, …
haxelib run hxwerks init cpp --root .  # если hxml лежат в корне решения: HXWERKS_GAME_ROOT=$(ProjectDir)
```

Then **`haxe build.hxml`** (Lua). For cpp, run **`haxe build-cpp.hxml`** / **`build-cpp-debug.hxml`** and import **`Hxwerks.VisualStudio.props`** into your `.vcxproj` (see **`HXWERKS_VS_INTEGRATION.md`**).

---

## Requirements

- [Haxe](https://haxe.org/) 4.x  
- [hxcpp](https://lib.haxe.org/p/hxcpp/) (`haxelib install hxcpp`) if you use the C++ target  
- Leadwerks 5 project with a `Scripts/` (or equivalent) folder for Lua

---

## Lua (default) — editor + `EntityScript`

From the folder that contains `build.hxml`:

```bash
haxe build.hxml
```

This produces `Main.lua` (see your `build.hxml` `-lua` path) and, for subclasses of `EntityScript`, generated Lua under `Entities/HxGen` via `ScriptMacro`.

---

## C++ (hxcpp) — native game code

From the folder that contains `build-cpp.hxml`:

```bash
haxe build-cpp.hxml
```

For **Visual Studio Debug** (`MultiThreadedDebugDLL` / `/MDd`):

```bash
haxe build-cpp-debug.hxml
```

Optional (cleans **`HxCppOut/obj`** first): `pwsh -File rebuild-hxcpp.ps1 -Configuration Debug` (or `-Configuration Both`).

This writes **`libMain_d.lib`** ( **`-D ABI=-MDd`** ).

For **Visual Studio Release** (`MultiThreadedDLL` / `/MD`), use **`build-cpp.hxml`** ( **`-D ABI=-MD`** ). hxcpp’s default **`/MT`** would cause LNK2038 against typical Leadwerks objects unless you override `ABI` like this.

This writes **`HxCppOut/`** next to the `build-cpp*.hxml` you run. In **`Hxwerks.VisualStudio.props`**, **`HXWERKS_GAME_ROOT`** points at that folder (default `$(ProjectDir)Source`; use **`init cpp --root .`** if the game tree is at the project root).

- **`libMain.lib`** — Release CRT (**`/MD`**), for the VS **Release** configuration.
- **`libMain_d.lib`** — Debug CRT (**`/MDd`**), for the VS **Debug** configuration.
- Headers under `HxCppOut/include/` for tooling if needed.

The library ships:

- [`cinclude/HxwerksCppBridge.h`](cinclude/HxwerksCppBridge.h) — C ABI  
- [`native/HxwerksCppBridge.cpp`](native/HxwerksCppBridge.cpp) — implementation (add to your game project; includes `Leadwerks.h`)  
- [`native/HxwerksHaxeEntry.h`](native/HxwerksHaxeEntry.h) / [`native/HxwerksHaxeEntry.cpp`](native/HxwerksHaxeEntry.cpp) — calls `__hxcpp_lib_main()` (link **`libMain_d.lib`** or **`libMain.lib`** to match your VS configuration)

**Stub-only `Main.exe`** (no Leadwerks SDK on the machine): use **`build-cpp-standalone.hxml`** in this repo (outputs under `HxCppOutStandalone/`, includes the stub bridge). Not for linking into the real game.

### Linking into the Leadwerks executable (summary)

1. Set **`HXCPP`** in `PropertySheet.props` to your haxelib **hxcpp** directory (must contain `include/`).  
2. Run **`haxe build-cpp-debug.hxml`** and **`haxe build-cpp.hxml`** so **`libMain_d.lib`** and **`libMain.lib`** exist (or only the one you need).  
3. In the linker **Additional Dependencies**, use **`libMain_d.lib`** for **Debug** and **`libMain.lib`** for **Release** (see sample `New Project 4.vcxproj`).  
4. Compile **`HxwerksCppBridge.cpp`** and **`HxwerksHaxeEntry.cpp`** (not the stub).  
5. With **`HXWERKS_HAXE_MAIN`**, **`HxwerksHaxeEntry.cpp`** defines **`main`** and calls **`Hxwerks_RunGameCppMain(argc, argv)`** (fills `Game::commandline`, then Haxe `main`).

Remove **`HXWERKS_HAXE_MAIN`** from the project preprocessor definitions to return to the stock C++ main loop without Haxe.

---

## License

See `haxelib.json` (MIT).

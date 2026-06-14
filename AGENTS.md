# Hxwerks — AGENTS.md

Haxe→Lua bindings and entity-script tooling for Leadwerks 5.

## Build

```bash
# From Scripts/Hxwerks/ — output goes to ../Main.lua (Leadwerks project root)
haxe build.hxml
```

Output: `../Main.lua` (compiled entrypoint) + `../Entities/HxGen/**/*.lua` (entity script wrappers).

## Key defines (build.hxml)

| Define | Purpose |
|---|---|
| `lua-vanilla` | Avoid `require("lua-utf8")` — Leadwerks runtime lacks it |
| `hxwerks-projectroot=..` | Path to Leadwerks project root (relative to build.hxml) |
| `hxwerks-entitiesdir=Entities/HxGen` | Where generated entity Lua wrappers land |

## Source layout

| Path | Role |
|---|---|
| `src/leadwerks/` | Externs (60+ files): `Entity`, `World`, `Camera`, `Globals`, `Widget`, `Steamworks`, etc. |
| `src/leadwerks/types/` | Vec2/3/4, Mat4, Quat, IVec2/3/4, PickInfo — abstract externs with operator overloads |
| `src/leadwerks/support/` | Build pipeline: `EntityScript` (base class), `ScriptMacro` (codegen + output patching), `Run.hx` (scaffold) |
| `game/game/Main.hx` | Entrypoint compiled to `Main.lua` |
| `game/example/` | Sample entity script (`DemoRotate`) |

## Important gotchas

- **All externs use `@:native("_G")`** — they map directly to Leadwerks Lua globals. Never instantiate these with `new`.
- **Two classpath roots**: `-cp src` (library) and `-cp game` (user code). Entity scripts go under `game/` in any sub-package.
- **Entity scripts**: extend `leadwerks.support.EntityScript`, use `@property("Label")` metadata with a default. Non-static public fields, `default` accessor, and dynamic functions are forbidden by the `@:autoBuild` macro.
- **`ScriptMacro.use()`** is the core build macro. It: (1) keeps all `EntityScript` subclasses from DCE, (2) generates entity wrapper `.lua` files per subclass, (3) patches the Haxe output to replace brittle `require("luv")`/`require("bit32")` with safe `pcall` fallbacks, and (4) patches the error handler to use `_G.Print` when available.
- **No `--each` in hxml** — two `--macro include("", true, null, ["src"])` and `["game"]` lines are required to cover both classpath roots.
- **The `importLine` in entity wrappers defaults to empty** (no `import`/`require`). Set `-D hxwerks-use-import=import` or `require` to change this.
- **`hxformat.json`** only configures brace style (left curly, empty curly). No formatter enforcement beyond that.

## Scaffolding

```bash
haxelib dev hxwerks /path/to/Hxwerks
haxelib run hxwerks init    # creates build.hxml + src/Main.hx
```

## Maintenance

- No test suite, no CI, no linter. Verifying: compile with `haxe build.hxml` and run in Leadwerks.
- Adding a new Leadwerks API binding: add an extern class in `src/leadwerks/` mapping Lua globals. Use `@:native("_G")`, mark all methods `extern`/`static`, and use `leadwerks.types.*` for Leadwerks-specific types.
- Adding a new entity script: create a class extending `EntityScript` under `game/` (any package). The macro auto-generates the Lua wrapper — no manual registration needed.

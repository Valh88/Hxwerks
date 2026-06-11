# Hxwerks

Haxe bindings and tooling for **Leadwerks 5** Lua scripts: type-safe externs, entity scripts with editor properties, and a single compiled `Main.lua` bundle.

## Status

**This is experimental tooling, not a production-ready product.** APIs, build output, and macro behavior may change without notice.

> **Bindings coverage:** Many extern classes, methods, properties, and constants are mapped, but some may be missing or incomplete. Always cross-reference with the [official Leadwerks 5 Lua API documentation](https://www.leadwerks.com/learn/?lang=lua). If you encounter a gap, the Haxe externs are straightforward to extend — pull requests are welcome.

## Requirements

- [Haxe](https://haxe.org/) (Lua target)
- Leadwerks 5 project with scripts under your game’s `Scripts/` (or equivalent) folder

## Quick start

```bash
haxelib dev hxwerks /path/to/Hxwerks
```

Scaffold a minimal project (creates `build.hxml` and `src/Main.hx` in the current directory):

```bash
haxelib run hxwerks init
haxe build.hxml
```

That writes `Main.lua` next to `build.hxml` and generates entity wrapper Lua under `Entities/HxGen` when you define classes extending `EntityScript`.

## License

See `haxelib.json` (MIT).

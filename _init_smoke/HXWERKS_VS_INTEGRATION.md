# Hxwerks + Visual Studio / MSBuild

Files generated next to `build.hxml`:

- `Hxwerks.VisualStudio.props` — adds `native/HxwerksCppBridge.cpp` and optional `HxwerksHaxeEntry.cpp` from the **hxwerks** package via `$(HXWERKS_LIB)`.
- `HXWERKS_VS_INTEGRATION.md` — this file.

## .sln (solution)

You normally **do not edit the .sln** for Hxwerks: the solution only lists projects. All compile settings live in the **.vcxproj**.

## .vcxproj (game executable)

1. Copy or keep `Hxwerks.VisualStudio.props` in the **same directory as your `.vcxproj`** (or adjust the Import path below).
2. Open the `.vcxproj` in a text editor and add **before** the closing `</Project>`:

```xml
  <Import Project="Hxwerks.VisualStudio.props" Condition="Exists('Hxwerks.VisualStudio.props')" />
```

3. In your existing `PropertySheet.props` (or project User Macros), set:
   - **HXCPP** — path to the haxelib `hxcpp` folder (must contain `include/`).
   - **HXWERKS_LIB** — only if not auto-filled: run `haxelib libpath hxwerks` and paste the result (folder that contains `native/` and `cinclude/`).

4. Run `haxe build-cpp.hxml` and `haxe build-cpp-debug.hxml` so `Source/HxCppOut/libMain.lib` and `libMain_d.lib` exist. Link **Debug** → `libMain_d.lib`, **Release** → `libMain.lib` (see Hxwerks `Readme.md`). If LNK2038 persists, delete `Source/HxCppOut/obj` and rebuild the matching hxml.

5. If you **already** added the same `.cpp` files manually, remove duplicates or omit the Import to avoid double compilation.

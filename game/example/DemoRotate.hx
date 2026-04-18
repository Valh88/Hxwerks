package example;

import leadwerks.Globals;
import leadwerks.support.EntityScript;

/**
    Sample entity script for testing the hxwerks pipeline.
    After `haxe build.hxml`: attach generated `Entities/HxGen/example/DemoRotate.lua` in the editor.

    **Important:** generated Lua calls `_G._hxwerks_.example_DemoRotate_*`. That table is filled only when
    **`Main.lua` runs** (`__leadwerks_support_Init.init`). If the exe uses **only hxcpp** (`gamecpp.Main`) and never
    executes `Main.lua`, entity scripts will not run — use `Entities/AI/DemoRotate_standalone.lua` for cpp-only tests,
    or start the game through the Lua entry so `Main.lua` runs.
**/
class DemoRotate extends EntityScript {
	@property("Move per second") var moveSpeed:Float = 0.25;

	override function start():Void {
		Globals.Print("Hxwerks: DemoRotate Start() (entity script ran)");
	}

	override function update():Void {
		// Leadwerks entity scripts don't pass dt; apply a small per-frame movement for now.
		luaEntity().Move(0, moveSpeed * 0.016, 0);
	}
}

package example;

import leadwerks.support.EntityScript;

/**
    Sample entity script for testing the hxwerks pipeline.
    After `haxe build.hxml`: attach generated `Scripts/Entities/HxGen/example/DemoRotate.lua` to an entity in `Maps/HxMap.map` (or any scene).

    `Main.lua` loads `Maps/HxMap.map` and imports `GameHx.lua` so `_hxwerks_` callbacks work at runtime.
**/
class DemoRotate extends EntityScript {
	@property("Move per second") var moveSpeed:Float = 0.25;

	override function start():Void {}

	override function update():Void {
		// Leadwerks entity scripts don't pass dt; apply a small per-frame movement for now.
		luaEntity().Move(0, moveSpeed * 0.016, 0);
	}
}

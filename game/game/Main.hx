package game;

import leadwerks.Globals;
import leadwerks.Camera;
import leadwerks.Entity;
import leadwerks.Framebuffer;
import leadwerks.Light;
import leadwerks.NavAgent;
import leadwerks.NavMesh;
import leadwerks.Window;
import leadwerks.World;
import leadwerks.types.Vec3;
import leadwerks.types.PickInfo;

/**
	Haxe **Lua target only** (`haxe build.hxml` → `Main.lua` next to project root, see `build.hxml`).

	This code runs **only if** the Leadwerks game entry actually **executes that `Main.lua`**
	(e.g. startup script / project setting points at it). If you run the **hxcpp** executable
	(`gamecpp.Main`) or another entry, **`Main.lua` is never run** — no `_hx_static_init`,
	no `_hxwerks_`, HxGen entity scripts (`Entities/HxGen/...`) will not call into Haxe.

	For cpp-only tests use plain Lua on entities (e.g. `Entities/AI/DemoRotate_standalone.lua`)
	or add a native bootstrap that runs the compiled `Main.lua` before the main loop.
**/
class Main {
	static function main():Void {
		/*
			Old procedural test scene was here (navmesh / agents / click-to-navigate).
			Temporarily disabled per request.
		*/

		// Keep at least one entity script reachable, so the editor-attachable Lua wrapper is generated.
		var _keep:Class<Dynamic> = example.DemoRotate;

		// Load project map (one level above Scripts/): HaxPro/Maps/HxMap.map
		var mapPath = "Maps/HxMap.map";

		var displays:Dynamic = Globals.GetDisplays();
		var window:Window = Globals.CreateWindow(
			"Leadwerks",
			0,
			0,
			Std.int(1280 * displays[1].scale),
			Std.int(720 * displays[1].scale),
			displays[1],
			Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR
		);

		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);
		var world:World = Globals.CreateWorld();

		var scene = Globals.LoadScene(world, mapPath);
		if (scene == null) {
			Globals.Print("Hxwerks: failed to load scene: " + mapPath);
		}

		// Always create a camera (map may or may not include one).
		var camera:Camera = Globals.CreateCamera(world);
		camera.SetFov(70);
		camera.SetClearColor(0.125);
		camera.SetRotation(new Vec3(35, 0, 0));
		camera.Move(0, 0, -10);

		while (!window.Closed() && !window.KeyDown(Globals.KEY_ESCAPE)) {
			world.Update();
			world.Render(framebuffer);
		}
	}
}


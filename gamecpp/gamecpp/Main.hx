package gamecpp;

import leadwerks.Camera;
import leadwerks.Framebuffer;
import leadwerks.Globals;
import leadwerks.Scene;
import leadwerks.Window;
import leadwerks.World;
import leadwerks.types.Vec3;

/**
	**hxcpp** entry — does **not** load or run Haxe’s compiled **`Main.lua`** (`haxe build.hxml`).

	Haxe→Lua entity glue (`Entities/HxGen/...`, `_hxwerks_`) is initialized only when that **`Main.lua`**
	is executed (Lua game entry). For cpp-only, use **`Entities/AI/DemoRotate_standalone.lua`**
	on an entity, or integrate running `Main.lua` from native code if you need HxGen scripts here.
**/
class Main
{
	static function main():Void
	{
		var mapPath = "Maps/HxMap.map";

		if (Globals.GetDisplaysCount() < 1)
		{
			Globals.Print("Hxwerks cpp: no displays");
			return;
		}

		var display = Globals.GetDisplayAt(0);
		var window:Window = Globals.CreateWindow(
			"Leadwerks",
			0,
			0,
			1280,
			720,
			display,
			Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR
		);
		Globals.ReleaseDisplay(display);

		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);
		var world:World = Globals.CreateWorld();

		var scene:Scene = Globals.LoadScene(world, mapPath);
		if (scene == null)
			Globals.Print("Hxwerks cpp: failed to load scene: " + mapPath);

		var camera:Camera = Globals.CreateCamera(world);
		camera.SetFov(70);
		camera.SetClearColor(0.125);
		camera.SetRotation(new Vec3(35, 0, 0));
		camera.Move(0, 0, -10);

		while (!window.Closed() && !window.KeyDown(Globals.KEY_ESCAPE))
		{
			world.Update();
			world.Render(framebuffer);
		}

		if (scene != null)
			Globals.ReleaseScene(scene);
		Globals.ReleaseCamera(camera);
		Globals.ReleaseWorld(world);
		Globals.ReleaseFramebuffer(framebuffer);
		Globals.ReleaseWindow(window);
	}
}

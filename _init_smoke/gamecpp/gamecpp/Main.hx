package gamecpp;

import leadwerks.Camera;
import leadwerks.Framebuffer;
import leadwerks.Globals;
import leadwerks.Scene;
import leadwerks.Window;
import leadwerks.World;
import leadwerks.types.Vec3;

/** Sample hxcpp entry; tune map path and resolution. **/
class Main
{
	static function main():Void
	{
		if (Globals.GetDisplaysCount() < 1)
		{
			Globals.Print("Hxwerks cpp: no displays");
			return;
		}
		var display = Globals.GetDisplayAt(0);
		var window:Window = Globals.CreateWindow(
			"Hxwerks", 0, 0, 1280, 720, display, Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR
		);
		Globals.ReleaseDisplay(display);
		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);
		var world:World = Globals.CreateWorld();
		var scene:Scene = Globals.LoadScene(world, "Maps/Your.map");
		if (scene == null)
			Globals.Print("Hxwerks cpp: scene not loaded");
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

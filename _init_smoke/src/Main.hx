import leadwerks.Camera;
import leadwerks.Framebuffer;
import leadwerks.Globals;
import leadwerks.Window;
import leadwerks.World;
import leadwerks.types.Vec3;

/**
	Compiled to Main.lua next to build.hxml (Leadwerks entry script).
	Adjust window title, resolution, or add `Globals.LoadScene(world, "Maps/Your.map")` as needed.
**/
class Main {
	static function main():Void {
		var displays:Dynamic = Globals.GetDisplays();
		var window:Window = Globals.CreateWindow(
			"Hxwerks",
			0,
			0,
			Std.int(1280 * displays[1].scale),
			Std.int(720 * displays[1].scale),
			displays[1],
			Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR
		);
		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);
		var world:World = Globals.CreateWorld();
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

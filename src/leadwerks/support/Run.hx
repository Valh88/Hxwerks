package leadwerks.support;

/**
	`haxelib run hxwerks init` — scaffold a Leadwerks + Haxe project (build.hxml + src/Main.hx).
**/
#if (interp || eval)
import haxe.io.Path;

class Run
{
	static function main()
	{
		var args = Sys.args();
		var cwd = if (Sys.getEnv("HAXELIB_RUN") != null) args.pop() else Sys.getCwd();
		if (args.length < 1)
		{
			Sys.println("Usage: haxelib run hxwerks init");
			Sys.exit(0);
		}

		switch args[0]
		{
			case "init":
				init(cwd);
			default:
				Sys.println('Unknown command: ${args[0]}');
				Sys.println("Usage: haxelib run hxwerks init");
				Sys.exit(1);
		}
	}

	static var hxml = [
		"# Hxwerks / Leadwerks 5 - run `haxe build.hxml` from this folder (same folder as build.hxml).",
		"# Main.lua is written next to build.hxml; entity wrappers go under Entities/HxGen relative to this folder.",
		"-cp src",
		"-lib hxwerks",
		"-main Main",
		"-lua Main.lua",
		"-D lua-vanilla",
		"-D hxwerks-projectroot=.",
		"-D hxwerks-entitiesdir=Entities/HxGen",
		"--macro leadwerks.support.ScriptMacro.use()",
		'--macro include("", true, null, ["src"])',
		"-dce full",
		"-D analyzer-optimize",
		"",
	].join("\n");

	static var mainHx = [
		"import leadwerks.Camera;",
		"import leadwerks.Framebuffer;",
		"import leadwerks.Globals;",
		"import leadwerks.Window;",
		"import leadwerks.World;",
		"import leadwerks.types.Vec3;",
		"",
		"/**",
		"	Compiled to Main.lua next to build.hxml (Leadwerks entry script).",
		"	Adjust window title, resolution, or add `Globals.LoadScene(world, \"Maps/Your.map\")` as needed.",
		"**/",
		"class Main {",
		"	static function main():Void {",
		"		var displays:Dynamic = Globals.GetDisplays();",
		"		var window:Window = Globals.CreateWindow(",
		"			\"Hxwerks\",",
		"			0,",
		"			0,",
		"			Std.int(1280 * displays[1].scale),",
		"			Std.int(720 * displays[1].scale),",
		"			displays[1],",
		"			Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR",
		"		);",
		"		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);",
		"		var world:World = Globals.CreateWorld();",
		"		var camera:Camera = Globals.CreateCamera(world);",
		"		camera.SetFov(70);",
		"		camera.SetClearColor(0.125);",
		"		camera.SetRotation(new Vec3(35, 0, 0));",
		"		camera.Move(0, 0, -10);",
		"		while (!window.Closed() && !window.KeyDown(Globals.KEY_ESCAPE)) {",
		"			world.Update();",
		"			world.Render(framebuffer);",
		"		}",
		"	}",
		"}",
		"",
	].join("\n");

	static function init(dir:String)
	{
		var hxmlPath = Path.join([dir, "build.hxml"]);
		sys.io.File.saveContent(hxmlPath, hxml);

		var srcPath = Path.join([dir, "src"]);
		sys.FileSystem.createDirectory(srcPath);

		var mainPath = Path.join([srcPath, "Main.hx"]);
		sys.io.File.saveContent(mainPath, mainHx);

		Sys.println('Created ${hxmlPath}');
		Sys.println('Created ${mainPath}');
		Sys.println("Next: open this folder in a terminal, run `haxe build.hxml`, then run the game with Leadwerks (Main.lua).");
	}
}
#end

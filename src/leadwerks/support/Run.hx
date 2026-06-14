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
		"import leadwerks.Event;",
		"import leadwerks.Globals;",
		"",
		"class Main {",
		"	static function main():Void {",
		"		var game = new Game();",
		"		var menu = new Menu(game);",
		"",
		"		var mapLoaded = false;",
		"		var menuHidden = false;",
		"		var exit = false;",
		"		while (!exit) {",
		"							while (Globals.PeekEvent()) {",
		"				var ev:Dynamic = Globals.WaitEvent();",
		"",
		"				if (ev.id == Globals.EVENT_QUIT) {",
		"					exit = true;",
		"					break;",
		"				} else if (ev.id == Globals.EVENT_WINDOWCLOSE && ev.source == game.window) {",
		"					exit = true;",
		"					break;",
		"",
		"				} else if (ev.id == Globals.EVENT_KEYDOWN && ev.data == Globals.KEY_ESCAPE) {",
		"					if (mapLoaded && menuHidden) {",
		"						game.world.Pause();",
		"						menu.SetHidden(false);",
		"						menuHidden = false;",
		"						game.window.SetCursor(Globals.CURSOR_DEFAULT);",
		"						game.window.FlushKeys();",
		"					}",
		"",
		"				} else if (ev.id == Globals.EVENT_WORLDPAUSE) {",
		"					game.window.SetCursor(Globals.CURSOR_DEFAULT);",
		"",
		"				} else if (ev.id == Globals.EVENT_WORLDRESUME) {",
		"					game.window.SetCursor(Globals.CURSOR_NONE);",
		"					game.window.FlushKeys();",
		"					game.window.FlushMouse();",
		"",
		"				} else if (ev.id == Globals.EVENT_STARTRENDERER) {",
		"					if (ev.data == 1) {",
		"						Globals.Print(ev.text);",
		"						game.window.SetHidden(false);",
		"						game.window.Activate();",
		"					} else {",
		"						Globals.Print(\"Error: Failed to initialize renderer\");",
		"						Globals.Print(ev.text);",
		"						return;",
		"					}",
		"",
		"				} else if (ev.id == Globals.EVENT_WIDGETACTION) {",
		"					if (ev.source == menu.newgamebutton) {",
		"						if (!mapLoaded) {",
		"							mapLoaded = game.LoadScene(\"Maps/HxMap.map\");",
		"						}",
		"						if (game.scene != null) {",
		"							menu.ApplyCameraSettings();",
		"							menu.SetHidden(true);",
		"							menuHidden = true;",
		"							menu.SetNewGameText(\"Resume Game\");",
		"							game.window.SetCursor(Globals.CURSOR_NONE);",
		"							game.window.FlushKeys();",
		"							game.window.FlushMouse();",
		"						}",
		"					} else if (ev.source == menu.quitbutton) {",
		"						exit = true;",
		"						break;",
		"					}",
		"				}",
		"			}",
		"",
		"			if (!exit) {",
		"				game.world.Update();",
		"				game.world.Render(game.framebuffer, true);",
		"			}",
		"		}",
		"",
		"		game.SaveSettings();",
		"	}",
		"}",
		"",
	].join("\n");

	static var gameHx = [
		"import leadwerks.Display;",
		"import leadwerks.Camera;",
		"import leadwerks.Framebuffer;",
		"import leadwerks.Font;",
		"import leadwerks.Globals;",
		"import leadwerks.Window;",
		"import leadwerks.World;",
		"",
		"class Game {",
		"	public var window:Window;",
		"	public var framebuffer:Framebuffer;",
		"	public var world:World;",
		"	public var scene:Dynamic;",
		"	public var font:Font;",
		"	public var gameCamera:Camera;",
		"	public var settings:Dynamic;",
		"",
		"	public function new() {",
		"		var displays:Dynamic = Globals.GetDisplays();",
		"		var display = displays[1];",
		"		window = Globals.CreateWindow(",
		"			\"Hxwerks\", 0, 0,",
		"			Std.int(display.size.x * display.scale),",
		"			Std.int(display.size.y * display.scale),",
		"			display,",
		"			Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR",
		"		);",
		"		framebuffer = Globals.CreateFramebuffer(window);",
		"		world = Globals.CreateWorld();",
		"		font = Globals.LoadFont(\"Fonts/arial.ttf\");",
		"		settings = { video: { vsync: true } };",
		"	}",
		"",
		"	public function LoadScene(path:String):Bool {",
		"		scene = Globals.LoadMap(world, path);",
		"		return scene != null;",
		"	}",
		"",
		"	public function SaveSettings():Void {}",
		"}",
		"",
	].join("\n");

	static var menuHx = [
		"import leadwerks.Globals;",
		"import leadwerks.Interface;",
		"import leadwerks.Widget;",
		"",
		"class Menu {",
		"	public var ui:Interface;",
		"	public var newgamebutton:Widget;",
		"	public var quitbutton:Widget;",
		"	var game:Game;",
		"",
		"	public function new(game:Game) {",
		"		this.game = game;",
		"		var size = game.framebuffer.GetSize();",
		"",
		"		ui = Globals.CreateInterface(game.world, game.font, size);",
		"		ui.background.SetColor(0, 0, 0, 0.5);",
		"",
		"		var cx = Std.int(ui.background.ClientSize().x / 2);",
		"		newgamebutton = Globals.CreateButton(\"New Game\", cx - 100, 200, 200, 40, ui.background);",
		"		quitbutton = Globals.CreateButton(\"Quit\", cx - 100, 260, 200, 40, ui.background);",
		"",
		"		var pass = function(ev:Dynamic, extra:Dynamic):Bool {",
		"			ui.ProcessEvent(ev);",
		"			return true;",
		"		};",
		"		Globals.ListenEvent(Globals.EVENT_MOUSEMOVE, null, pass, null);",
		"		Globals.ListenEvent(Globals.EVENT_MOUSEDOWN, null, pass, null);",
		"		Globals.ListenEvent(Globals.EVENT_MOUSEUP, null, pass, null);",
		"		Globals.ListenEvent(Globals.EVENT_MOUSEWHEEL, null, pass, null);",
		"		Globals.ListenEvent(Globals.EVENT_KEYDOWN, null, pass, null);",
		"		Globals.ListenEvent(Globals.EVENT_KEYUP, null, pass, null);",
		"	}",
		"",
		"	public function ApplyCameraSettings():Void {",
		"		var entities = game.world.GetEntities();",
		"		var count:Int = untyped __lua__(\"#{0}\", entities);",
		"		var found = false;",
		"		var i = 1;",
		"		while (i <= count) {",
		"			var entity = untyped entities[i];",
		"			if (entity != null) {",
		"				var cam = Globals.Camera(entity);",
		"				if (cam != null && cam.GetRenderTarget() == null && !cam.GetHidden() && cam.GetProjectionMode() == Globals.PROJECTION_PERSPECTIVE) {",
		"					game.gameCamera = cam;",
		"					found = true;",
		"					break;",
		"				}",
		"			}",
		"			i++;",
		"		}",
		"		if (!found) {",
		"			game.gameCamera = Globals.CreateCamera(game.world);",
		"			game.gameCamera.SetPosition(Globals.Vec3(0, 1, -5));",
		"		}",
		"	}",
		"",
		"	public function SetHidden(hidden:Bool):Void {",
		"		ui.background.SetHidden(hidden);",
		"	}",
		"",
		"	public function SetNewGameText(text:String):Void {",
		"		newgamebutton.SetText(text);",
		"	}",
		"}",
		"",
	].join("\n");

	static var mapJson = [
		"{",
		'	"scene": {',
		'		"entities": [',
		"			{",
		'				"castshadows": true,',
		'				"collisiontype": 0,',
		'				"color": [2.0, 1.899999976158142, 1.7000000476837158, 1.0],',
		'				"damping": [0.10000000149011612, 0.10000000149011612],',
		'				"decallayers": 1,',
		'				"directionallight": {',
		'					"cascadedistance": [4.0, 8.0, 16.0, 32.0],',
		'					"range": [-500.0, 500.0],',
		'					"shadowmapsize": 1024',
		"				},",
		'				"elasticity": 0.4000000059604645,',
		'				"friction": [0.5, 0.8999999761581421],',
		'				"gravity": true,',
		'				"matrix": [',
		'					"0x3f51b3f4", "0x32800000", "0xbf12d5e5", "0x0",',
		'					"0x3ef08fae", "0x3f12d5ea", "0x3f2bc74d", "0x0",',
		'					"0x3ea8715a", "0xbf51b3ef", "0x3ef08fb8", "0x0",',
		'					"0x0", "0x0", "0x0", "0x3f800000"',
		"				],",
		'				"navobstacle": false,',
		'				"physicsmode": 0,',
		'				"pickmode": 0,',
		'				"position": ["0x0", "0x0", "0x0"],',
		'				"quaternion": ["0xbee17926", "0xbe8890bd", "0x3e0e2ed1", "0x3f5890a5"],',
		'				"reflection": true,',
		'				"renderlayers": 1,',
		'				"rotation": ["0x425c0000", "0x420c0000", "0x0"],',
		'				"scale": ["0x3f800000", "0x3f800000", "0x3f800000"],',
		'				"sweptcollision": false,',
		'				"uuid": "c06c354d-6cf0-4b44-83e6-7516f2aa2232",',
		'				"viewrange": 0.0',
		"			}",
		"		],",
		'		"environment": {',
		'			"ambientlight": [0.0, 0.0, 0.0],',
		'			"diffusereflection": {',
		'				"path": "Materials/Environment/Default/diffuse.dds"',
		"			},",
		'			"fog": false,',
		'			"fogangle": [0.0, 15.0],',
		'			"fogcolor": [1.0, 1.0, 1.0, 1.0],',
		'			"fogrange": [0.0, 1000.0],',
		'			"gitransmission": 2.0,',
		'			"iblintensity": 0.5,',
		'			"specularreflection": {',
		'				"path": "Materials/Environment/Default/specular.dds"',
		"			},",
		'			"sunangle": [55.0, 35.0],',
		'			"suncolor": [2.0, 1.899999976158142, 1.0]',
		"		},",
		'		"extras": {',
		'			"viewports": [',
		"				{",
		'					"cameraposition": [0.0, 2.2943, -3.27661],',
		'					"camerarotation": [35.0, 0.0, 0.0],',
		'					"gridsize": 0,',
		'					"view": 0,',
		'					"zoom": 1.42815',
		"				}",
		"			]",
		"		},",
		'		"groups": [',
		'			{ "id": "1682436055472", "name": "Brushes" },',
		'			{ "id": "1682436063216", "name": "Entities" },',
		'			{ "id": "1682436059344", "name": "Models" }',
		"		]",
		"	}",
		"}",
	].join("\n");

	static function init(dir:String)
	{
		var hxmlPath = Path.join([dir, "build.hxml"]);
		sys.io.File.saveContent(hxmlPath, hxml);

		var srcPath = Path.join([dir, "src"]);
		sys.FileSystem.createDirectory(srcPath);

		var mainPath = Path.join([srcPath, "Main.hx"]);
		sys.io.File.saveContent(mainPath, mainHx);

		var gamePath = Path.join([srcPath, "Game.hx"]);
		sys.io.File.saveContent(gamePath, gameHx);

		var menuPath = Path.join([srcPath, "Menu.hx"]);
		sys.io.File.saveContent(menuPath, menuHx);

		var mapsPath = Path.join([dir, "Maps"]);
		sys.FileSystem.createDirectory(mapsPath);

		var mapPath = Path.join([mapsPath, "HxMap.map"]);
		sys.io.File.saveContent(mapPath, mapJson);

		Sys.println('Created ${hxmlPath}');
		Sys.println('Created ${mainPath}');
		Sys.println('Created ${gamePath}');
		Sys.println('Created ${menuPath}');
		Sys.println('Created ${mapPath}');
		Sys.println("Next: open this folder in a terminal, run `haxe build.hxml`, then run the game with Leadwerks (Main.lua).");
	}
}
#end

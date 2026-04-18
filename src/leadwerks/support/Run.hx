package leadwerks.support;

/**
	`haxelib run hxwerks init` — по умолчанию только **Lua**: `build.hxml`, `src/Main.hx` (тестовая сцена).

	`haxelib run hxwerks init cpp` (или `--cpp` / `-cpp`) — дополнительно **hxcpp**: `build-cpp*.hxml`, `gamecpp/`, `rebuild-hxcpp.ps1`,
	`main_stock.cpp`, MSBuild props для `.vcxproj`, документация.

	`--root|-r <dir>` — каталог игры для макроса **HXWERKS_GAME_ROOT** в props (по умолчанию `Source` → `$(ProjectDir)Source`; `--root .` — всё в `$(ProjectDir)`).
**/
#if (interp || eval)
import haxe.io.Path;
import StringTools;
import sys.io.Process;

class Run
{
	static function main()
	{
		var args = Sys.args();
		var cwd = Sys.getCwd();
		if (Sys.getEnv("HAXELIB_RUN") != null && args.length > 0)
		{
			var last = args[args.length - 1];
			if (sys.FileSystem.exists(last) && sys.FileSystem.isDirectory(last))
				cwd = args.pop();
		}

		if (args.length < 1)
		{
			printUsage();
			Sys.exit(0);
		}

		switch args[0]
		{
			case "init":
				var o = parseInitOpts(args);
				init(cwd, o.cpp, o.gameRootMsbuild);
			default:
				Sys.println('Unknown command: ${args[0]}');
				printUsage();
				Sys.exit(1);
		}
	}

	static function printUsage():Void
	{
		Sys.println("Usage:");
		Sys.println("  haxelib run hxwerks init [cpp] [--root|-r <dir>]");
		Sys.println("    — Lua: build.hxml, src/Main.hx (тестовая сцена Maps/HxMap.map)");
		Sys.println("    — cpp: + build-cpp*.hxml, gamecpp/, HxCppOut рядом с hxml, VS props, main_stock.cpp");
		Sys.println("    — --root: папка игры относительно .vcxproj (макрос HXWERKS_GAME_ROOT в props):");
		Sys.println("        по умолчанию Source  → $(ProjectDir)Source");
		Sys.println("        --root .            → $(ProjectDir) (всё в корне рядом с .vcxproj)");
		Sys.println("        --root MySub          → $(ProjectDir)MySub");
	}

	/** Путь к каталогу с main_stock.cpp / HxCppOut / Game/ для MSBuild (значение по умолчанию HXWERKS_GAME_ROOT). */
	static function msbuildGameRootFromToken(token:String):String
	{
		var m = String.fromCharCode(36);
		var t = StringTools.trim(token);
		if (t == "" || t == ".")
			return m + "(ProjectDir)";
		t = StringTools.replace(t, "/", "\\");
		while (StringTools.startsWith(t, "\\"))
			t = t.substr(1);
		return m + "(ProjectDir)" + t;
	}

	static function parseInitOpts(args:Array<String>):{cpp:Bool, gameRootMsbuild:String}
	{
		var cpp = false;
		var gameRoot = msbuildGameRootFromToken("Source");
		var i = 1;
		while (i < args.length)
		{
			var a = args[i];
			if (a == "cpp" || a == "--cpp" || a == "-cpp")
			{
				cpp = true;
				i++;
				continue;
			}
			if (a == "--root" || a == "-r")
			{
				i++;
				if (i >= args.length)
				{
					Sys.println("Ожидалось значение после --root / -r (например . или Source)");
					Sys.exit(1);
				}
				gameRoot = msbuildGameRootFromToken(args[i]);
				i++;
				continue;
			}
			i++;
		}
		return {cpp: cpp, gameRootMsbuild: gameRoot};
	}

	static function haxelibLibPath(lib:String):String
	{
		try
		{
			var p = new Process("haxelib", ["libpath", lib]);
			var code = p.exitCode();
			var out = StringTools.trim(p.stdout.readAll().toString());
			p.close();
			if (code != 0 || out == "")
				return "";
			return StringTools.replace(out, "/", "\\");
		}
		catch (_:Dynamic)
			return "";
	}

	static function xmlAttrEscape(s:String):String
	{
		return StringTools.replace(StringTools.replace(StringTools.replace(s, "&", "&amp;"), "<", "&lt;"), "\"", "&quot;");
	}

	static var hxml = [
		"# Hxwerks / Leadwerks 5 — `haxe build.hxml` из этой папки.",
		"# Main.lua рядом с build.hxml; entity-скрипты: Entities/HxGen относительно этой папки.",
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
		"	Main.lua — точка входа Leadwerks. Тестовая сцена: `Maps/HxMap.map` (положите карту или поменяйте путь).",
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
		"		var scene = Globals.LoadScene(world, \"Maps/HxMap.map\");",
		"		if (scene == null) Globals.Print(\"Hxwerks: не удалось загрузить сцену Maps/HxMap.map\");",
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

	static var buildCppHxml = [
		"# hxcpp — перед сборкой в VS: `haxe build-cpp.hxml` (Release /MD → libMain.lib).",
		"-lib hxwerks",
		"-cp src",
		"-cp gamecpp",
		'--macro include("", true, null, ["src"])',
		'--macro include("", true, null, ["gamecpp"])',
		"-main gamecpp.Main",
		"-cpp HxCppOut",
		"-dce full",
		"-D analyzer-optimize",
		"-D hxwerks_cpp",
		"-D hxwerks_embed",
		"-D static_link",
		"-D HXCPP_M64",
		"-D ABI=-MD",
		"",
	].join("\n");

	static var buildCppDebugHxml = [
		"# Debug /MDd → libMain_d.lib",
		"-lib hxwerks",
		"-cp src",
		"-cp gamecpp",
		'--macro include("", true, null, ["src"])',
		'--macro include("", true, null, ["gamecpp"])',
		"-main gamecpp.Main",
		"-cpp HxCppOut",
		"-dce full",
		"-D analyzer-optimize",
		"-D hxwerks_cpp",
		"-D hxwerks_embed",
		"-D static_link",
		"-D HXCPP_M64",
		"-debug",
		"-D HAXE_OUTPUT_FILE=libMain_d",
		"-D ABI=-MDd",
		"",
	].join("\n");

	static var buildCppStandaloneHxml = [
		"# Отдельный Main.exe + stub (не для линковки в игру).",
		"-lib hxwerks",
		"-cp src",
		"-cp gamecpp",
		'--macro include("", true, null, ["src"])',
		'--macro include("", true, null, ["gamecpp"])',
		"-main gamecpp.Main",
		"-cpp HxCppOutStandalone",
		"-dce full",
		"-D analyzer-optimize",
		"-D hxwerks_cpp",
		"-D HXCPP_M64",
		"-D ABI=-MD",
		"",
	].join("\n");

	static var gamecppMainHx = [
		"package gamecpp;",
		"",
		"import leadwerks.Camera;",
		"import leadwerks.Framebuffer;",
		"import leadwerks.Globals;",
		"import leadwerks.Scene;",
		"import leadwerks.Window;",
		"import leadwerks.World;",
		"import leadwerks.types.Vec3;",
		"",
		"/** hxcpp: тестовая сцена `Maps/HxMap.map` (мост HxwerksCppBridge). **/",
		"class Main",
		"{",
		"	static function main():Void",
		"	{",
		"		var mapPath = \"Maps/HxMap.map\";",
		"		if (Globals.GetDisplaysCount() < 1)",
		"		{",
		"			Globals.Print(\"Hxwerks cpp: no displays\");",
		"			return;",
		"		}",
		"		var display = Globals.GetDisplayAt(0);",
		"		var window:Window = Globals.CreateWindow(",
		"			\"Leadwerks\", 0, 0, 1280, 720, display, Globals.WINDOW_CENTER + Globals.WINDOW_TITLEBAR",
		"		);",
		"		Globals.ReleaseDisplay(display);",
		"		var framebuffer:Framebuffer = Globals.CreateFramebuffer(window);",
		"		var world:World = Globals.CreateWorld();",
		"		var scene:Scene = Globals.LoadScene(world, mapPath);",
		"		if (scene == null)",
		"			Globals.Print(\"Hxwerks cpp: failed to load scene: \" + mapPath);",
		"		var camera:Camera = Globals.CreateCamera(world);",
		"		camera.SetFov(70);",
		"		camera.SetClearColor(0.125);",
		"		camera.SetRotation(new Vec3(35, 0, 0));",
		"		camera.Move(0, 0, -10);",
		"		while (!window.Closed() && !window.KeyDown(Globals.KEY_ESCAPE))",
		"		{",
		"			world.Update();",
		"			world.Render(framebuffer);",
		"		}",
		"		if (scene != null)",
		"			Globals.ReleaseScene(scene);",
		"		Globals.ReleaseCamera(camera);",
		"		Globals.ReleaseWorld(world);",
		"		Globals.ReleaseFramebuffer(framebuffer);",
		"		Globals.ReleaseWindow(window);",
		"	}",
		"}",
		"",
	].join("\n");

	static var rebuildPs1 = [
		"# Rebuild hxcpp static libs with a clean object cache (avoids mixed CRT in libMain*.lib).",
		"# Usage: .\\rebuild-hxcpp.ps1 [-Configuration Debug|Release|Both]",
		"param(",
		"    [ValidateSet('Debug', 'Release', 'Both')]",
		"    [string] $$Configuration = 'Both'",
		")",
		"$$ErrorActionPreference = 'Stop'",
		"$$here = $$PSScriptRoot",
		"$$hxCppOut = Join-Path $$here 'HxCppOut'",
		"$$obj = Join-Path $$hxCppOut 'obj'",
		"if (Test-Path $$obj) {",
		"    Remove-Item -Recurse -Force $$obj",
		"    Write-Host \"Removed $$obj\"",
		"}",
		"Push-Location $$here",
		"try {",
		"    if ($$Configuration -eq 'Debug' -or $$Configuration -eq 'Both') {",
		"        haxe build-cpp-debug.hxml",
		"    }",
		"    if ($$Configuration -eq 'Release' -or $$Configuration -eq 'Both') {",
		"        haxe build-cpp.hxml",
		"    }",
		"}",
		"finally {",
		"    Pop-Location",
		"}",
		"",
	].join("\n");

	static var mainStockCpp = [
		"// Stock Leadwerks C++ entry when `HXWERKS_HAXE_MAIN` is not defined.",
		'#include "Leadwerks.h"',
		'#include "Encryption.h"',
		'#include "Game/Game.h"',
		'#include "Hxwerks/cinclude/HxwerksLeadwerksTemplate.h"',
		"//#include \"Steamworks/Steamworks.h\"",
		"",
		"using namespace Leadwerks;",
		"",
		"int Main_StockLeadwerks(int argc, const char **argv)",
		"{",
		"#ifdef STEAM_API_H",
		"\tif (not Steamworks::Initialize())",
		"\t{",
		"\t\tRuntimeError(\"Steamworks failed to initialize.\");",
		"\t\treturn 1;",
		"\t}",
		"#endif",
		"",
		"\tGame::commandline = ParseCommandLine(argc, argv);",
		"",
		"\tif (hxwerks_leadwerks_template_init() != 0)",
		"\t{",
		"#ifdef STEAM_API_H",
		"\t\tSteamworks::Shutdown();",
		"#endif",
		"\t\treturn 1;",
		"\t}",
		"",
		"\twhile (hxwerks_leadwerks_template_frame() == 0) {}",
		"",
		"\tGame::SaveSettings();",
		"",
		"#ifdef STEAM_API_H",
		"\tSteamworks::Shutdown();",
		"#endif",
		"\treturn 0;",
		"}",
		"",
	].join("\n");

	static function visualStudioProps(hxwerksLib:String, cpp:Bool, gameRootMsbuild:String):String
	{
		var m = String.fromCharCode(36);
		var libCond = hxwerksLib != "" ? " Condition=\"'" + m + "(HXWERKS_LIB)' == ''\"" : "";

		if (!cpp)
		{
			return '<?xml version="1.0" encoding="utf-8"?>\n'
				+ "<!-- Generated by `haxelib run hxwerks init` (Lua only). For hxcpp + VS run `haxelib run hxwerks init cpp`. -->\n"
				+ '<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">\n'
				+ "  <!-- No C++ bridge entries in Lua-only mode. -->\n"
				+ "</Project>\n";
		}

		var libXml = hxwerksLib != ""
			? '    <HXWERKS_LIB>' + xmlAttrEscape(hxwerksLib) + '</HXWERKS_LIB>\n'
			: '    <!-- `haxelib libpath hxwerks` → вставьте сюда путь к папке с native/ и cinclude/ -->\n'
				+ "    <HXWERKS_LIB></HXWERKS_LIB>\n";

		var gameRootXml = '    <HXWERKS_GAME_ROOT Condition="\''
			+ m
			+ "(HXWERKS_GAME_ROOT)' == ''\">"
			+ gameRootMsbuild
			+ "</HXWERKS_GAME_ROOT>\n";

		return '<?xml version="1.0" encoding="utf-8"?>\n'
			+ '<!-- Generated by `haxelib run hxwerks init cpp`. Import из .vcxproj перед </Project>. См. HXWERKS_VS_INTEGRATION.md -->\n'
			+ '<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">\n'
			+ '  <PropertyGroup Label="UserMacros"' + libCond + ">\n"
			+ libXml
			+ "  </PropertyGroup>\n"
			+ '  <PropertyGroup Label="HxwerksPaths">\n'
			+ gameRootXml
			+ "  </PropertyGroup>\n"
			+ "  <ItemGroup>\n"
			+ '    <ClCompile Include="' + m + "(HXWERKS_LIB)\\native\\HxwerksCppBridge.cpp\" />\n"
			+ '    <ClCompile Include="' + m + "(HXWERKS_LIB)\\native\\HxwerksHaxeEntry.cpp\">\n"
			+ '      <PrecompiledHeader Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Debug|x64\\'\">NotUsing</PrecompiledHeader>\n"
			+ '      <PrecompiledHeader Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Release|x64\\'\">NotUsing</PrecompiledHeader>\n"
			+ "      <AdditionalIncludeDirectories>"
			+ m
			+ "(HXCPP)\\include;"
			+ m
			+ "(HXWERKS_GAME_ROOT)\\HxCppOut\\include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>\n"
			+ "    </ClCompile>\n"
			+ '    <ClCompile Include="' + m + "(HXWERKS_LIB)\\native\\HxwerksLeadwerksTemplate.cpp\">\n"
			+ '      <PrecompiledHeader Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Debug|x64\\'\">NotUsing</PrecompiledHeader>\n"
			+ '      <PrecompiledHeader Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Release|x64\\'\">NotUsing</PrecompiledHeader>\n"
			+ "    </ClCompile>\n"
			+ '    <ClCompile Include="' + m + '(HXWERKS_GAME_ROOT)\\main_stock.cpp" />\n'
			+ "  </ItemGroup>\n"
			+ '  <ItemDefinitionGroup Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Debug|x64\\'\">\n"
			+ "    <ClCompile>\n"
			+ "      <PreprocessorDefinitions>HXWERKS_HAXE_MAIN;%(PreprocessorDefinitions)</PreprocessorDefinitions>\n"
			+ "      <AdditionalIncludeDirectories>"
			+ m
			+ "(HXWERKS_GAME_ROOT);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>\n"
			+ "    </ClCompile>\n"
			+ "    <Link>\n"
			+ "      <AdditionalDependencies>"
			+ m
			+ "(HXWERKS_GAME_ROOT)\\HxCppOut\\libMain_d.lib;%(AdditionalDependencies)</AdditionalDependencies>\n"
			+ "    </Link>\n"
			+ "  </ItemDefinitionGroup>\n"
			+ '  <ItemDefinitionGroup Condition="\''
			+ m
			+ "(Configuration)|"
			+ m
			+ "(Platform)\\'==\\'Release|x64\\'\">\n"
			+ "    <ClCompile>\n"
			+ "      <PreprocessorDefinitions>HXWERKS_HAXE_MAIN;%(PreprocessorDefinitions)</PreprocessorDefinitions>\n"
			+ "      <AdditionalIncludeDirectories>"
			+ m
			+ "(HXWERKS_GAME_ROOT);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>\n"
			+ "    </ClCompile>\n"
			+ "    <Link>\n"
			+ "      <AdditionalDependencies>"
			+ m
			+ "(HXWERKS_GAME_ROOT)\\HxCppOut\\libMain.lib;%(AdditionalDependencies)</AdditionalDependencies>\n"
			+ "    </Link>\n"
			+ "  </ItemDefinitionGroup>\n"
			+ "</Project>\n";
	}

	static function vsIntegrationMd(cpp:Bool, gameRootMsbuild:String):String
	{
		var lines = [
			"# Hxwerks + Visual Studio",
			"",
			"Файлы созданы `haxelib run hxwerks init`" + (cpp ? " **cpp**" : " (только Lua)") + ".",
			"",
		];
		if (!cpp)
		{
			lines = lines.concat([
				"- `build.hxml`, `src/Main.hx` — компиляция в `Main.lua`.",
				"",
				"Для **hxcpp** и интеграции с `.vcxproj` выполните в этой же папке:",
				"",
				"```bash",
				"haxelib run hxwerks init cpp",
				"# или всё относительно корня решения: `haxelib run hxwerks init cpp --root .`",
				"```",
				"",
			]);
			return lines.join("\n");
		}
		return lines.concat([
			"- `build.hxml` / `src/Main.hx` — Lua.",
			"- `build-cpp.hxml`, `build-cpp-debug.hxml`, `build-cpp-standalone.hxml` — hxcpp; каталоги `HxCppOut` / `HxCppOutStandalone` создаются **рядом с этими hxml**.",
			"- `gamecpp/gamecpp/Main.hx` — точка входа C++.",
			"- `main_stock.cpp` — запасной C++-цикл без Haxe.",
			"- `Hxwerks.VisualStudio.props` — подключите к `.vcxproj`:",
			"",
			"```xml",
			"  <Import Project=\"Hxwerks.VisualStudio.props\" Condition=\"Exists('Hxwerks.VisualStudio.props')\" />",
			"```",
			"",
			"**HXWERKS_GAME_ROOT** (в props) по умолчанию: `" + gameRootMsbuild + "` — папка с `main_stock.cpp`, `HxCppOut/`, `Game/`.",
			"Если hxml лежат не там, где ожидает `.vcxproj`, задайте `HXWERKS_GAME_ROOT` вручную в проекте или пересоздайте props с `haxelib run hxwerks init cpp --root .` (или `--root Source`).",
			"",
			"В `PropertySheet.props` (или макросах проекта) задайте **HXCPP** — путь к haxelib **hxcpp** (папка с `include/`).",
			"Перед сборкой в VS: `haxe build-cpp-debug.hxml` (Debug) и/или `haxe build-cpp.hxml` (Release) — см. `rebuild-hxcpp.ps1`.",
			"Линковка: Debug → `libMain_d.lib`, Release → `libMain.lib` в `<HXWERKS_GAME_ROOT>/HxCppOut/`.",
			"",
		]).join("\n");
	}

	static function init(dir:String, cpp:Bool, gameRootMsbuild:String)
	{
		if (sys.FileSystem.exists(Path.join([dir, "src", "leadwerks", "support", "Run.hx"])))
			Sys.println("Предупреждение: похоже, текущая папка — исходники пакета **hxwerks**. Запускайте `haxelib run hxwerks init` из **каталога игры** (например `…/Source/`), где должен лежать будущий `build.hxml`.");

		var hxmlPath = Path.join([dir, "build.hxml"]);
		sys.io.File.saveContent(hxmlPath, hxml);

		var srcPath = Path.join([dir, "src"]);
		sys.FileSystem.createDirectory(srcPath);

		var mainPath = Path.join([srcPath, "Main.hx"]);
		sys.io.File.saveContent(mainPath, mainHx);

		var libPath = haxelibLibPath("hxwerks");

		var propsPath = Path.join([dir, "Hxwerks.VisualStudio.props"]);
		sys.io.File.saveContent(propsPath, visualStudioProps(libPath, cpp, gameRootMsbuild));

		var mdPath = Path.join([dir, "HXWERKS_VS_INTEGRATION.md"]);
		sys.io.File.saveContent(mdPath, vsIntegrationMd(cpp, gameRootMsbuild));

		Sys.println('Created ${hxmlPath}');
		Sys.println('Created ${mainPath}');
		Sys.println('Created ${propsPath}');
		Sys.println('Created ${mdPath}');

		if (cpp)
		{
			sys.io.File.saveContent(Path.join([dir, "build-cpp.hxml"]), buildCppHxml);
			sys.io.File.saveContent(Path.join([dir, "build-cpp-debug.hxml"]), buildCppDebugHxml);
			sys.io.File.saveContent(Path.join([dir, "build-cpp-standalone.hxml"]), buildCppStandaloneHxml);

			var gamecppPkg = Path.join([dir, "gamecpp", "gamecpp"]);
			sys.FileSystem.createDirectory(gamecppPkg);
			sys.io.File.saveContent(Path.join([gamecppPkg, "Main.hx"]), gamecppMainHx);

			sys.io.File.saveContent(Path.join([dir, "rebuild-hxcpp.ps1"]), rebuildPs1);
			sys.io.File.saveContent(Path.join([dir, "main_stock.cpp"]), mainStockCpp);

			Sys.println('Created ${Path.join([dir, "build-cpp.hxml"])}');
			Sys.println('Created ${Path.join([dir, "build-cpp-debug.hxml"])}');
			Sys.println('Created ${Path.join([dir, "build-cpp-standalone.hxml"])}');
			Sys.println('Created ${Path.join([gamecppPkg, "Main.hx"])}');
			Sys.println('Created ${Path.join([dir, "rebuild-hxcpp.ps1"])}');
			Sys.println('Created ${Path.join([dir, "main_stock.cpp"])}');
		}

		if (libPath != "")
			Sys.println('hxwerks libpath: ${libPath}');
		else
			Sys.println("Подсказка: выполните `haxelib libpath hxwerks` и пропишите HXWERKS_LIB в props при необходимости.");

		Sys.println("HXWERKS_GAME_ROOT (по умолчанию в props): " + gameRootMsbuild);
		Sys.println(cpp ? "Далее: `haxe build.hxml` (Lua); `haxe build-cpp.hxml` + импорт props в VS (см. md)." : "Далее: `haxe build.hxml`. Для cpp: `haxelib run hxwerks init cpp`.");
	}
}
#end

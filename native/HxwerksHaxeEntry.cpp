/**
 * Process entry + hxcpp shim: `main` → Haxe (`__hxcpp_lib_main`) or stock C++ (`Main_StockLeadwerks`).
 */
#include "Leadwerks.h"
#include "Game/Game.h"
#include "Hxwerks/native/HxwerksHaxeEntry.h"

//#include "Steamworks/Steamworks.h"

extern "C" void __hxcpp_lib_main();

void Hxwerks_RunGameCppMain(int argc, const char **argv)
{
#ifdef STEAM_API_H
	if (not Steamworks::Initialize())
	{
		RuntimeError("Steamworks failed to initialize.");
		return;
	}
#endif

	Game::commandline = ParseCommandLine(argc, argv);

	__hxcpp_lib_main();

	Game::SaveSettings();

#ifdef STEAM_API_H
	Steamworks::Shutdown();
#endif
}

#if !defined(HXWERKS_HAXE_MAIN)
extern int Main_StockLeadwerks(int argc, const char **argv);
#endif

int main(int argc, const char *argv[])
{
#if defined(HXWERKS_HAXE_MAIN)
	Hxwerks_RunGameCppMain(argc, argv);
	return 0;
#else
	return Main_StockLeadwerks(argc, argv);
#endif
}

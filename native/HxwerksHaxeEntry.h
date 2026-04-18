#pragma once

/**
 * Runs Haxe cpp entry (`gamecpp.Main`) via hxcpp (`__hxcpp_lib_main`).
 * Fills `Game::commandline` from `argv` before Haxe runs.
 * `main()` lives in the same .cpp as this function.
 */
void Hxwerks_RunGameCppMain(int argc, const char **argv);

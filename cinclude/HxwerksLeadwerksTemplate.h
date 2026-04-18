#pragma once

/**
 * Stock Leadwerks template bootstrap + one frame (main menu, packages, event pump).
 * Used from Haxe (`gamecpp.Main`) and from `main_stock.cpp` when `HXWERKS_HAXE_MAIN` is off.
 *
 * Returns: 0 = success / continue, non-zero = failure (init) or request to stop (frame).
 */
#ifdef __cplusplus
extern "C" {
#endif

int hxwerks_leadwerks_template_init(void);
int hxwerks_leadwerks_template_frame(void);

#ifdef __cplusplus
}
#endif

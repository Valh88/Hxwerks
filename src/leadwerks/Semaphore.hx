package leadwerks;

// NOTE: Semaphore is available in Ultra Engine but NOT in Leadwerks 5 Lua.
// Keep this file for Ultra Engine compatibility; do not use in Leadwerks 5.

@:native("_G")
extern class Semaphore
{
	function Signal():Void;
	function Wait():Void;
}

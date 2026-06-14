package leadwerks;

// NOTE: Thread is available in Ultra Engine but NOT in Leadwerks 5 Lua.
// Keep this file for Ultra Engine compatibility; do not use in Leadwerks 5.
@:native("_G")
extern class Thread extends Object
{
	function GetResult():Dynamic;
	function GetState():Int;
	function Start():Void;
	function Wait():Void;
}

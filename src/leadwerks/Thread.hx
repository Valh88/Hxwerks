package leadwerks;

@:native("_G")
extern class Thread
{
	function GetResult():Dynamic;
	function GetState():Int;
	function Start():Void;
	function Wait():Void;
}

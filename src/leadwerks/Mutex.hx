package leadwerks;

@:native("_G")
extern class Mutex
{
	function Lock():Void;
	function Unlock():Void;
}

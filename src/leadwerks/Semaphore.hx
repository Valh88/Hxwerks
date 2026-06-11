package leadwerks;

@:native("_G")
extern class Semaphore
{
	function Signal():Void;
	function Wait():Void;
}

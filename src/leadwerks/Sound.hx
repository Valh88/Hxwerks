package leadwerks;

@:native("_G")
extern class Sound extends Asset
{
	function GetLength():Float;
	function Play(?volume:Float):Void;
}

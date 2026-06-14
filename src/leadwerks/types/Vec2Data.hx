package leadwerks.types;

@:native("_G")
extern class Vec2Data
{
	var x:Float;
	var y:Float;

	function Length():Float;
	function Normalize():Vec2Data;
}

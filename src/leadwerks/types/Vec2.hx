package leadwerks.types;

@:native("_G")
extern class Vec2
{
	var x:Float;
	var y:Float;

	function Length():Float;
	function Normalize():Vec2;
}

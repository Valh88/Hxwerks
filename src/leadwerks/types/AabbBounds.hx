package leadwerks.types;

@:native("_G")
extern class AabbBounds
{
	var min:Vec3;
	var max:Vec3;
	var center:Vec3;
	var size:Vec3;
	var radius:Float;

	function Update():Void;
}

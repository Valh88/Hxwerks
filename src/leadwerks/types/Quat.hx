package leadwerks.types;

@:native("_G")
extern class Quat
{
	var x:Float;
	var y:Float;
	var z:Float;
	var w:Float;

	function Inverse():Quat;
	function Normalize():Quat;
	function Slerp(dest:Quat, t:Float):Quat;
	function ToEuler():Vec3;
}

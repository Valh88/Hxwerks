package leadwerks.types;

@:native("_G")
extern class Vec3
{
	var x:Float;
	var y:Float;
	var z:Float;

	function Length():Float;
	function Normalize():Vec3;
	function Distance(v:Vec3):Float;
	function Cross(v:Vec3):Vec3;
	function Dot(v:Vec3):Float;
	function Inverse():Vec3;
}

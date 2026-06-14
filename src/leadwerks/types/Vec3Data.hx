package leadwerks.types;

@:native("_G")
extern class Vec3Data
{
	var x:Float;
	var y:Float;
	var z:Float;

	function Length():Float;
	function Normalize():Vec3Data;
	function Distance(v:Vec3Data):Float;
	function Cross(v:Vec3Data):Vec3Data;
	function Dot(v:Vec3Data):Float;
	function Inverse():Vec3Data;
}

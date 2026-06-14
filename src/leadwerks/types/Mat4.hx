package leadwerks.types;

@:native("_G")
extern class Mat4
{
	function Inverse():Mat4;
	function Determinant():Float;
	function Transpose():Mat4;
	function Normalize():Mat4;
	function GetTranslation():Vec3;
	function GetRotation():Vec3;
	function GetScale():Vec3;
	function GetQuaternion():Quat;
}

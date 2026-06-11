package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class Bone
{
	var id:Int;
	var name:String;

	function GetPosition():Vec3;
	function SetPosition(pos:Vec3):Void;
	function GetRotation():Vec3;
	function SetRotation(rot:Vec3):Void;
	function GetScale():Vec3;
	function SetScale(scale:Vec3):Void;
	function Turn(pitch:Float, yaw:Float, roll:Float):Void;
}

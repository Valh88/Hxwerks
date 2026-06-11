package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class VrDevice
{
	var model:Model;

	function Connected():Bool;
	function GetMatrix():Dynamic;
	function GetPosition():Vec3;
	function GetQuaternion():Dynamic;
	function GetRotation():Vec3;
}

package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class NavMesh
{
	function Build():Void;
	function RandomPoint():Vec3;
	function SetDebugging(enabled:Bool):Void;
}

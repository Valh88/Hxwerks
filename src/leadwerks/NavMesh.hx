package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class NavMesh
{
	function Build(?maxEdgeLength:Float):Void;
	function PlotPath(start:Vec3, dest:Vec3):Array<Vec3>;
	function RandomPoint():Vec3;
	function SetDebugging(enabled:Bool):Void;
	function SetPosition(pos:Vec3):Void;
	function SetRotation(rot:Vec3):Void;
}

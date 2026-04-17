package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class Entity
{
	function SetNavObstacle(enabled:Bool):Void;
	function SetColor(r:Float, ?g:Float, ?b:Float):Void;
	function Attach(child:Dynamic):Void;
	function SetPosition(pos:Vec3):Void;
	function Move(x:Float, y:Float, z:Float):Void;
	function GetPosition(?global:Bool):Vec3;
}

package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class NavAgent
{
	@:overload(function(x:Float, y:Float, z:Float, ?maxsteps:Int, ?maxdistance:Float):Bool {})
	function Navigate(dest:Vec3, ?maxsteps:Int, ?maxdistance:Float):Bool;
	function SetMaxAcceleration(accel:Float):Void;
	function SetMaxSpeed(speed:Float):Void;
	function SetPosition(pos:Vec3):Void;
	function GetPosition(?global:Bool):Vec3;
	function SetRotation(rot:Vec3):Void;
	function Stop():Void;
}

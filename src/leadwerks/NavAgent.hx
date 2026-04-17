package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class NavAgent
{
	function SetPosition(pos:Vec3):Void;
	function GetPosition(?global:Bool):Vec3;
	function Navigate(dest:Vec3):Bool;
}

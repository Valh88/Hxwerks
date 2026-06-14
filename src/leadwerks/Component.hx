package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class Component
{
	var entity(default, null):Entity;

	function Start():Void;
	function Update():Void;
	function Collide(collidedentity:Entity, position:Vec3, normal:Vec3, speed:Float):Void;
	function Load(properties:Dynamic, binstream:Stream, scene:Scene, flags:Int, extra:Dynamic):Bool;
}

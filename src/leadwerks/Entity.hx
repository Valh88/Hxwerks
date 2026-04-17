package leadwerks;

import leadwerks.types.Vec3;

/**
	Leadwerks entity / component base. Most in-world objects use these methods.
**/
@:native("_G")
extern class Entity
{
	function SetNavObstacle(enabled:Bool):Void;
	function SetColor(r:Float, ?g:Float, ?b:Float):Void;
	function Attach(child:Dynamic):Void;
	function SetPosition(pos:Vec3):Void;
	function Move(x:Float, y:Float, z:Float):Void;
	function GetPosition(?globalSpace:Bool):Vec3;
	function Translate(x:Float, y:Float, z:Float):Void;
	function GetRotation(?globalSpace:Bool):Vec3;
	function SetRotation(rot:Vec3, ?globalSpace:Bool):Void;

	function SetPhysicsMode(mode:Int):Void;
	function SetMass(mass:Float):Void;
	function GetMass():Float;
	function SetCollisionType(t:Int):Void;
	function GetCollisionType():Int;
	function SetShadows(enabled:Bool):Void;
	function SetRenderLayers(layers:Int):Void;

	function SetParent(parent:Dynamic):Void;
	function SetCollider(collider:Dynamic):Void;
	function SetVelocity(vel:Vec3):Void;
	function GetVelocity():Vec3;
	function AddTorque(x:Float, y:Float, z:Float):Void;

	function GetQuaternion(?globalSpace:Bool):Dynamic;

	function SetHidden(hidden:Bool):Void;
	function GetHidden():Bool;

	function ListenEvent(eventId:Int, source:Dynamic, ?context:Dynamic):Void;

	/** Child entity by name (see Leadwerks hierarchy docs). **/
	function FindChild(name:String, recursive:Bool):Dynamic;

	function GetDistance(other:Entity):Float;

	function SetPickMode(mode:Int):Void;
	function GetPickMode():Int;

	function Disable():Void;
}

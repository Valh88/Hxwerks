package leadwerks;

import leadwerks.types.Vec3;
import leadwerks.types.Vec4;
import leadwerks.types.PickInfo;

/**
	Leadwerks entity / component base. Most in-world objects use these methods.
**/
@:native("_G")
extern class Entity
{
	// --- Properties (Lua fields) ---
	var camera:Camera;
	var extra:Dynamic;
	var kids:Array<Entity>;
	var matrix:Dynamic;
	var name:String;
	var navmesh:NavMesh;
	var omega:Vec3;
	var parent:Entity;
	var position:Vec3;
	var properties:Dynamic;
	var scene:Scene;
	var quaternion:Dynamic;
	var rotation:Vec3;
	var scale:Vec3;
	var speakers:Array<Speaker>;
	var tags:Array<String>;
	var velocity:Vec3;

	// --- Components ---
	function AddComponent(tableOrPath:Dynamic, ?start:Bool):Dynamic;
	function GetComponent(nameOrTable:Dynamic):Dynamic;
	function GetComponentData(tableOrPath:Dynamic):Dynamic;

	// --- Forces & Physics ---
	@:overload(function(x:Float, y:Float, z:Float, ?global:Bool):Void
	{
	})
	@:overload(function(force:Vec3, ?global:Bool):Void
	{
	})
	function AddForce(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic):Void;

	@:overload(function(fx:Float, fy:Float, fz:Float, x:Float, y:Float, z:Float, ?global:Bool):Void
	{
	})
	@:overload(function(force:Vec3, position:Vec3, ?global:Bool):Void
	{
	})
	function AddPointForce(a:Dynamic, b:Dynamic, c:Dynamic, d:Dynamic, ?e:Dynamic, ?f:Dynamic, ?g:Dynamic):Void;

	@:overload(function(x:Float, y:Float, z:Float, ?global:Bool):Void
	{
	})
	@:overload(function(torque:Vec3, ?global:Bool):Void
	{
	})
	function AddTorque(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic):Void;

	function SetVelocity(vel:Vec3):Void;
	function GetVelocity():Vec3;
	function SetMass(mass:Float):Void;
	function GetMass():Float;
	function SetPhysicsMode(mode:Int):Void;
	function GetPhysicsMode():Int;
	function SetCollisionType(t:Int):Void;
	function GetCollisionType():Int;
	function SetCollider(collider:Dynamic):Void;
	function GetCollider():Dynamic;
	function SetDamping(lineardamping:Float, angulardamping:Float):Void;
	function SetElasticity(elasticity:Float):Void;
	function SetFriction(kinematicfriction:Float, staticfriction:Float):Void;
	@:overload(function(x:Float, y:Float, z:Float):Void
	{
	})
	function SetGravity(y:Float):Void;
	function SetGravityMode(mode:Bool):Void;
	function SetMassCenter(x:Float, y:Float, z:Float):Void;
	function SetPlayerSize(height:Float, radius:Float, stepheight:Float):Void;
	function SetSweptCollision(mode:Bool):Void;

	// --- Position / Rotation / Scale ---
	function SetPosition(pos:Vec3, ?global:Bool):Void;
	function GetPosition(?global:Bool):Vec3;
	function SetRotation(rot:Vec3, ?global:Bool):Void;
	function GetRotation(?global:Bool):Vec3;
	function GetQuaternion(?global:Bool):Dynamic;
	function GetScale():Vec3;
	@:overload(function(scale:Vec3):Void
	{
	})
	@:overload(function(scale:Float):Void
	{
	})
	function SetScale(x:Float, y:Float, z:Float):Void;
	function GetMatrix(?global:Bool):Dynamic;
	function SetMatrix(matrix:Dynamic, ?global:Bool):Void;
	function Move(x:Float, y:Float, z:Float):Void;
	function Translate(x:Float, y:Float, z:Float):Void;
	@:overload(function(pitch:Float, yaw:Float, roll:Float, ?global:Bool):Void
	{
	})
	@:overload(function(rotation:Vec3, ?global:Bool):Void
	{
	})
	@:overload(function(rotation:Dynamic, ?global:Bool):Void
	{
	})
	function Turn(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic):Void;

	// --- Alignment / Pointing ---
	@:overload(function(x:Float, y:Float, z:Float, ?axis:Int, ?rate:Float, ?roll:Float):Void
	{
	})
	@:overload(function(v:Vec3, ?axis:Int, ?rate:Float, ?roll:Float):Void
	{
	})
	function AlignToVector(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic, ?e:Float):Void;

	@:overload(function(entity:Entity, ?axis:Int, ?rate:Float, ?roll:Float):Void
	{
	})
	@:overload(function(x:Float, y:Float, z:Float, ?axis:Int, ?rate:Float, ?roll:Float):Void
	{
	})
	@:overload(function(position:Vec3, ?axis:Int, ?rate:Float, ?roll:Float):Void
	{
	})
	function Point(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic, ?e:Float):Void;

	// --- Parent / attachment ---
	function SetParent(parent:Dynamic):Void;
	function GetParent():Entity;
	@:overload(function(agent:Dynamic):Void
	{
	})
	@:overload(function(model:Dynamic, bone:Dynamic):Void
	{
	})
	function Attach(a:Dynamic, ?b:Dynamic):Void;
	function Detach():Void;

	// --- Color / Visibility ---
	function SetColor(r:Float, ?g:Float, ?b:Float):Void;
	function GetColor():Vec4;
	function SetHidden(hidden:Bool):Void;
	function GetHidden():Bool;
	function GetEnabled():Bool;
	function SetShadows(enabled:Bool):Void;
	function SetRenderLayers(layers:Int):Void;
	function SetMaterial(material:Dynamic):Void;
	function SetFog(enabled:Bool):Void;
	function GetVisible(entity:Entity):Bool;
	function Sync():Void;
	function Staticize():Void;
	function UpdateBounds(?mode:Int):Void;

	// --- Tags ---
	function AddTag(tag:String):Void;
	function ClearTags():Void;
	function RemoveTag(tag:String):Void;
	function HasTag(tag:String):Bool;

	// --- Children / Hierarchy ---
	@:overload(function(name:String, ?casesensitive:Bool):Entity
	{
	})
	@:overload(function(name:String, ?casesensitive:Bool):Dynamic
	{
	})
	function FindChild(name:String, ?casesensitive:Bool):Dynamic;
	function FindChildren(name:String, ?casesensitive:Bool):Dynamic;

	// --- Collision ---
	@:overload(function(?hits:Int):Dynamic
	{
	})
	@:overload(function(position:Vec3, rotation:Dynamic, ?hits:Int):Dynamic
	{
	})
	function CollisionTest(entity:Entity, ?hits:Int):Dynamic;

	// --- Angular ---
	function GetAngularVelocity():Vec3;
	@:overload(function(omega:Vec3, ?global:Bool):Void
	{
	})
	@:overload(function(x:Float, y:Float, z:Float, ?global:Bool):Void
	{
	})
	function SetAngularVelocity(a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic):Void;

	// --- Picking ---
	function SetPickMode(mode:Int):Void;
	function GetPickMode():Int;

	// --- Input / Player ---
	function GetAirborne():Bool;
	function GetCrouched():Bool;
	function SetInput(angle:Float, move:Float, ?strafe:Float, ?jump:Float, ?crouch:Bool, ?maxaccel:Float, ?maxdecel:Float):Void;

	// --- Sound ---
	function EmitSound(sound:Dynamic, ?range:Float, ?volume:Float, ?pitch:Float, ?loopmode:Bool):Dynamic;
	function Listen():Void;

	// --- Instance / Copy / Load ---
	function Instantiate(world:World, ?recursive:Bool, ?callstart:Bool):Entity;
	function Copy(world:World, ?recursive:Bool, ?callstart:Bool):Entity;

	// --- UUID / World ---
	function GetUuid():String;
	function GetWorld():World;
	function GetDistance(other:Entity):Float;
	function GetBounds(?mode:Int):Dynamic;

	// --- Nav ---
	function SetNavObstacle(enabled:Bool):Void;

	// --- Collision recording ---
	function RecordCollisions(record:Bool):Void;

	// --- Events ---
	function ListenEvent(eventId:Int, source:Dynamic, ?context:Dynamic):Void;

	// --- Lifecycle callbacks (overridable in Lua, declared for type safety) ---
	function Start():Void;
	function Load(properties:Dynamic, binstream:Stream, scene:Scene, flags:Int, extra:Dynamic):Bool;
	function Update():Void;
	function Collide(collidedentity:Entity, position:Vec3, normal:Vec3, speed:Float):Void;

	function Disable():Void;
}

package leadwerks;

#if lua

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

	/** Loads and runs an entity script file (paths relative to project root, e.g. `Entities/HxGen/...`). **/
	function AttachScript(path:String):Void;

	/** Plays a sound at this entity (see Leadwerks `Sound` API). **/
	// function EmitSound(sound:Dynamic, range:Float, ?volume:Float, ?pitch:Float, ?loopmode:Int):Dynamic;
	function EmitSound(sound:Dynamic, range:Float):Void;
}

#elseif cpp

import leadwerks.CppBridge;
import leadwerks.types.Vec3;

/** Boxed `std::shared_ptr<Leadwerks::Entity>` (cameras, primitives, lights, etc.). Release with `Globals.ReleaseEntity`. **/
abstract Entity(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	inline function ptr():cpp.RawPointer<cpp.Void>
		return this;

	public function SetNavObstacle(enabled:Bool):Void
		CppBridge.entity_set_nav_obstacle(ptr(), enabled ? 1 : 0);

	public function SetColor(r:Float, g:Float = 1.0, b:Float = 1.0):Void
		CppBridge.entity_set_color(ptr(), r, g, b);

	public function Attach(agent:NavAgent):Void
		CppBridge.entity_attach(ptr(), agent.toRaw());

	public function SetPosition(pos:Vec3, ?globalSpace:Bool = false):Void
		CppBridge.entity_set_position(ptr(), pos.x, pos.y, pos.z, globalSpace ? 1 : 0);

	public function GetPosition(?globalSpace:Bool = false):Vec3
	{
		var v = CppBridge.entity_get_position(ptr(), globalSpace ? 1 : 0);
		return new Vec3(v.x, v.y, v.z);
	}

	public function Move(x:Float, y:Float, z:Float):Void
		CppBridge.entity_move(ptr(), x, y, z);

	public function Translate(x:Float, y:Float, z:Float):Void
		CppBridge.entity_translate(ptr(), x, y, z);

	public function GetRotation(?globalSpace:Bool = false):Vec3
	{
		var v = CppBridge.entity_get_rotation(ptr(), globalSpace ? 1 : 0);
		return new Vec3(v.x, v.y, v.z);
	}

	public function SetRotation(rot:Vec3, ?globalSpace:Bool = false):Void
		CppBridge.entity_set_rotation(ptr(), rot.x, rot.y, rot.z, globalSpace ? 1 : 0);

	public function SetPhysicsMode(mode:Int):Void
		CppBridge.entity_set_physics_mode(ptr(), mode);

	public function SetMass(mass:Float):Void
		CppBridge.entity_set_mass(ptr(), mass);

	public function GetMass():Float
		return CppBridge.entity_get_mass(ptr());

	public function SetCollisionType(t:Int):Void
		CppBridge.entity_set_collision_type(ptr(), t);

	public function GetCollisionType():Int
		return CppBridge.entity_get_collision_type(ptr());

	public function SetShadows(enabled:Bool):Void
		CppBridge.entity_set_shadows(ptr(), enabled ? 1 : 0);

	public function SetRenderLayers(layers:Int):Void
		CppBridge.entity_set_render_layers(ptr(), layers);

	public function SetParent(?parent:Entity):Void
		CppBridge.entity_set_parent(ptr(), parent == null ? null : parent.ptr());

	public function SetCollider(?collider:Collider):Void
		CppBridge.entity_set_collider(ptr(), collider == null ? null : collider.ptr());

	public function SetVelocity(vel:Vec3):Void
		CppBridge.entity_set_velocity(ptr(), vel.x, vel.y, vel.z);

	public function GetVelocity():Vec3
	{
		var v = CppBridge.entity_get_velocity(ptr());
		return new Vec3(v.x, v.y, v.z);
	}

	public function AddTorque(x:Float, y:Float, z:Float):Void
		CppBridge.entity_add_torque(ptr(), x, y, z);

	public function SetHidden(hidden:Bool):Void
		CppBridge.entity_set_hidden(ptr(), hidden ? 1 : 0);

	public function GetHidden():Bool
		return CppBridge.entity_get_hidden(ptr()) != 0;

	public function FindChild(name:String, recursive:Bool):Null<Entity>
	{
		var p = CppBridge.entity_find_child(ptr(), cpp.ConstCharStar.fromString(name), recursive ? 1 : 0);
		return p == null ? null : new Entity(p);
	}

	public function GetDistance(other:Entity):Float
		return CppBridge.entity_get_distance(ptr(), other.ptr());

	public function SetPickMode(mode:Int):Void
		CppBridge.entity_set_pick_mode(ptr(), mode);

	public function GetPickMode():Int
		return CppBridge.entity_get_pick_mode(ptr());

	public function Disable():Void
		CppBridge.entity_disable(ptr());
}

/** Opaque collider handle for `Entity.SetCollider` (`Leadwerks::Collider` в C++). **/
abstract Collider(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function ptr():cpp.RawPointer<cpp.Void>
		return this;
}

#end

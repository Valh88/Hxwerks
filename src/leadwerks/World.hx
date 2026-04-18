package leadwerks;

#if lua

import haxe.Rest;
import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

@:native("_G")
extern class World
{
	function Update():Void;
	function Render(framebuffer:Framebuffer):Void;

	function GetTime():Float;
	function GetPaused():Bool;
	function Pause():Void;
	function Resume():Void;

	/**
		`GetEntities()` or filtered query, e.g.
		`GetEntities("health", ">", 0, "team", "~=", team)`.
	**/
	function GetEntities(rest:Rest<Dynamic>):Dynamic;

	/**
		Entities in an axis-aligned box; optional property filter pairs after `min`/`max`.
	**/
	function GetEntitiesInArea(min:Vec3, max:Vec3, rest:Rest<Dynamic>):Dynamic;

	/**
		Line pick between two points. Optional `filter` / `extra` for custom filter functions.
	**/
	function Pick(p0:Vec3, p1:Vec3, radius:Float = 0.0, closest:Bool = false, ?filter:Dynamic, ?extra:Dynamic):PickInfo;
}

#elseif cpp

import leadwerks.CppBridge;
import leadwerks.support.CppPick;
import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

/** Boxed `std::shared_ptr<Leadwerks::World>`. **/
abstract World(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	public inline function Update():Void
		CppBridge.world_update(toRaw());

	public inline function Render(framebuffer:Framebuffer, ?vsync:Bool = true):Void
		CppBridge.world_render(toRaw(), framebuffer.toRaw(), vsync ? 1 : 0);

	public inline function GetTime():Float
		return CppBridge.world_get_time(toRaw());

	public inline function GetPaused():Bool
		return CppBridge.world_get_paused(toRaw()) != 0;

	public inline function Pause():Void
		CppBridge.world_pause(toRaw());

	public inline function Resume():Void
		CppBridge.world_resume(toRaw());

	public function Pick(p0:Vec3, p1:Vec3, radius:Float = 0.0, closest:Bool = false):PickInfo
	{
		var r = CppBridge.world_pick(toRaw(), p0.x, p0.y, p0.z, p1.x, p1.y, p1.z, radius, closest ? 1 : 0);
		return CppPick.pickFromNative(r);
	}
}

#end

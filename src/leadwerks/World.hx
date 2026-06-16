package leadwerks;

import haxe.Rest;
import leadwerks.types.AnimationStats;
import leadwerks.types.IVec2;
import leadwerks.types.PhysicsStats;
import leadwerks.types.PickInfo;
import leadwerks.types.RenderStats;
import leadwerks.types.Vec3;

@:native("_G")
extern class World
{
	// --- Properties ---
	var animationstats:AnimationStats;
	var collisions:Dynamic;
	var frequency:Float;
	var physicsstats:PhysicsStats;
	var renderstats:RenderStats;

	// --- Update / Render ---
	function Update(?frequency:Float, ?threads:Int, ?iterations:Int, ?substeps:Int):Void;
	function Render(framebuffer:Framebuffer, ?vsync:Bool, ?syncedframes:Int):Void;

	// --- Time / Pause ---
	function GetTime():Float;
	function GetPaused():Bool;
	function Pause():Void;
	function Resume():Void;

	// --- Entity Queries ---
	@:overload(function():Array<Entity>
	{
	})
	@:overload(function(field:String, operation:String, value:Dynamic, rest:Rest<Dynamic>):Array<Entity>
	{
	})
	function GetEntities(args:Rest<Dynamic>):Dynamic;

	@:overload(function(min:Vec3, max:Vec3):Array<Entity>
	{
	})
	@:overload(function(min:Vec3, max:Vec3, field:String, operation:String, value:Dynamic):Array<Entity>
	{
	})
	function GetEntitiesInArea(min:Vec3, max:Vec3, ?field:String, ?operation:String, ?value:Dynamic):Dynamic;

	function GetTaggedEntities(tag:String):Dynamic;

	// --- Pick / Raycast ---
	function Pick(p0:Vec3, p1:Vec3, radius:Float = 0.0, closest:Bool = false, ?filter:Dynamic, ?extra:Dynamic):PickInfo;

	// --- Lighting ---
	@:overload(function(r:Float, g:Float, b:Float):Void
	{
	})
	function SetAmbientLight(light:Vec3):Void;
	function GetAmbientLight():Vec3;
	function SetEnvironmentMap(texture:Dynamic, id:Int):Void;
	function SetIblIntensity(intensity:Float):Void;

	// --- Gravity ---
	@:overload(function(x:Float, y:Float, z:Float):Void
	{
	})
	function SetGravity(gravity:Vec3):Void;

	// --- Collision ---
	@:native("SetCollision")
	function SetCollisionResponse(type1:Int, type2:Int, response:Int):Void;
	function GetCollisionResponse(type1:Int, type2:Int):Int;
	function ClearCollisionResponses():Void;

	// --- Save ---
	function Save(path:String, ?flags:Int):Bool;

	// --- Quality / Stats ---
	function SetShadowQuality(quality:Float):Void;
	function RecordStats(record:Bool):Void;
}

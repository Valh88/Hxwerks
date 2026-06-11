package leadwerks;

import haxe.Rest;
import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

@:native("_G")
extern class World
{
	// --- Properties ---
	var animationstats:Dynamic;
	var collisions:Dynamic;
	var frequency:Float;
	var physicsstats:Dynamic;
	var renderstats:Dynamic;

	// --- Update / Render ---
	function Update(?frequency:Float, ?threads:Int, ?iterations:Int, ?substeps:Int):Void;
	function Render(framebuffer:Framebuffer, ?vsync:Bool, ?syncedframes:Int):Void;

	// --- Time / Pause ---
	function GetTime():Float;
	function GetPaused():Bool;
	function Pause():Void;
	function Resume():Void;

	// --- Entity Queries ---
	function GetEntities(rest:Rest<Dynamic>):Dynamic;
	function GetEntitiesInArea(min:Vec3, max:Vec3, rest:Rest<Dynamic>):Dynamic;
	function GetTaggedEntities(tag:String):Dynamic;

	// --- Pick / Raycast ---
	function Pick(p0:Vec3, p1:Vec3, radius:Float = 0.0, closest:Bool = false, ?filter:Dynamic, ?extra:Dynamic):PickInfo;

	// --- Lighting ---
	@:overload(function(r:Float, g:Float, b:Float):Void {})
	function SetAmbientLight(light:Vec3):Void;
	function GetAmbientLight():Vec3;
	function SetEnvironmentMap(texture:Dynamic, id:Int):Void;
	function SetIblIntensity(intensity:Float):Void;

	// --- Gravity ---
	@:overload(function(x:Float, y:Float, z:Float):Void {})
	function SetGravity(gravity:Vec3):Void;

	// --- Collision ---
	@:native("SetCollision")
	function SetCollisionResponse(type1:Int, type2:Int, response:Int):Void;
	function GetCollisionResponse(type1:Int, type2:Int):Int;
	function ClearCollisionResponses():Void;

	// --- Quality / Stats ---
	function SetShadowQuality(quality:Float):Void;
	function RecordStats(record:Bool):Void;
}

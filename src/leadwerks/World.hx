package leadwerks;

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

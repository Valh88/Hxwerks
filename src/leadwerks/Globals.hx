package leadwerks;

import leadwerks.types.AabbBounds;
import leadwerks.types.Vec3;

/**
	Global Leadwerks Lua API (`_G`). Extend as you map more engine functions.
**/
@:native("_G")
extern class Globals
{
	static function CreateWorld():World;
	static function CreateBox(?world:World, ?x:Float, ?y:Float, ?z:Float):Entity;
	static function CreateBoxLight(world:World):Light;
	static function CreateCamera(world:World):Camera;
	static function CreateCylinder(world:World, radius:Float, height:Float):Entity;
	static function CreateNavMesh(world:World, x:Float, y:Float, z:Float, ?tilesize:Int, ?cellsize:Float, ?agentradius:Float):NavMesh;
	static function CreateNavAgent(navmesh:NavMesh, ?radius:Float, ?height:Float):NavAgent;
	static function CreateWindow(title:String, x:Int, y:Int, w:Int, h:Int, display:Dynamic, flags:Int):Window;
	static function CreateFramebuffer(window:Window):Framebuffer;
	static function GetDisplays():Dynamic;
	static function ActiveWindow():Window;

	/** No args: [0,1); two args: integer in [lo, hi] (see Leadwerks docs). **/
	static function Random(?lo:Float, ?hi:Float):Float;

	static function Round(x:Float):Float;
	static function LoadScene(world:World, path:String):Dynamic;
	static function LoadMap(world:World, path:String):Dynamic;
	static function Print(msg:String):Void;

	static function EmitEvent(eventId:Int, ?source:Dynamic, ?extra:Dynamic):Void;
	static function ListenEvent(eventId:Int, source:Dynamic, handler:Dynamic, ?extra:Dynamic):Void;

	// Window creation flags
	static var WINDOW_CENTER:Int;
	static var WINDOW_TITLEBAR:Int;

	// Keyboard (subset; add more as needed)
	static var KEY_ESCAPE:Int;
	static var KEY_SPACE:Int;
	static var KEY_UP:Int;
	static var KEY_DOWN:Int;
	static var KEY_SHIFT:Int;
	static var KEY_CONTROL:Int;
	static var KEY_W:Int;
	static var KEY_A:Int;
	static var KEY_S:Int;
	static var KEY_D:Int;
	static var KEY_E:Int;
	static var KEY_Q:Int;
	static var KEY_F:Int;
	static var KEY_G:Int;
	static var KEY_C:Int;
	static var KEY_R:Int;

	static var MOUSE_LEFT:Int;

	// Events (subset)
	static var EVENT_KEYDOWN:Int;
	static var EVENT_KEYUP:Int;
	static var EVENT_MOUSEDOWN:Int;
	static var EVENT_MOUSEUP:Int;
	static var EVENT_MOUSEMOVE:Int;
	static var EVENT_MOUSEWHEEL:Int;
	static var EVENT_MOUSEENTER:Int;
	static var EVENT_MOUSELEAVE:Int;
	static var EVENT_WORLDRESUME:Int;
	static var EVENT_WIDGETACTION:Int;
	static var EVENT_QUIT:Int;

	// Physics / collision modes (engine constants)
	static var PHYSICS_PLAYER:Int;
	static var PHYSICS_DISABLED:Int;
	static var COLLISION_PLAYER:Int;
	static var COLLISION_DEBRIS:Int;
	static var COLLISION_NONE:Int;
	static var COLLISION_TRIGGER:Int;

	// Leadwerks Vec3 constructor is a global function.
	static function Vec3(x:Float, y:Float, z:Float):Dynamic;

	/** Leadwerks Vec2 constructor. **/
	static function Vec2(x:Float, y:Float):Dynamic;

	/** Axis-aligned box; use `bounds.min` / `bounds.max` with `GetEntitiesInArea`. **/
	static function Aabb(min:Vec3, max:Vec3):AabbBounds;
	/** Square root function. **/
	static function Sqrt(x:Float):Float;
	/** Disables picking on an entity (common with projectiles / AI probes). **/
	static var PICK_NONE:Int;

	// Set by generated entity scripts while calling into Haxe.
	static var _hxwerks_self_:Dynamic;
	static var _hxwerks_:Dynamic;
}

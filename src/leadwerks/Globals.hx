package leadwerks;

/**
	Minimal globals for smoke tests (expand with real signatures as needed).
	See Leadwerks Lua API docs and existing `Scripts/*.lua` usage.
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
	static function Random():Float;
	static function LoadScene(world:World, path:String):Dynamic;
	static function LoadMap(world:World, path:String):Dynamic;
	static function Print(msg:String):Void;

	// Common constants used in scripts:
	static var WINDOW_CENTER:Int;
	static var WINDOW_TITLEBAR:Int;
	static var KEY_ESCAPE:Int;
	static var KEY_SPACE:Int;
	static var KEY_UP:Int;
	static var KEY_DOWN:Int;
	static var MOUSE_LEFT:Int;

	// Leadwerks Vec3 constructor is a global function.
	static function Vec3(x:Float, y:Float, z:Float):Dynamic;

	// Set by generated entity scripts while calling into Haxe.
	static var _hxwerks_self_:Dynamic;
	static var _hxwerks_:Dynamic;
}

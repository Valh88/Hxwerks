package leadwerks;

#if lua
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

	/** Axis-aligned box; use `bounds.min` / `bounds.max` with `GetEntitiesInArea`. **/
	static function Aabb(min:Vec3, max:Vec3):AabbBounds;

	/** Disables picking on an entity (common with projectiles / AI probes). **/
	static var PICK_NONE:Int;

	// Set by generated entity scripts while calling into Haxe.
	static var _hxwerks_self_:Dynamic;
	static var _hxwerks_:Dynamic;
}

#elseif cpp

import leadwerks.types.AabbBounds;
import leadwerks.types.Vec3;

/**
	Leadwerks C++ API via [HxwerksCppBridge](native/HxwerksCppBridge.cpp).
**/
class Globals
{
	public static inline function Print(msg:String):Void
		CppBridge.print_native(cpp.ConstCharStar.fromString(msg));

	public static function GetDisplaysCount():Int
		return CppBridge.get_displays_count();

	/** Index 0-based. Release with `ReleaseDisplay` when no longer needed. **/
	public static function GetDisplayAt(index:Int):Display
		return new Display(CppBridge.get_display_at(index));

	public static inline function ReleaseDisplay(d:Display):Void
		CppBridge.release_display(d);

	public static function ActiveWindow():Null<Window>
	{
		var p = CppBridge.active_window();
		return p == null ? null : new Window(p);
	}

	public static function CreateWindow(title:String, x:Int, y:Int, w:Int, h:Int, display:Display, flags:Int):Window
		return new Window(
			CppBridge.create_window(cpp.ConstCharStar.fromString(title), x, y, w, h, display.toRaw(), flags));

	public static function CreateFramebuffer(window:Window):Framebuffer
		return new Framebuffer(CppBridge.create_framebuffer(window.toRaw()));

	public static function CreateWorld():World
		return new World(CppBridge.create_world());

	/** Returns boxed scene or null. Release with `ReleaseScene` when done. **/
	public static function LoadScene(world:World, path:String):Scene
	{
		var p = CppBridge.load_scene(world.toRaw(), cpp.ConstCharStar.fromString(path));
		return p == null ? null : new Scene(p);
	}

	public static function LoadMap(world:World, path:String):Scene
	{
		var p = CppBridge.load_map(world.toRaw(), cpp.ConstCharStar.fromString(path));
		return p == null ? null : new Scene(p);
	}

	public static function CreateCamera(world:World):Camera
		return new Camera(CppBridge.create_camera(world.toRaw()));

	/** Same native object as `Camera`; use for `Entity` APIs (physics, hierarchy, …). **/
	public static inline function CameraAsEntity(c:Camera):Entity
		return new Entity(c.toRaw());

	public static function CreateBox(world:World, x:Float, y:Float, z:Float):Entity
		return new Entity(CppBridge.create_box(world.toRaw(), x, y, z));

	public static function CreateCylinder(world:World, radius:Float, height:Float):Entity
		return new Entity(CppBridge.create_cylinder(world.toRaw(), radius, height));

	public static function CreateBoxLight(world:World):Light
		return new Light(CppBridge.create_box_light(world.toRaw()));

	public static function CreateNavMesh(world:World, x:Float, y:Float, z:Float, ?tilesize:Int = -1, ?cellsize:Float = -1.0, ?agentradius:Float = -1.0):NavMesh
	{
		var ts = tilesize != null ? tilesize : -1;
		var ar = agentradius != null && agentradius > 0 ? agentradius : -1.0;
		if (cellsize != null && cellsize > 0) {} /* future: extra navmesh params */
		return new NavMesh(CppBridge.create_navmesh(world.toRaw(), x, y, z, ts, ts, ar));
	}

	public static function CreateNavAgent(navmesh:NavMesh, ?radius:Float = 0.5, ?height:Float = 1.8):NavAgent
		return new NavAgent(CppBridge.create_nav_agent(navmesh.toRaw(), radius, height));

	public static inline function ReleaseWindow(w:Window):Void
		CppBridge.release_window(w.toRaw());

	public static inline function ReleaseFramebuffer(f:Framebuffer):Void
		CppBridge.release_framebuffer(f.toRaw());

	public static inline function ReleaseWorld(w:World):Void
		CppBridge.release_world(w.toRaw());

	public static inline function ReleaseScene(s:Scene):Void
		CppBridge.release_scene(s.toRaw());

	public static inline function ReleaseEntity(e:Entity):Void
		CppBridge.release_entity(e.toRaw());

	public static inline function ReleaseCamera(c:Camera):Void
		CppBridge.release_camera(c.toRaw());

	public static inline function ReleaseNavMesh(nm:NavMesh):Void
		CppBridge.release_navmesh(nm.toRaw());

	public static inline function ReleaseNavAgent(a:NavAgent):Void
		CppBridge.release_nav_agent(a.toRaw());

	public static function Random(?lo:Float, ?hi:Float):Float
	{
		if (lo == null && hi == null)
			return CppBridge.random_0_1();
		var a = lo != null ? lo : 0.0;
		var b = hi != null ? hi : 1.0;
		return CppBridge.random_range(a, b);
	}

	public static inline function Round(x:Float):Float
		return CppBridge.round_f(x);

	public static inline function Vec3(x:Float, y:Float, z:Float):Vec3
		return new Vec3(x, y, z);

	public static inline function Aabb(min:Vec3, max:Vec3):AabbBounds
		return {min: min, max: max};

	public static inline function EmitEvent(eventId:Int):Void
		CppBridge.emit_event_id(eventId);

	public static inline function EmitEventEntity(eventId:Int, source:Entity):Void
		CppBridge.emit_event_id_entity(eventId, source.toRaw());

	public static var WINDOW_CENTER(get, never):Int;

	static inline function get_WINDOW_CENTER():Int
		return CppBridge.const_window_center();

	public static var WINDOW_TITLEBAR(get, never):Int;

	static inline function get_WINDOW_TITLEBAR():Int
		return CppBridge.const_window_titlebar();

	public static var KEY_ESCAPE(get, never):Int;

	static inline function get_KEY_ESCAPE():Int
		return CppBridge.const_key_escape();

	public static var KEY_SPACE(get, never):Int;

	static inline function get_KEY_SPACE():Int
		return CppBridge.const_key_space();

	public static var KEY_UP(get, never):Int;
	static inline function get_KEY_UP():Int
		return CppBridge.const_key_up();

	public static var KEY_DOWN(get, never):Int;
	static inline function get_KEY_DOWN():Int
		return CppBridge.const_key_down();

	public static var KEY_SHIFT(get, never):Int;
	static inline function get_KEY_SHIFT():Int
		return CppBridge.const_key_shift();

	public static var KEY_CONTROL(get, never):Int;
	static inline function get_KEY_CONTROL():Int
		return CppBridge.const_key_control();

	public static var KEY_W(get, never):Int;
	static inline function get_KEY_W():Int
		return CppBridge.const_key_w();

	public static var KEY_A(get, never):Int;
	static inline function get_KEY_A():Int
		return CppBridge.const_key_a();

	public static var KEY_S(get, never):Int;
	static inline function get_KEY_S():Int
		return CppBridge.const_key_s();

	public static var KEY_D(get, never):Int;
	static inline function get_KEY_D():Int
		return CppBridge.const_key_d();

	public static var KEY_E(get, never):Int;
	static inline function get_KEY_E():Int
		return CppBridge.const_key_e();

	public static var KEY_Q(get, never):Int;
	static inline function get_KEY_Q():Int
		return CppBridge.const_key_q();

	public static var KEY_F(get, never):Int;
	static inline function get_KEY_F():Int
		return CppBridge.const_key_f();

	public static var KEY_G(get, never):Int;
	static inline function get_KEY_G():Int
		return CppBridge.const_key_g();

	public static var KEY_C(get, never):Int;
	static inline function get_KEY_C():Int
		return CppBridge.const_key_c();

	public static var KEY_R(get, never):Int;
	static inline function get_KEY_R():Int
		return CppBridge.const_key_r();

	public static var MOUSE_LEFT(get, never):Int;
	static inline function get_MOUSE_LEFT():Int
		return CppBridge.const_mouse_left();

	public static var EVENT_KEYDOWN(get, never):Int;
	static inline function get_EVENT_KEYDOWN():Int
		return CppBridge.const_event_keydown();

	public static var EVENT_KEYUP(get, never):Int;
	static inline function get_EVENT_KEYUP():Int
		return CppBridge.const_event_keyup();

	public static var EVENT_MOUSEDOWN(get, never):Int;
	static inline function get_EVENT_MOUSEDOWN():Int
		return CppBridge.const_event_mousedown();

	public static var EVENT_MOUSEUP(get, never):Int;
	static inline function get_EVENT_MOUSEUP():Int
		return CppBridge.const_event_mouseup();

	public static var EVENT_MOUSEMOVE(get, never):Int;
	static inline function get_EVENT_MOUSEMOVE():Int
		return CppBridge.const_event_mousemove();

	public static var EVENT_MOUSEWHEEL(get, never):Int;
	static inline function get_EVENT_MOUSEWHEEL():Int
		return CppBridge.const_event_mousewheel();

	public static var EVENT_MOUSEENTER(get, never):Int;
	static inline function get_EVENT_MOUSEENTER():Int
		return CppBridge.const_event_mouseenter();

	public static var EVENT_MOUSELEAVE(get, never):Int;
	static inline function get_EVENT_MOUSELEAVE():Int
		return CppBridge.const_event_mouseleave();

	public static var EVENT_WORLDRESUME(get, never):Int;
	static inline function get_EVENT_WORLDRESUME():Int
		return CppBridge.const_event_worldresume();

	public static var EVENT_WIDGETACTION(get, never):Int;
	static inline function get_EVENT_WIDGETACTION():Int
		return CppBridge.const_event_widgetaction();

	public static var EVENT_QUIT(get, never):Int;
	static inline function get_EVENT_QUIT():Int
		return CppBridge.const_event_quit();

	public static var PHYSICS_PLAYER(get, never):Int;
	static inline function get_PHYSICS_PLAYER():Int
		return CppBridge.const_physics_player();

	public static var PHYSICS_DISABLED(get, never):Int;
	static inline function get_PHYSICS_DISABLED():Int
		return CppBridge.const_physics_disabled();

	public static var COLLISION_PLAYER(get, never):Int;
	static inline function get_COLLISION_PLAYER():Int
		return CppBridge.const_collision_player();

	public static var COLLISION_DEBRIS(get, never):Int;
	static inline function get_COLLISION_DEBRIS():Int
		return CppBridge.const_collision_debris();

	public static var COLLISION_NONE(get, never):Int;
	static inline function get_COLLISION_NONE():Int
		return CppBridge.const_collision_none();

	public static var COLLISION_TRIGGER(get, never):Int;
	static inline function get_COLLISION_TRIGGER():Int
		return CppBridge.const_collision_trigger();

	public static var PICK_NONE(get, never):Int;
	static inline function get_PICK_NONE():Int
		return CppBridge.const_pick_none();
}

#end

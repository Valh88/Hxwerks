package leadwerks;

#if cpp

/**
	FFI to `Hxwerks/cinclude/HxwerksCppBridge.h` (implementation: `Hxwerks/native/HxwerksCppBridge.cpp` in the game project,
	or `Hxwerks/stub/HxwerksCppBridge_stub.cpp` for a link-only standalone `Main.exe`; use `build-cpp-standalone.hxml`).
**/
#if !hxwerks_embed
@:buildXml("<files id=\"haxe\"><file name=\"../Hxwerks/stub/HxwerksCppBridge_stub.cpp\"/></files>")
#end
@:include("../../../Hxwerks/cinclude/HxwerksCppBridge.h")
extern class CppBridge
{
	@:native("hxwerks_print")
	static function print_native(s:cpp.ConstCharStar):Void;

	@:native("hxwerks_get_displays_count")
	static function get_displays_count():Int;

	@:native("hxwerks_get_display_at")
	static function get_display_at(i:Int):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_window")
	static function create_window(title:cpp.ConstCharStar, x:Int, y:Int, w:Int, h:Int, display:cpp.RawPointer<cpp.Void>, flags:Int):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_framebuffer")
	static function create_framebuffer(window:cpp.RawPointer<cpp.Void>):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_world")
	static function create_world():cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_load_scene")
	static function load_scene(world:cpp.RawPointer<cpp.Void>, path:cpp.ConstCharStar):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_load_map")
	static function load_map(world:cpp.RawPointer<cpp.Void>, path:cpp.ConstCharStar):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_active_window")
	static function active_window():cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_random_0_1")
	static function random_0_1():Float;

	@:native("hxwerks_random_range")
	static function random_range(lo:Float, hi:Float):Float;

	@:native("hxwerks_round")
	static function round_f(x:Float):Float;

	@:native("hxwerks_emit_event_id")
	static function emit_event_id(eventId:Int):Void;

	@:native("hxwerks_emit_event_id_entity")
	static function emit_event_id_entity(eventId:Int, entity:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_create_camera")
	static function create_camera(world:cpp.RawPointer<cpp.Void>):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_camera_set_fov")
	static function camera_set_fov(camera:cpp.RawPointer<cpp.Void>, fov:Float):Void;

	@:native("hxwerks_camera_set_clear_color")
	static function camera_set_clear_color(camera:cpp.RawPointer<cpp.Void>, grey:Float):Void;

	@:native("hxwerks_camera_set_rotation")
	static function camera_set_rotation(camera:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_camera_move")
	static function camera_move(camera:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_camera_pick")
	static function camera_pick(camera:cpp.RawPointer<cpp.Void>, framebuffer:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float, recursive:Int):HxwerksPickResultNative;

	@:native("hxwerks_create_box")
	static function create_box(world:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_cylinder")
	static function create_cylinder(world:cpp.RawPointer<cpp.Void>, radius:Float, height:Float):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_box_light")
	static function create_box_light(world:cpp.RawPointer<cpp.Void>):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_navmesh")
	static function create_navmesh(world:cpp.RawPointer<cpp.Void>, width:Float, height:Float, depth:Float, tilesx:Int, tilesz:Int, agentradius:Float):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_create_nav_agent")
	static function create_nav_agent(navmesh:cpp.RawPointer<cpp.Void>, radius:Float, height:Float):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_entity_set_nav_obstacle")
	static function entity_set_nav_obstacle(e:cpp.RawPointer<cpp.Void>, enabled:Int):Void;

	@:native("hxwerks_entity_set_color")
	static function entity_set_color(e:cpp.RawPointer<cpp.Void>, r:Float, g:Float, b:Float):Void;

	@:native("hxwerks_entity_attach")
	static function entity_attach(e:cpp.RawPointer<cpp.Void>, child:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_entity_set_position")
	static function entity_set_position(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float, globalSpace:Int):Void;

	@:native("hxwerks_entity_get_position")
	static function entity_get_position(e:cpp.RawPointer<cpp.Void>, globalSpace:Int):HxwerksVec3Native;

	@:native("hxwerks_entity_move")
	static function entity_move(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_entity_translate")
	static function entity_translate(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_entity_get_rotation")
	static function entity_get_rotation(e:cpp.RawPointer<cpp.Void>, globalSpace:Int):HxwerksVec3Native;

	@:native("hxwerks_entity_set_rotation")
	static function entity_set_rotation(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float, globalSpace:Int):Void;

	@:native("hxwerks_entity_set_physics_mode")
	static function entity_set_physics_mode(e:cpp.RawPointer<cpp.Void>, mode:Int):Void;

	@:native("hxwerks_entity_set_mass")
	static function entity_set_mass(e:cpp.RawPointer<cpp.Void>, mass:Float):Void;

	@:native("hxwerks_entity_get_mass")
	static function entity_get_mass(e:cpp.RawPointer<cpp.Void>):Float;

	@:native("hxwerks_entity_set_collision_type")
	static function entity_set_collision_type(e:cpp.RawPointer<cpp.Void>, t:Int):Void;

	@:native("hxwerks_entity_get_collision_type")
	static function entity_get_collision_type(e:cpp.RawPointer<cpp.Void>):Int;

	@:native("hxwerks_entity_set_shadows")
	static function entity_set_shadows(e:cpp.RawPointer<cpp.Void>, enabled:Int):Void;

	@:native("hxwerks_entity_set_render_layers")
	static function entity_set_render_layers(e:cpp.RawPointer<cpp.Void>, layers:Int):Void;

	@:native("hxwerks_entity_set_parent")
	static function entity_set_parent(e:cpp.RawPointer<cpp.Void>, parent:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_entity_set_collider")
	static function entity_set_collider(e:cpp.RawPointer<cpp.Void>, collider:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_entity_set_velocity")
	static function entity_set_velocity(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_entity_get_velocity")
	static function entity_get_velocity(e:cpp.RawPointer<cpp.Void>):HxwerksVec3Native;

	@:native("hxwerks_entity_add_torque")
	static function entity_add_torque(e:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_entity_set_hidden")
	static function entity_set_hidden(e:cpp.RawPointer<cpp.Void>, hidden:Int):Void;

	@:native("hxwerks_entity_get_hidden")
	static function entity_get_hidden(e:cpp.RawPointer<cpp.Void>):Int;

	@:native("hxwerks_entity_find_child")
	static function entity_find_child(e:cpp.RawPointer<cpp.Void>, name:cpp.ConstCharStar, recursive:Int):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_entity_get_distance")
	static function entity_get_distance(e:cpp.RawPointer<cpp.Void>, other:cpp.RawPointer<cpp.Void>):Float;

	@:native("hxwerks_entity_set_pick_mode")
	static function entity_set_pick_mode(e:cpp.RawPointer<cpp.Void>, mode:Int):Void;

	@:native("hxwerks_entity_get_pick_mode")
	static function entity_get_pick_mode(e:cpp.RawPointer<cpp.Void>):Int;

	@:native("hxwerks_entity_disable")
	static function entity_disable(e:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_light_set_range")
	static function light_set_range(light:cpp.RawPointer<cpp.Void>, a:Float, b:Float):Void;

	@:native("hxwerks_light_set_area")
	static function light_set_area(light:cpp.RawPointer<cpp.Void>, w:Float, h:Float):Void;

	@:native("hxwerks_light_set_rotation")
	static function light_set_rotation(light:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_navmesh_build")
	static function navmesh_build(nm:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_navmesh_random_point")
	static function navmesh_random_point(nm:cpp.RawPointer<cpp.Void>):HxwerksVec3Native;

	@:native("hxwerks_navmesh_set_debugging")
	static function navmesh_set_debugging(nm:cpp.RawPointer<cpp.Void>, enabled:Int):Void;

	@:native("hxwerks_nav_agent_set_position")
	static function nav_agent_set_position(a:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	@:native("hxwerks_nav_agent_get_position")
	static function nav_agent_get_position(a:cpp.RawPointer<cpp.Void>, globalSpace:Int):HxwerksVec3Native;

	@:native("hxwerks_nav_agent_navigate")
	static function nav_agent_navigate(a:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Int;

	@:native("hxwerks_window_closed")
	static function window_closed(window:cpp.RawPointer<cpp.Void>):Int;

	@:native("hxwerks_window_key_down")
	static function window_key_down(window:cpp.RawPointer<cpp.Void>, key:Int):Int;

	@:native("hxwerks_window_key_hit")
	static function window_key_hit(window:cpp.RawPointer<cpp.Void>, key:Int):Int;

	@:native("hxwerks_window_mouse_hit")
	static function window_mouse_hit(window:cpp.RawPointer<cpp.Void>, button:Int):Int;

	@:native("hxwerks_window_get_mouse_position")
	static function window_get_mouse_position(window:cpp.RawPointer<cpp.Void>):HxwerksVec2Native;

	@:native("hxwerks_window_client_size")
	static function window_client_size(window:cpp.RawPointer<cpp.Void>):HxwerksVec2Native;

	@:native("hxwerks_window_set_mouse_position")
	static function window_set_mouse_position(window:cpp.RawPointer<cpp.Void>, x:Float, y:Float):Void;

	@:native("hxwerks_window_get_framebuffer")
	static function window_get_framebuffer(window:cpp.RawPointer<cpp.Void>):cpp.RawPointer<cpp.Void>;

	@:native("hxwerks_world_update")
	static function world_update(world:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_world_render")
	static function world_render(world:cpp.RawPointer<cpp.Void>, framebuffer:cpp.RawPointer<cpp.Void>, vsync:Int):Void;

	@:native("hxwerks_world_get_time")
	static function world_get_time(world:cpp.RawPointer<cpp.Void>):Float;

	@:native("hxwerks_world_get_paused")
	static function world_get_paused(world:cpp.RawPointer<cpp.Void>):Int;

	@:native("hxwerks_world_pause")
	static function world_pause(world:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_world_resume")
	static function world_resume(world:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_world_pick")
	static function world_pick(world:cpp.RawPointer<cpp.Void>, x0:Float, y0:Float, z0:Float, x1:Float, y1:Float, z1:Float, radius:Float, closest:Int):HxwerksPickResultNative;

	@:native("hxwerks_framebuffer_get_size")
	static function framebuffer_get_size(framebuffer:cpp.RawPointer<cpp.Void>):HxwerksVec2Native;

	@:native("hxwerks_release_display")
	static function release_display(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_window")
	static function release_window(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_framebuffer")
	static function release_framebuffer(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_world")
	static function release_world(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_scene")
	static function release_scene(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_entity")
	static function release_entity(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_camera")
	static function release_camera(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_navmesh")
	static function release_navmesh(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_release_nav_agent")
	static function release_nav_agent(p:cpp.RawPointer<cpp.Void>):Void;

	@:native("hxwerks_const_key_escape")
	static function const_key_escape():Int;

	@:native("hxwerks_const_window_center")
	static function const_window_center():Int;

	@:native("hxwerks_const_window_titlebar")
	static function const_window_titlebar():Int;

	@:native("hxwerks_const_key_space")
	static function const_key_space():Int;

	@:native("hxwerks_const_key_up")
	static function const_key_up():Int;

	@:native("hxwerks_const_key_down")
	static function const_key_down():Int;

	@:native("hxwerks_const_key_shift")
	static function const_key_shift():Int;

	@:native("hxwerks_const_key_control")
	static function const_key_control():Int;

	@:native("hxwerks_const_key_w")
	static function const_key_w():Int;

	@:native("hxwerks_const_key_a")
	static function const_key_a():Int;

	@:native("hxwerks_const_key_s")
	static function const_key_s():Int;

	@:native("hxwerks_const_key_d")
	static function const_key_d():Int;

	@:native("hxwerks_const_key_e")
	static function const_key_e():Int;

	@:native("hxwerks_const_key_q")
	static function const_key_q():Int;

	@:native("hxwerks_const_key_f")
	static function const_key_f():Int;

	@:native("hxwerks_const_key_g")
	static function const_key_g():Int;

	@:native("hxwerks_const_key_c")
	static function const_key_c():Int;

	@:native("hxwerks_const_key_r")
	static function const_key_r():Int;

	@:native("hxwerks_const_mouse_left")
	static function const_mouse_left():Int;

	@:native("hxwerks_const_event_keydown")
	static function const_event_keydown():Int;

	@:native("hxwerks_const_event_keyup")
	static function const_event_keyup():Int;

	@:native("hxwerks_const_event_mousedown")
	static function const_event_mousedown():Int;

	@:native("hxwerks_const_event_mouseup")
	static function const_event_mouseup():Int;

	@:native("hxwerks_const_event_mousemove")
	static function const_event_mousemove():Int;

	@:native("hxwerks_const_event_mousewheel")
	static function const_event_mousewheel():Int;

	@:native("hxwerks_const_event_mouseenter")
	static function const_event_mouseenter():Int;

	@:native("hxwerks_const_event_mouseleave")
	static function const_event_mouseleave():Int;

	@:native("hxwerks_const_event_worldresume")
	static function const_event_worldresume():Int;

	@:native("hxwerks_const_event_widgetaction")
	static function const_event_widgetaction():Int;

	@:native("hxwerks_const_event_quit")
	static function const_event_quit():Int;

	@:native("hxwerks_const_physics_player")
	static function const_physics_player():Int;

	@:native("hxwerks_const_physics_disabled")
	static function const_physics_disabled():Int;

	@:native("hxwerks_const_collision_player")
	static function const_collision_player():Int;

	@:native("hxwerks_const_collision_debris")
	static function const_collision_debris():Int;

	@:native("hxwerks_const_collision_none")
	static function const_collision_none():Int;

	@:native("hxwerks_const_collision_trigger")
	static function const_collision_trigger():Int;

	@:native("hxwerks_const_pick_none")
	static function const_pick_none():Int;
}

@:structAccess
@:native("HxwerksVec2")
extern class HxwerksVec2Native
{
	var x:Float;
	var y:Float;
}

@:structAccess
@:native("HxwerksVec3")
extern class HxwerksVec3Native
{
	var x:Float;
	var y:Float;
	var z:Float;
}

@:structAccess
@:native("HxwerksPickResult")
extern class HxwerksPickResultNative
{
	var success:Int;
	var entity:cpp.RawPointer<cpp.Void>;
	var position:HxwerksVec3Native;
}

#end

#include <hxcpp.h>
/**
 * Stub implementations so `haxe build-cpp.hxml` can link Main.exe without the Leadwerks SDK.
 * The game executable uses `Hxwerks/native/HxwerksCppBridge.cpp` instead (see Visual Studio project).
 */
#include "../cinclude/HxwerksCppBridge.h"
#include <cstdio>
#include <cstdlib>

#define HXSTUBV (void)

static HxwerksVec2 z2()
{
	HxwerksVec2 z{0.0, 0.0};
	return z;
}

static HxwerksVec3 z3()
{
	HxwerksVec3 z{0.0, 0.0, 0.0};
	return z;
}

static HxwerksPickResult zpick()
{
	HxwerksPickResult z{};
	return z;
}

extern "C" void hxwerks_print(const char *msg)
{
	if (msg != nullptr)
		std::fputs(msg, stdout);
	std::fputc('\n', stdout);
	std::fflush(stdout);
}

extern "C" int hxwerks_get_displays_count(void) { return 0; }
extern "C" HxBox *hxwerks_get_display_at(int index) { (void)index; return nullptr; }

extern "C" HxBox *hxwerks_create_window(const char *title, int x, int y, int w, int h, HxBox *display_box, int flags)
{
	(void)title;
	(void)x;
	(void)y;
	(void)w;
	(void)h;
	(void)display_box;
	(void)flags;
	return nullptr;
}

extern "C" HxBox *hxwerks_create_framebuffer(HxBox *window_box) { (void)window_box; return nullptr; }
extern "C" HxBox *hxwerks_create_world(void) { return nullptr; }
extern "C" HxBox *hxwerks_load_scene(HxBox *world_box, const char *path) { (void)world_box; (void)path; return nullptr; }
extern "C" HxBox *hxwerks_load_map(HxBox *world_box, const char *path) { (void)world_box; (void)path; return nullptr; }
extern "C" HxBox *hxwerks_active_window(void) { return nullptr; }

extern "C" double hxwerks_random_0_1(void) { return 0.0; }
extern "C" double hxwerks_random_range(double lo, double hi) { (void)hi; return lo; }
extern "C" double hxwerks_round(double x) { return x; }

extern "C" void hxwerks_emit_event_id(int eventId) { (void)eventId; }
extern "C" void hxwerks_emit_event_id_entity(int eventId, HxBox *entity_box) { (void)eventId; (void)entity_box; }

extern "C" HxBox *hxwerks_create_camera(HxBox *world_box) { (void)world_box; return nullptr; }
extern "C" void hxwerks_camera_set_fov(HxBox *camera_box, float fov) { (void)camera_box; (void)fov; }
extern "C" void hxwerks_camera_set_clear_color(HxBox *camera_box, float grey) { (void)camera_box; (void)grey; }
extern "C" void hxwerks_camera_set_rotation(HxBox *camera_box, float x, float y, float z)
{
	(void)camera_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" void hxwerks_camera_move(HxBox *camera_box, float x, float y, float z)
{
	(void)camera_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" HxwerksPickResult hxwerks_camera_pick(HxBox *camera_box, HxBox *framebuffer_box, float x, float y, float z, int recursive)
{
	(void)camera_box;
	(void)framebuffer_box;
	(void)x;
	(void)y;
	(void)z;
	(void)recursive;
	return zpick();
}

extern "C" HxBox *hxwerks_create_box(HxBox *world_box, float x, float y, float z)
{
	(void)world_box;
	(void)x;
	(void)y;
	(void)z;
	return nullptr;
}
extern "C" HxBox *hxwerks_create_cylinder(HxBox *world_box, float radius, float height)
{
	(void)world_box;
	(void)radius;
	(void)height;
	return nullptr;
}
extern "C" HxBox *hxwerks_create_box_light(HxBox *world_box) { (void)world_box; return nullptr; }
extern "C" HxBox *hxwerks_create_navmesh(HxBox *world_box, float width, float height, float depth, int tilesx, int tilesz, float agentradius)
{
	(void)world_box;
	(void)width;
	(void)height;
	(void)depth;
	(void)tilesx;
	(void)tilesz;
	(void)agentradius;
	return nullptr;
}
extern "C" HxBox *hxwerks_create_nav_agent(HxBox *navmesh_box, float radius, float height)
{
	(void)navmesh_box;
	(void)radius;
	(void)height;
	return nullptr;
}

extern "C" void hxwerks_entity_set_nav_obstacle(HxBox *entity_box, int enabled) { (void)entity_box; (void)enabled; }
extern "C" void hxwerks_entity_set_color(HxBox *entity_box, float r, float g, float b)
{
	(void)entity_box;
	(void)r;
	(void)g;
	(void)b;
}
extern "C" void hxwerks_entity_attach(HxBox *entity_box, HxBox *child_box) { (void)entity_box; (void)child_box; }
extern "C" void hxwerks_entity_set_position(HxBox *entity_box, double x, double y, double z, int globalSpace)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
	(void)globalSpace;
}
extern "C" HxwerksVec3 hxwerks_entity_get_position(HxBox *entity_box, int globalSpace) { (void)entity_box; (void)globalSpace; return z3(); }
extern "C" void hxwerks_entity_move(HxBox *entity_box, float x, float y, float z)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" void hxwerks_entity_translate(HxBox *entity_box, float x, float y, float z)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" HxwerksVec3 hxwerks_entity_get_rotation(HxBox *entity_box, int globalSpace) { (void)entity_box; (void)globalSpace; return z3(); }
extern "C" void hxwerks_entity_set_rotation(HxBox *entity_box, double x, double y, double z, int globalSpace)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
	(void)globalSpace;
}
extern "C" void hxwerks_entity_set_physics_mode(HxBox *entity_box, int mode) { (void)entity_box; (void)mode; }
extern "C" void hxwerks_entity_set_mass(HxBox *entity_box, float mass) { (void)entity_box; (void)mass; }
extern "C" float hxwerks_entity_get_mass(HxBox *entity_box) { (void)entity_box; return 0.0f; }
extern "C" void hxwerks_entity_set_collision_type(HxBox *entity_box, int t) { (void)entity_box; (void)t; }
extern "C" int hxwerks_entity_get_collision_type(HxBox *entity_box) { (void)entity_box; return 0; }
extern "C" void hxwerks_entity_set_shadows(HxBox *entity_box, int enabled) { (void)entity_box; (void)enabled; }
extern "C" void hxwerks_entity_set_render_layers(HxBox *entity_box, int layers) { (void)entity_box; (void)layers; }
extern "C" void hxwerks_entity_set_parent(HxBox *entity_box, HxBox *parent_box) { (void)entity_box; (void)parent_box; }
extern "C" void hxwerks_entity_set_collider(HxBox *entity_box, HxBox *collider_box) { (void)entity_box; (void)collider_box; }
extern "C" void hxwerks_entity_set_velocity(HxBox *entity_box, double x, double y, double z)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" HxwerksVec3 hxwerks_entity_get_velocity(HxBox *entity_box) { (void)entity_box; return z3(); }
extern "C" void hxwerks_entity_add_torque(HxBox *entity_box, float x, float y, float z)
{
	(void)entity_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" void hxwerks_entity_set_hidden(HxBox *entity_box, int hidden) { (void)entity_box; (void)hidden; }
extern "C" int hxwerks_entity_get_hidden(HxBox *entity_box) { (void)entity_box; return 0; }
extern "C" HxBox *hxwerks_entity_find_child(HxBox *entity_box, const char *name, int recursive)
{
	(void)entity_box;
	(void)name;
	(void)recursive;
	return nullptr;
}
extern "C" float hxwerks_entity_get_distance(HxBox *entity_box, HxBox *other_box) { (void)entity_box; (void)other_box; return 0.0f; }
extern "C" void hxwerks_entity_set_pick_mode(HxBox *entity_box, int mode) { (void)entity_box; (void)mode; }
extern "C" int hxwerks_entity_get_pick_mode(HxBox *entity_box) { (void)entity_box; return 0; }
extern "C" void hxwerks_entity_disable(HxBox *entity_box) { (void)entity_box; }

extern "C" void hxwerks_light_set_range(HxBox *light_entity_box, float a, float b) { (void)light_entity_box; (void)a; (void)b; }
extern "C" void hxwerks_light_set_area(HxBox *light_entity_box, float w, float h) { (void)light_entity_box; (void)w; (void)h; }
extern "C" void hxwerks_light_set_rotation(HxBox *light_entity_box, float x, float y, float z)
{
	(void)light_entity_box;
	(void)x;
	(void)y;
	(void)z;
}

extern "C" void hxwerks_navmesh_build(HxBox *navmesh_box) { (void)navmesh_box; }
extern "C" HxwerksVec3 hxwerks_navmesh_random_point(HxBox *navmesh_box) { (void)navmesh_box; return z3(); }
extern "C" void hxwerks_navmesh_set_debugging(HxBox *navmesh_box, int enabled) { (void)navmesh_box; (void)enabled; }

extern "C" void hxwerks_nav_agent_set_position(HxBox *agent_box, double x, double y, double z)
{
	(void)agent_box;
	(void)x;
	(void)y;
	(void)z;
}
extern "C" HxwerksVec3 hxwerks_nav_agent_get_position(HxBox *agent_box, int globalSpace) { (void)agent_box; (void)globalSpace; return z3(); }
extern "C" int hxwerks_nav_agent_navigate(HxBox *agent_box, double x, double y, double z)
{
	(void)agent_box;
	(void)x;
	(void)y;
	(void)z;
	return 0;
}

extern "C" int hxwerks_window_closed(HxBox *window_box) { (void)window_box; return 1; }
extern "C" int hxwerks_window_key_down(HxBox *window_box, int key) { (void)window_box; (void)key; return 0; }
extern "C" int hxwerks_window_key_hit(HxBox *window_box, int key) { (void)window_box; (void)key; return 0; }
extern "C" int hxwerks_window_mouse_hit(HxBox *window_box, int button) { (void)window_box; (void)button; return 0; }
extern "C" HxwerksVec2 hxwerks_window_get_mouse_position(HxBox *window_box) { (void)window_box; return z2(); }
extern "C" HxwerksVec2 hxwerks_window_client_size(HxBox *window_box) { (void)window_box; return z2(); }
extern "C" void hxwerks_window_set_mouse_position(HxBox *window_box, float x, float y)
{
	(void)window_box;
	(void)x;
	(void)y;
}
extern "C" HxBox *hxwerks_window_get_framebuffer(HxBox *window_box) { (void)window_box; return nullptr; }

extern "C" void hxwerks_world_update(HxBox *world_box) { (void)world_box; }
extern "C" void hxwerks_world_render(HxBox *world_box, HxBox *framebuffer_box, int vsync)
{
	(void)world_box;
	(void)framebuffer_box;
	(void)vsync;
}
extern "C" double hxwerks_world_get_time(HxBox *world_box) { (void)world_box; return 0.0; }
extern "C" int hxwerks_world_get_paused(HxBox *world_box) { (void)world_box; return 0; }
extern "C" void hxwerks_world_pause(HxBox *world_box) { (void)world_box; }
extern "C" void hxwerks_world_resume(HxBox *world_box) { (void)world_box; }
extern "C" HxwerksPickResult hxwerks_world_pick(HxBox *world_box, double x0, double y0, double z0, double x1, double y1, double z1, float radius, int closest)
{
	(void)world_box;
	(void)x0;
	(void)y0;
	(void)z0;
	(void)x1;
	(void)y1;
	(void)z1;
	(void)radius;
	(void)closest;
	return zpick();
}

extern "C" HxwerksVec2 hxwerks_framebuffer_get_size(HxBox *framebuffer_box) { (void)framebuffer_box; return z2(); }

extern "C" int hxwerks_const_key_escape(void) { return 0; }
extern "C" int hxwerks_const_window_center(void) { return 0; }
extern "C" int hxwerks_const_window_titlebar(void) { return 0; }

extern "C" int hxwerks_const_key_space(void) { return 0; }
extern "C" int hxwerks_const_key_up(void) { return 0; }
extern "C" int hxwerks_const_key_down(void) { return 0; }
extern "C" int hxwerks_const_key_shift(void) { return 0; }
extern "C" int hxwerks_const_key_control(void) { return 0; }
extern "C" int hxwerks_const_key_w(void) { return 0; }
extern "C" int hxwerks_const_key_a(void) { return 0; }
extern "C" int hxwerks_const_key_s(void) { return 0; }
extern "C" int hxwerks_const_key_d(void) { return 0; }
extern "C" int hxwerks_const_key_e(void) { return 0; }
extern "C" int hxwerks_const_key_q(void) { return 0; }
extern "C" int hxwerks_const_key_f(void) { return 0; }
extern "C" int hxwerks_const_key_g(void) { return 0; }
extern "C" int hxwerks_const_key_c(void) { return 0; }
extern "C" int hxwerks_const_key_r(void) { return 0; }

extern "C" int hxwerks_const_mouse_left(void) { return 0; }

extern "C" int hxwerks_const_event_keydown(void) { return 0; }
extern "C" int hxwerks_const_event_keyup(void) { return 0; }
extern "C" int hxwerks_const_event_mousedown(void) { return 0; }
extern "C" int hxwerks_const_event_mouseup(void) { return 0; }
extern "C" int hxwerks_const_event_mousemove(void) { return 0; }
extern "C" int hxwerks_const_event_mousewheel(void) { return 0; }
extern "C" int hxwerks_const_event_mouseenter(void) { return 0; }
extern "C" int hxwerks_const_event_mouseleave(void) { return 0; }
extern "C" int hxwerks_const_event_worldresume(void) { return 0; }
extern "C" int hxwerks_const_event_widgetaction(void) { return 0; }
extern "C" int hxwerks_const_event_quit(void) { return 0; }

extern "C" int hxwerks_const_physics_player(void) { return 0; }
extern "C" int hxwerks_const_physics_disabled(void) { return 0; }
extern "C" int hxwerks_const_collision_player(void) { return 0; }
extern "C" int hxwerks_const_collision_debris(void) { return 0; }
extern "C" int hxwerks_const_collision_none(void) { return 0; }
extern "C" int hxwerks_const_collision_trigger(void) { return 0; }

extern "C" int hxwerks_const_pick_none(void) { return 0; }

extern "C" void hxwerks_release_display(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_window(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_framebuffer(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_world(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_scene(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_entity(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_camera(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_navmesh(HxBox *p) { (void)p; }
extern "C" void hxwerks_release_nav_agent(HxBox *p) { (void)p; }

#undef HXSTUBV

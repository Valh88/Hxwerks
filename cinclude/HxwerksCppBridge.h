#pragma once

/**
 * C ABI helpers for Haxe/cpp (hxcpp) → Leadwerks 5.
 * Opaque handles are heap-allocated std::shared_ptr<T>*; release with the matching hxwerks_release_*.
 * Included by hxcpp with `-I../Hxwerks/cinclude` (see build-cpp.hxml).
 */

#ifdef __cplusplus
extern "C" {
#endif

typedef void HxBox;

typedef struct HxwerksVec2
{
	double x;
	double y;
} HxwerksVec2;

typedef struct HxwerksVec3
{
	double x;
	double y;
	double z;
} HxwerksVec3;

/** World/Camera line pick; entity must be released with hxwerks_release_entity if non-null (adds ref). */
typedef struct HxwerksPickResult
{
	int success;
	HxBox *entity;
	HxwerksVec3 position;
} HxwerksPickResult;

void hxwerks_print(const char *msg);

int hxwerks_get_displays_count(void);
/** Returns boxed std::shared_ptr<Display>* or null on bad index. Caller must hxwerks_release_display. */
HxBox *hxwerks_get_display_at(int index);

HxBox *hxwerks_create_window(const char *title, int x, int y, int w, int h, HxBox *display_box, int flags);
HxBox *hxwerks_create_framebuffer(HxBox *window_box);
HxBox *hxwerks_create_world(void);
/** Returns boxed Scene or null if load failed. */
HxBox *hxwerks_load_scene(HxBox *world_box, const char *path);
HxBox *hxwerks_load_map(HxBox *world_box, const char *path);

/** Active window (may be null). Caller must release if non-null. */
HxBox *hxwerks_active_window(void);

double hxwerks_random_0_1(void);
double hxwerks_random_range(double lo, double hi);
double hxwerks_round(double x);

void hxwerks_emit_event_id(int eventId);
/** source = boxed Entity. */
void hxwerks_emit_event_id_entity(int eventId, HxBox *entity_box);

HxBox *hxwerks_create_camera(HxBox *world_box);
void hxwerks_camera_set_fov(HxBox *camera_box, float fov);
void hxwerks_camera_set_clear_color(HxBox *camera_box, float grey);
void hxwerks_camera_set_rotation(HxBox *camera_box, float x, float y, float z);
void hxwerks_camera_move(HxBox *camera_box, float x, float y, float z);
HxwerksPickResult hxwerks_camera_pick(HxBox *camera_box, HxBox *framebuffer_box, float x, float y, float z, int recursive);

HxBox *hxwerks_create_box(HxBox *world_box, float x, float y, float z);
HxBox *hxwerks_create_cylinder(HxBox *world_box, float radius, float height);
HxBox *hxwerks_create_box_light(HxBox *world_box);
/** tilesx/tilesz: pass -1 to use engine defaults. */
HxBox *hxwerks_create_navmesh(HxBox *world_box, float width, float height, float depth, int tilesx, int tilesz, float agentradius);
HxBox *hxwerks_create_nav_agent(HxBox *navmesh_box, float radius, float height);

void hxwerks_entity_set_nav_obstacle(HxBox *entity_box, int enabled);
void hxwerks_entity_set_color(HxBox *entity_box, float r, float g, float b);
/** child_box = boxed NavAgent (LE5: Entity::Attach(agent)). */
void hxwerks_entity_attach(HxBox *entity_box, HxBox *child_box);
void hxwerks_entity_set_position(HxBox *entity_box, double x, double y, double z, int globalSpace);
HxwerksVec3 hxwerks_entity_get_position(HxBox *entity_box, int globalSpace);
void hxwerks_entity_move(HxBox *entity_box, float x, float y, float z);
void hxwerks_entity_translate(HxBox *entity_box, float x, float y, float z);
HxwerksVec3 hxwerks_entity_get_rotation(HxBox *entity_box, int globalSpace);
void hxwerks_entity_set_rotation(HxBox *entity_box, double x, double y, double z, int globalSpace);
void hxwerks_entity_set_physics_mode(HxBox *entity_box, int mode);
void hxwerks_entity_set_mass(HxBox *entity_box, float mass);
float hxwerks_entity_get_mass(HxBox *entity_box);
void hxwerks_entity_set_collision_type(HxBox *entity_box, int t);
int hxwerks_entity_get_collision_type(HxBox *entity_box);
void hxwerks_entity_set_shadows(HxBox *entity_box, int enabled);
void hxwerks_entity_set_render_layers(HxBox *entity_box, int layers);
void hxwerks_entity_set_parent(HxBox *entity_box, HxBox *parent_box);
void hxwerks_entity_set_collider(HxBox *entity_box, HxBox *collider_box);
void hxwerks_entity_set_velocity(HxBox *entity_box, double x, double y, double z);
HxwerksVec3 hxwerks_entity_get_velocity(HxBox *entity_box);
void hxwerks_entity_add_torque(HxBox *entity_box, float x, float y, float z);
void hxwerks_entity_set_hidden(HxBox *entity_box, int hidden);
int hxwerks_entity_get_hidden(HxBox *entity_box);
HxBox *hxwerks_entity_find_child(HxBox *entity_box, const char *name, int recursive);
float hxwerks_entity_get_distance(HxBox *entity_box, HxBox *other_box);
void hxwerks_entity_set_pick_mode(HxBox *entity_box, int mode);
int hxwerks_entity_get_pick_mode(HxBox *entity_box);
void hxwerks_entity_disable(HxBox *entity_box);

void hxwerks_light_set_range(HxBox *light_entity_box, float a, float b);
void hxwerks_light_set_area(HxBox *light_entity_box, float w, float h);
void hxwerks_light_set_rotation(HxBox *light_entity_box, float x, float y, float z);

void hxwerks_navmesh_build(HxBox *navmesh_box);
HxwerksVec3 hxwerks_navmesh_random_point(HxBox *navmesh_box);
void hxwerks_navmesh_set_debugging(HxBox *navmesh_box, int enabled);

void hxwerks_nav_agent_set_position(HxBox *agent_box, double x, double y, double z);
HxwerksVec3 hxwerks_nav_agent_get_position(HxBox *agent_box, int globalSpace);
int hxwerks_nav_agent_navigate(HxBox *agent_box, double x, double y, double z);

int hxwerks_window_closed(HxBox *window_box);
int hxwerks_window_key_down(HxBox *window_box, int key);
int hxwerks_window_key_hit(HxBox *window_box, int key);
int hxwerks_window_mouse_hit(HxBox *window_box, int button);
HxwerksVec2 hxwerks_window_get_mouse_position(HxBox *window_box);
HxwerksVec2 hxwerks_window_client_size(HxBox *window_box);
void hxwerks_window_set_mouse_position(HxBox *window_box, float x, float y);
HxBox *hxwerks_window_get_framebuffer(HxBox *window_box);

void hxwerks_world_update(HxBox *world_box);
void hxwerks_world_render(HxBox *world_box, HxBox *framebuffer_box, int vsync);
double hxwerks_world_get_time(HxBox *world_box);
int hxwerks_world_get_paused(HxBox *world_box);
void hxwerks_world_pause(HxBox *world_box);
void hxwerks_world_resume(HxBox *world_box);
HxwerksPickResult hxwerks_world_pick(HxBox *world_box, double x0, double y0, double z0, double x1, double y1, double z1, float radius, int closest);

HxwerksVec2 hxwerks_framebuffer_get_size(HxBox *framebuffer_box);

int hxwerks_const_key_escape(void);
int hxwerks_const_window_center(void);
int hxwerks_const_window_titlebar(void);

int hxwerks_const_key_space(void);
int hxwerks_const_key_up(void);
int hxwerks_const_key_down(void);
int hxwerks_const_key_shift(void);
int hxwerks_const_key_control(void);
int hxwerks_const_key_w(void);
int hxwerks_const_key_a(void);
int hxwerks_const_key_s(void);
int hxwerks_const_key_d(void);
int hxwerks_const_key_e(void);
int hxwerks_const_key_q(void);
int hxwerks_const_key_f(void);
int hxwerks_const_key_g(void);
int hxwerks_const_key_c(void);
int hxwerks_const_key_r(void);

int hxwerks_const_mouse_left(void);

int hxwerks_const_event_keydown(void);
int hxwerks_const_event_keyup(void);
int hxwerks_const_event_mousedown(void);
int hxwerks_const_event_mouseup(void);
int hxwerks_const_event_mousemove(void);
int hxwerks_const_event_mousewheel(void);
int hxwerks_const_event_mouseenter(void);
int hxwerks_const_event_mouseleave(void);
int hxwerks_const_event_worldresume(void);
int hxwerks_const_event_widgetaction(void);
int hxwerks_const_event_quit(void);

int hxwerks_const_physics_player(void);
int hxwerks_const_physics_disabled(void);
int hxwerks_const_collision_player(void);
int hxwerks_const_collision_debris(void);
int hxwerks_const_collision_none(void);
int hxwerks_const_collision_trigger(void);

int hxwerks_const_pick_none(void);

void hxwerks_release_display(HxBox *p);
void hxwerks_release_window(HxBox *p);
void hxwerks_release_framebuffer(HxBox *p);
void hxwerks_release_world(HxBox *p);
void hxwerks_release_scene(HxBox *p);
void hxwerks_release_entity(HxBox *p);
void hxwerks_release_camera(HxBox *p);
void hxwerks_release_navmesh(HxBox *p);
void hxwerks_release_nav_agent(HxBox *p);

#ifdef __cplusplus
}
#endif

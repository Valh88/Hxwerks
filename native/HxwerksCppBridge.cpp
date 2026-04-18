#include "Leadwerks.h"
#include "../cinclude/HxwerksCppBridge.h"

#include <cmath>
#include <memory>

using namespace Leadwerks;

namespace
{
template<typename T>
HxBox *box_shared(std::shared_ptr<T> p)
{
	return reinterpret_cast<HxBox *>(new std::shared_ptr<T>(std::move(p)));
}

template<typename T>
std::shared_ptr<T> &unbox(HxBox *b)
{
	return *reinterpret_cast<std::shared_ptr<T> *>(b);
}

static HxwerksVec3 hv3(const Vec3 &v)
{
	HxwerksVec3 r{static_cast<double>(v.x), static_cast<double>(v.y), static_cast<double>(v.z)};
	return r;
}

static HxwerksPickResult pick_result(const PickInfo &info)
{
	HxwerksPickResult r{};
	r.success = info.entity ? 1 : 0;
	r.entity = info.entity ? box_shared(info.entity) : nullptr;
	r.position = hv3(info.position);
	return r;
}

static bool hxwerks_pick_pass_all(std::shared_ptr<Entity> e, std::shared_ptr<Object> extra)
{
	(void)e;
	(void)extra;
	return true;
}
} // namespace

extern "C" void hxwerks_print(const char *msg)
{
	if (msg == nullptr)
		return;
	Print(Leadwerks::String(msg));
}

extern "C" int hxwerks_get_displays_count(void)
{
	auto displays = GetDisplays();
	return static_cast<int>(displays.size());
}

extern "C" HxBox *hxwerks_get_display_at(int index)
{
	auto displays = GetDisplays();
	if (index < 0 || index >= static_cast<int>(displays.size()))
		return nullptr;
	return box_shared(displays[static_cast<size_t>(index)]);
}

extern "C" HxBox *hxwerks_create_window(const char *title, int x, int y, int w, int h, HxBox *display_box, int flags)
{
	if (display_box == nullptr)
		return nullptr;
	std::shared_ptr<Display> &display = unbox<Display>(display_box);
	WString wtitle = title != nullptr ? WString(Leadwerks::String(title)) : WString("Hxwerks");
	auto win = CreateWindow(wtitle, x, y, w, h, display, static_cast<WindowStyles>(flags));
	return box_shared(win);
}

extern "C" HxBox *hxwerks_create_framebuffer(HxBox *window_box)
{
	if (window_box == nullptr)
		return nullptr;
	auto &window = unbox<Window>(window_box);
	return box_shared(CreateFramebuffer(window));
}

extern "C" HxBox *hxwerks_create_world(void)
{
	return box_shared(CreateWorld());
}

extern "C" HxBox *hxwerks_load_scene(HxBox *world_box, const char *path)
{
	if (world_box == nullptr || path == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	auto scene = LoadScene(world, WString(Leadwerks::String(path)));
	if (!scene)
		return nullptr;
	return box_shared(scene);
}

extern "C" HxBox *hxwerks_load_map(HxBox *world_box, const char *path)
{
	if (world_box == nullptr || path == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	auto scene = LoadMap(world, WString(Leadwerks::String(path)));
	if (!scene)
		return nullptr;
	return box_shared(scene);
}

extern "C" HxBox *hxwerks_active_window(void)
{
	auto w = ActiveWindow();
	if (!w)
		return nullptr;
	return box_shared(w);
}

extern "C" double hxwerks_random_0_1(void)
{
	return static_cast<double>(Random());
}

extern "C" double hxwerks_random_range(double lo, double hi)
{
	return static_cast<double>(Random(static_cast<float>(lo), static_cast<float>(hi)));
}

extern "C" double hxwerks_round(double x)
{
	return static_cast<double>(Round(static_cast<float>(x)));
}

extern "C" void hxwerks_emit_event_id(int eventId)
{
	EmitEvent(eventId);
}

extern "C" void hxwerks_emit_event_id_entity(int eventId, HxBox *entity_box)
{
	if (entity_box == nullptr)
		return;
	EmitEvent(eventId, unbox<Entity>(entity_box));
}

extern "C" HxBox *hxwerks_create_camera(HxBox *world_box)
{
	if (world_box == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	std::shared_ptr<Entity> e = CreateCamera(world);
	return box_shared(e);
}

extern "C" void hxwerks_camera_set_fov(HxBox *camera_box, float fov)
{
	if (camera_box == nullptr)
		return;
	auto cam = std::dynamic_pointer_cast<Camera>(unbox<Entity>(camera_box));
	if (cam)
		cam->SetFov(fov);
}

extern "C" void hxwerks_camera_set_clear_color(HxBox *camera_box, float grey)
{
	if (camera_box == nullptr)
		return;
	auto cam = std::dynamic_pointer_cast<Camera>(unbox<Entity>(camera_box));
	if (cam)
		cam->SetClearColor(grey);
}

extern "C" void hxwerks_camera_set_rotation(HxBox *camera_box, float x, float y, float z)
{
	if (camera_box == nullptr)
		return;
	auto cam = std::dynamic_pointer_cast<Camera>(unbox<Entity>(camera_box));
	if (cam)
		cam->SetRotation(Vec3(x, y, z));
}

extern "C" void hxwerks_camera_move(HxBox *camera_box, float x, float y, float z)
{
	if (camera_box == nullptr)
		return;
	auto cam = std::dynamic_pointer_cast<Camera>(unbox<Entity>(camera_box));
	if (cam)
		cam->Move(x, y, z);
}

extern "C" HxwerksPickResult hxwerks_camera_pick(HxBox *camera_box, HxBox *framebuffer_box, float x, float y, float z, int recursive)
{
	(void)z;
	(void)recursive;
	HxwerksPickResult empty{};
	if (camera_box == nullptr || framebuffer_box == nullptr)
		return empty;
	auto cam = std::dynamic_pointer_cast<Camera>(unbox<Entity>(camera_box));
	if (!cam)
		return empty;
	auto &fb = unbox<Framebuffer>(framebuffer_box);
	PickInfo info = cam->Pick(fb, x, y);
	return pick_result(info);
}

extern "C" HxBox *hxwerks_create_box(HxBox *world_box, float x, float y, float z)
{
	if (world_box == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	return box_shared(CreateBox(world, x, y, z));
}

extern "C" HxBox *hxwerks_create_cylinder(HxBox *world_box, float radius, float height)
{
	if (world_box == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	return box_shared(CreateCylinder(world, radius, height));
}

extern "C" HxBox *hxwerks_create_box_light(HxBox *world_box)
{
	if (world_box == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	std::shared_ptr<Entity> e = CreateBoxLight(world);
	return box_shared(e);
}

extern "C" HxBox *hxwerks_create_navmesh(HxBox *world_box, float width, float height, float depth, int tilesx, int tilesz, float agentradius)
{
	if (world_box == nullptr)
		return nullptr;
	auto &world = unbox<World>(world_box);
	const int tsx = tilesx > 0 ? tilesx : 16;
	const int tsz = tilesz > 0 ? tilesz : 16;
	const float ar = agentradius > 0.0f ? agentradius : 0.4f;
	auto nm = CreateNavMesh(world, width, height, depth, tsx, tsz, ar);
	return box_shared(nm);
}

extern "C" HxBox *hxwerks_create_nav_agent(HxBox *navmesh_box, float radius, float height)
{
	if (navmesh_box == nullptr)
		return nullptr;
	auto &nm = unbox<NavMesh>(navmesh_box);
	auto agent = CreateNavAgent(nm, radius, height);
	return box_shared(agent);
}

extern "C" void hxwerks_entity_set_nav_obstacle(HxBox *entity_box, int enabled)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetNavObstacle(enabled != 0);
}

extern "C" void hxwerks_entity_set_color(HxBox *entity_box, float r, float g, float b)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetColor(r, g, b);
}

extern "C" void hxwerks_entity_attach(HxBox *entity_box, HxBox *child_box)
{
	if (entity_box == nullptr || child_box == nullptr)
		return;
	/* LE5: Entity::Attach(shared_ptr<NavAgent>) — прикрепление агента к сущности (см. Enemy.cpp). */
	unbox<Entity>(entity_box)->Attach(unbox<NavAgent>(child_box));
}

extern "C" void hxwerks_entity_set_position(HxBox *entity_box, double x, double y, double z, int globalSpace)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetPosition(Vec3(static_cast<float>(x), static_cast<float>(y), static_cast<float>(z)), globalSpace != 0);
}

extern "C" HxwerksVec3 hxwerks_entity_get_position(HxBox *entity_box, int globalSpace)
{
	HxwerksVec3 z{0, 0, 0};
	if (entity_box == nullptr)
		return z;
	return hv3(unbox<Entity>(entity_box)->GetPosition(globalSpace != 0));
}

extern "C" void hxwerks_entity_move(HxBox *entity_box, float x, float y, float z)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->Move(x, y, z);
}

extern "C" void hxwerks_entity_translate(HxBox *entity_box, float x, float y, float z)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->Translate(x, y, z);
}

extern "C" HxwerksVec3 hxwerks_entity_get_rotation(HxBox *entity_box, int globalSpace)
{
	HxwerksVec3 z{0, 0, 0};
	if (entity_box == nullptr)
		return z;
	return hv3(unbox<Entity>(entity_box)->GetRotation(globalSpace != 0));
}

extern "C" void hxwerks_entity_set_rotation(HxBox *entity_box, double x, double y, double z, int globalSpace)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetRotation(Vec3(static_cast<float>(x), static_cast<float>(y), static_cast<float>(z)), globalSpace != 0);
}

extern "C" void hxwerks_entity_set_physics_mode(HxBox *entity_box, int mode)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetPhysicsMode(static_cast<PhysicsMode>(mode));
}

extern "C" void hxwerks_entity_set_mass(HxBox *entity_box, float mass)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetMass(mass);
}

extern "C" float hxwerks_entity_get_mass(HxBox *entity_box)
{
	if (entity_box == nullptr)
		return 0.0f;
	return unbox<Entity>(entity_box)->GetMass();
}

extern "C" void hxwerks_entity_set_collision_type(HxBox *entity_box, int t)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetCollisionType(static_cast<CollisionType>(t));
}

extern "C" int hxwerks_entity_get_collision_type(HxBox *entity_box)
{
	if (entity_box == nullptr)
		return 0;
	return static_cast<int>(unbox<Entity>(entity_box)->GetCollisionType());
}

extern "C" void hxwerks_entity_set_shadows(HxBox *entity_box, int enabled)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetShadows(enabled != 0);
}

extern "C" void hxwerks_entity_set_render_layers(HxBox *entity_box, int layers)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetRenderLayers(layers);
}

extern "C" void hxwerks_entity_set_parent(HxBox *entity_box, HxBox *parent_box)
{
	if (entity_box == nullptr)
		return;
	if (parent_box == nullptr)
		unbox<Entity>(entity_box)->SetParent(nullptr);
	else
		unbox<Entity>(entity_box)->SetParent(unbox<Entity>(parent_box));
}

extern "C" void hxwerks_entity_set_collider(HxBox *entity_box, HxBox *collider_box)
{
	if (entity_box == nullptr)
		return;
	if (collider_box == nullptr)
		unbox<Entity>(entity_box)->SetCollider(nullptr);
	else
		unbox<Entity>(entity_box)->SetCollider(unbox<Collider>(collider_box));
}

extern "C" void hxwerks_entity_set_velocity(HxBox *entity_box, double x, double y, double z)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetVelocity(Vec3(static_cast<float>(x), static_cast<float>(y), static_cast<float>(z)));
}

extern "C" HxwerksVec3 hxwerks_entity_get_velocity(HxBox *entity_box)
{
	HxwerksVec3 z{0, 0, 0};
	if (entity_box == nullptr)
		return z;
	return hv3(unbox<Entity>(entity_box)->GetVelocity());
}

extern "C" void hxwerks_entity_add_torque(HxBox *entity_box, float x, float y, float z)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->AddTorque(x, y, z);
}

extern "C" void hxwerks_entity_set_hidden(HxBox *entity_box, int hidden)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetHidden(hidden != 0);
}

extern "C" int hxwerks_entity_get_hidden(HxBox *entity_box)
{
	if (entity_box == nullptr)
		return 0;
	return unbox<Entity>(entity_box)->GetHidden() ? 1 : 0;
}

extern "C" HxBox *hxwerks_entity_find_child(HxBox *entity_box, const char *name, int recursive)
{
	if (entity_box == nullptr || name == nullptr)
		return nullptr;
	auto c = unbox<Entity>(entity_box)->FindChild(Leadwerks::String(name), recursive != 0);
	if (!c)
		return nullptr;
	return box_shared(c);
}

extern "C" float hxwerks_entity_get_distance(HxBox *entity_box, HxBox *other_box)
{
	if (entity_box == nullptr || other_box == nullptr)
		return 0.0f;
	return unbox<Entity>(entity_box)->GetDistance(unbox<Entity>(other_box));
}

extern "C" void hxwerks_entity_set_pick_mode(HxBox *entity_box, int mode)
{
	if (entity_box == nullptr)
		return;
	unbox<Entity>(entity_box)->SetPickMode(static_cast<PickMode>(mode), false);
}

extern "C" int hxwerks_entity_get_pick_mode(HxBox *entity_box)
{
	if (entity_box == nullptr)
		return 0;
	return static_cast<int>(unbox<Entity>(entity_box)->GetPickMode());
}

extern "C" void hxwerks_entity_disable(HxBox *entity_box)
{
	if (entity_box == nullptr)
		return;
	/* Entity::Disable() в LE5 protected; вне компонента — скрыть объект. */
	unbox<Entity>(entity_box)->SetHidden(true);
}

extern "C" void hxwerks_light_set_range(HxBox *light_entity_box, float a, float b)
{
	if (light_entity_box == nullptr)
		return;
	auto L = std::dynamic_pointer_cast<Light>(unbox<Entity>(light_entity_box));
	if (L)
		L->SetRange(a, b);
}

extern "C" void hxwerks_light_set_area(HxBox *light_entity_box, float w, float h)
{
	if (light_entity_box == nullptr)
		return;
	(void)w;
	(void)h;
	/* В LE5 у Light нет SetArea(w,h) в том виде — при необходимости задайте масштаб/диапазон вручную в SDK. */
	auto L = std::dynamic_pointer_cast<Light>(unbox<Entity>(light_entity_box));
	(void)L;
}

extern "C" void hxwerks_light_set_rotation(HxBox *light_entity_box, float x, float y, float z)
{
	if (light_entity_box == nullptr)
		return;
	auto L = std::dynamic_pointer_cast<Light>(unbox<Entity>(light_entity_box));
	if (L)
		L->SetRotation(x, y, z);
}

extern "C" void hxwerks_navmesh_build(HxBox *navmesh_box)
{
	if (navmesh_box == nullptr)
		return;
	unbox<NavMesh>(navmesh_box)->Build();
}

extern "C" HxwerksVec3 hxwerks_navmesh_random_point(HxBox *navmesh_box)
{
	HxwerksVec3 z{0, 0, 0};
	(void)navmesh_box;
	/* Реализуйте вызов метода навмеша из вашего Leadwerks SDK (имя/сигнатура отличаются между версиями). */
	return z;
}

extern "C" void hxwerks_navmesh_set_debugging(HxBox *navmesh_box, int enabled)
{
	if (navmesh_box == nullptr)
		return;
	(void)enabled;
	/* Опционально: присвойте вызов отладки навмеша из вашей версии SDK. */
}

extern "C" void hxwerks_nav_agent_set_position(HxBox *agent_box, double x, double y, double z)
{
	if (agent_box == nullptr)
		return;
	unbox<NavAgent>(agent_box)->SetPosition(static_cast<float>(x), static_cast<float>(y), static_cast<float>(z));
}

extern "C" HxwerksVec3 hxwerks_nav_agent_get_position(HxBox *agent_box, int globalSpace)
{
	HxwerksVec3 z{0, 0, 0};
	if (agent_box == nullptr)
		return z;
	return hv3(unbox<NavAgent>(agent_box)->GetPosition(globalSpace != 0));
}

extern "C" int hxwerks_nav_agent_navigate(HxBox *agent_box, double x, double y, double z)
{
	if (agent_box == nullptr)
		return 0;
	return unbox<NavAgent>(agent_box)->Navigate(Vec3(static_cast<float>(x), static_cast<float>(y), static_cast<float>(z))) ? 1 : 0;
}

extern "C" int hxwerks_window_closed(HxBox *window_box)
{
	if (window_box == nullptr)
		return 1;
	return unbox<Window>(window_box)->Closed() ? 1 : 0;
}

extern "C" int hxwerks_window_key_down(HxBox *window_box, int key)
{
	if (window_box == nullptr)
		return 0;
	return unbox<Window>(window_box)->KeyDown(static_cast<KeyCode>(key)) ? 1 : 0;
}

extern "C" int hxwerks_window_key_hit(HxBox *window_box, int key)
{
	if (window_box == nullptr)
		return 0;
	return unbox<Window>(window_box)->KeyHit(static_cast<KeyCode>(key)) ? 1 : 0;
}

extern "C" int hxwerks_window_mouse_hit(HxBox *window_box, int button)
{
	if (window_box == nullptr)
		return 0;
	return unbox<Window>(window_box)->MouseHit(static_cast<MouseButton>(button)) ? 1 : 0;
}

extern "C" HxwerksVec2 hxwerks_window_get_mouse_position(HxBox *window_box)
{
	HxwerksVec2 r{0.0, 0.0};
	if (window_box == nullptr)
		return r;
	auto p = unbox<Window>(window_box)->GetMousePosition();
	r.x = static_cast<double>(p.x);
	r.y = static_cast<double>(p.y);
	return r;
}

extern "C" HxwerksVec2 hxwerks_window_client_size(HxBox *window_box)
{
	HxwerksVec2 r{0.0, 0.0};
	if (window_box == nullptr)
		return r;
	auto p = unbox<Window>(window_box)->ClientSize();
	r.x = static_cast<double>(p.x);
	r.y = static_cast<double>(p.y);
	return r;
}

extern "C" void hxwerks_window_set_mouse_position(HxBox *window_box, float x, float y)
{
	if (window_box == nullptr)
		return;
	unbox<Window>(window_box)->SetMousePosition(x, y);
}

extern "C" HxBox *hxwerks_window_get_framebuffer(HxBox *window_box)
{
	if (window_box == nullptr)
		return nullptr;
	return box_shared(unbox<Window>(window_box)->GetFramebuffer());
}

extern "C" void hxwerks_world_update(HxBox *world_box)
{
	if (world_box == nullptr)
		return;
	unbox<World>(world_box)->Update();
}

extern "C" void hxwerks_world_render(HxBox *world_box, HxBox *framebuffer_box, int vsync)
{
	if (world_box == nullptr || framebuffer_box == nullptr)
		return;
	unbox<World>(world_box)->Render(unbox<Framebuffer>(framebuffer_box), vsync != 0);
}

extern "C" double hxwerks_world_get_time(HxBox *world_box)
{
	if (world_box == nullptr)
		return 0.0;
	return static_cast<double>(unbox<World>(world_box)->GetTime());
}

extern "C" int hxwerks_world_get_paused(HxBox *world_box)
{
	if (world_box == nullptr)
		return 0;
	return unbox<World>(world_box)->GetPaused() ? 1 : 0;
}

extern "C" void hxwerks_world_pause(HxBox *world_box)
{
	if (world_box == nullptr)
		return;
	unbox<World>(world_box)->Pause();
}

extern "C" void hxwerks_world_resume(HxBox *world_box)
{
	if (world_box == nullptr)
		return;
	unbox<World>(world_box)->Resume();
}

extern "C" HxwerksPickResult hxwerks_world_pick(HxBox *world_box, double x0, double y0, double z0, double x1, double y1, double z1, float radius, int closest)
{
	HxwerksPickResult empty{};
	if (world_box == nullptr)
		return empty;
	auto &world = unbox<World>(world_box);
	Vec3 p0(static_cast<float>(x0), static_cast<float>(y0), static_cast<float>(z0));
	Vec3 p1(static_cast<float>(x1), static_cast<float>(y1), static_cast<float>(z1));
	PickInfo info = world->Pick(p0, p1, radius, closest != 0, hxwerks_pick_pass_all, nullptr);
	return pick_result(info);
}

extern "C" HxwerksVec2 hxwerks_framebuffer_get_size(HxBox *framebuffer_box)
{
	HxwerksVec2 r{0.0, 0.0};
	if (framebuffer_box == nullptr)
		return r;
	auto sz = unbox<Framebuffer>(framebuffer_box)->GetSize();
	r.x = static_cast<double>(sz.x);
	r.y = static_cast<double>(sz.y);
	return r;
}

extern "C" int hxwerks_const_key_escape(void) { return KEY_ESCAPE; }
extern "C" int hxwerks_const_window_center(void) { return WINDOW_CENTER; }
extern "C" int hxwerks_const_window_titlebar(void) { return WINDOW_TITLEBAR; }

extern "C" int hxwerks_const_key_space(void) { return KEY_SPACE; }
extern "C" int hxwerks_const_key_up(void) { return KEY_UP; }
extern "C" int hxwerks_const_key_down(void) { return KEY_DOWN; }
extern "C" int hxwerks_const_key_shift(void) { return KEY_SHIFT; }
extern "C" int hxwerks_const_key_control(void) { return KEY_CONTROL; }
extern "C" int hxwerks_const_key_w(void) { return KEY_W; }
extern "C" int hxwerks_const_key_a(void) { return KEY_A; }
extern "C" int hxwerks_const_key_s(void) { return KEY_S; }
extern "C" int hxwerks_const_key_d(void) { return KEY_D; }
extern "C" int hxwerks_const_key_e(void) { return KEY_E; }
extern "C" int hxwerks_const_key_q(void) { return KEY_Q; }
extern "C" int hxwerks_const_key_f(void) { return KEY_F; }
extern "C" int hxwerks_const_key_g(void) { return KEY_G; }
extern "C" int hxwerks_const_key_c(void) { return KEY_C; }
extern "C" int hxwerks_const_key_r(void) { return KEY_R; }

extern "C" int hxwerks_const_mouse_left(void) { return MOUSE_LEFT; }

extern "C" int hxwerks_const_event_keydown(void) { return EVENT_KEYDOWN; }
extern "C" int hxwerks_const_event_keyup(void) { return EVENT_KEYUP; }
extern "C" int hxwerks_const_event_mousedown(void) { return EVENT_MOUSEDOWN; }
extern "C" int hxwerks_const_event_mouseup(void) { return EVENT_MOUSEUP; }
extern "C" int hxwerks_const_event_mousemove(void) { return EVENT_MOUSEMOVE; }
extern "C" int hxwerks_const_event_mousewheel(void) { return EVENT_MOUSEWHEEL; }
extern "C" int hxwerks_const_event_mouseenter(void) { return EVENT_MOUSEENTER; }
extern "C" int hxwerks_const_event_mouseleave(void) { return EVENT_MOUSELEAVE; }
extern "C" int hxwerks_const_event_worldresume(void) { return EVENT_WORLDRESUME; }
extern "C" int hxwerks_const_event_widgetaction(void) { return EVENT_WIDGETACTION; }
extern "C" int hxwerks_const_event_quit(void) { return EVENT_QUIT; }

extern "C" int hxwerks_const_physics_player(void) { return PHYSICS_PLAYER; }
extern "C" int hxwerks_const_physics_disabled(void) { return PHYSICS_DISABLED; }
extern "C" int hxwerks_const_collision_player(void) { return COLLISION_PLAYER; }
extern "C" int hxwerks_const_collision_debris(void) { return COLLISION_DEBRIS; }
extern "C" int hxwerks_const_collision_none(void) { return COLLISION_NONE; }
extern "C" int hxwerks_const_collision_trigger(void) { return COLLISION_TRIGGER; }

extern "C" int hxwerks_const_pick_none(void) { return PICK_NONE; }

extern "C" void hxwerks_release_display(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<Display> *>(p);
}

extern "C" void hxwerks_release_window(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<Window> *>(p);
}

extern "C" void hxwerks_release_framebuffer(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<Framebuffer> *>(p);
}

extern "C" void hxwerks_release_world(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<World> *>(p);
}

extern "C" void hxwerks_release_scene(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<Scene> *>(p);
}

extern "C" void hxwerks_release_entity(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<Entity> *>(p);
}

extern "C" void hxwerks_release_camera(HxBox *p)
{
	hxwerks_release_entity(p);
}

extern "C" void hxwerks_release_navmesh(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<NavMesh> *>(p);
}

extern "C" void hxwerks_release_nav_agent(HxBox *p)
{
	if (p == nullptr)
		return;
	delete reinterpret_cast<std::shared_ptr<NavAgent> *>(p);
}

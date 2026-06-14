package leadwerks;

import leadwerks.Display;
import leadwerks.types.AabbBounds;
import leadwerks.types.IVec2;
import leadwerks.types.IVec3;
import leadwerks.types.IVec4;
import leadwerks.types.Mat4;
import leadwerks.types.PickInfo;
import leadwerks.types.Plane;
import leadwerks.types.Quat;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.types.Vec4;

@:native("_G")
extern class Globals
{
	// --- World creation ---
	static function CreateWorld():World;

	// --- Entity factories ---
	static function CreateBox(?world:World, ?x:Float, ?y:Float, ?z:Float):Entity;
	static function CreateCylinder(world:World, radius:Float, height:Float):Entity;
	static function CreateSphere(world:World, ?radius:Float, ?sides:Int):Entity;
	static function CreatePivot(world:World):Entity;
	static function CreatePlane(world:World, ?width:Float, ?height:Float, ?xsegs:Int, ?ysegs:Int, ?type:Int):Entity;
	static function CreateCone(world:World, ?radius:Float, ?height:Float, ?sides:Int):Entity;
	static function CreateCubeSphere(world:World, ?radius:Float):Entity;
	static function CreateModel(world:World):Model;
	static function CreateMesh(world:World):Mesh;

	// --- Light factories ---
	static function CreateBoxLight(world:World):Light;
	static function CreateDirectionalLight(world:World):Light;
	static function CreatePointLight(world:World):Light;
	static function CreateSpotLight(world:World):Light;

	// --- Camera ---
	static function CreateCamera(world:World, ?projection:Int):Camera;

	// --- Terrain ---
	@:overload(function(world:World, resolution:IVec2):Terrain
	{
	})
	static function CreateTerrain(world:World, width:Int, height:Int):Terrain;

	// --- Particle emitter ---
	static function CreateParticleEmitter(world:World, ?particles:Int):ParticleEmitter;

	// --- Collider factories ---
	static function CreateBoxCollider(?x:Float, ?y:Float, ?z:Float):Collider;
	static function CreateSphereCollider(?radius:Float):Collider;
	static function CreateCapsuleCollider(?radius:Float, ?height:Float):Collider;
	static function CreateCylinderCollider(?radius:Float, ?height:Float):Collider;
	static function CreateConeCollider(?radius:Float, ?height:Float):Collider;
	static function CreateConvexHullCollider(model:Model):Collider;
	static function CreateCompoundCollider():Collider;
	static function CreateMeshCollider(model:Model):Collider;

	// --- Joint factories ---
	static function CreateBallAndSocketJoint(entity0:Entity, entity1:Entity, ?worldPosition:Vec3):Joint;
	static function CreateHingeJoint(entity0:Entity, entity1:Entity, ?worldPosition:Vec3, ?axis:Vec3):Joint;
	static function CreateKinematicJoint(entity0:Entity, entity1:Entity, ?worldPosition:Vec3):Joint;
	static function CreatePlaneJoint(entity0:Entity, entity1:Entity, ?worldPosition:Vec3, ?axis:Vec3):Joint;
	static function CreateSliderJoint(entity0:Entity, entity1:Entity, ?worldPosition:Vec3, ?axis:Vec3):Joint;

	// --- Nav ---
	static function CreateNavMesh(world:World, height:Float, tilesx:Int, tilesz:Int, ?tileres:Int, ?voxelsize:Float, ?agentradius:Float, ?agentheight:Float,
		?stepheight:Float, ?maxslope:Float):NavMesh;
	static function CreateNavAgent(navmesh:NavMesh, ?radius:Float, ?height:Float):NavAgent;

	// --- Window / Framebuffer / Display ---
	static function CreateWindow(title:String, x:Int, y:Int, w:Int, h:Int, display:Dynamic, flags:Int):Window;
	static function CreateFramebuffer(window:Window):Framebuffer;
	static function GetDisplays():Array<Display>;
	static function ActiveWindow():Window;
	static function TransformCoord(x:Float, y:Float, from:Window, to:Window):Dynamic;

	// --- Loaders ---
	@:overload(function(world:World, path:String, ?flags:Int):Model
	{
	})
	@:overload(function(stream:Stream, ?flags:Int):Model
	{
	})
	static function LoadModel(worldOrStream:Dynamic, pathOrFlags:Dynamic, ?flags:Int):Model;
	@:overload(function(path:String, ?flags:Int):Sound
	{
	})
	@:overload(function(stream:Stream, ?flags:Int):Sound
	{
	})
	static function LoadSound(pathOrStream:Dynamic, ?flags:Int):Sound;
	static function LoadTexture(path:String, ?flags:Int):Texture;
	static function LoadFont(path:String, ?flags:Int):Font;
	static function LoadMaterial(path:String, ?flags:Int):Material;
	@:overload(function(world:World, path:String, ?flags:Int, ?extra:Dynamic):Scene
	{
	})
	@:overload(function(world:World, stream:Stream, ?flags:Int, ?extra:Dynamic):Scene
	{
	})
	static function LoadScene(world:World, pathOrStream:Dynamic, ?flags:Int, ?extra:Dynamic):Scene;
	static function LoadMap(world:World, path:String):Dynamic;

	// --- Brush factories ---
	static function CreateBrush(world:World):Brush;
	static function CreateBoxBrush(world:World, width:Float, height:Float, depth:Float):Brush;

	// --- Buffer factories ---
	static function CreateBuffer(size:Int):Buffer;
	static function CreateStaticBuffer(data:Dynamic, size:Int):Buffer;
	static function LoadBuffer(path:String, ?flags:Int):Buffer;
	static function CreateBufferStream(?data:Buffer, ?path:String):BufferStream;

	// --- Asset browser ---
	static function CreateAssetBrowser(?parent:Widget):AssetBrowser;

	// --- Materials / Speaker / Sprite / Texture ---
	static function CreateMaterial():Material;
	static function CreateSpeaker(?sound:Sound):Speaker;
	static function CreateSprite(world:World, a:Dynamic, b:Dynamic, ?c:Dynamic, ?d:Dynamic):Entity;
	static function CreateTexture(?type:Int, ?width:Int, ?height:Int, ?depth:Int, ?format:Int):Texture;
	static function CreatePixmap(width:Int, height:Int, ?format:Int, ?pixeldata:Buffer):Pixmap;
	@:overload(function(path:String, ?flags:Int):Pixmap
	{
	})
	@:overload(function(stream:Stream, ?flags:Int):Pixmap
	{
	})
	static function LoadPixmap(pathOrStream:Dynamic, ?flags:Int):Pixmap;
	static function LoadAudioFilter(path:String, ?flags:Int):AudioFilter;
	static function CreatePackage(path:String):Package;
	static function LoadPackage(path:String, ?flags:Int):Package;

	// --- Client / Server / Networking ---
	static function CreateClient(host:String, port:Int = 8888):Client;
	static function CreateServer(port:Int):Server;

	// --- Timer ---
	static function CreateTimer(frequency:Int):Timer;

	// --- Decal / Probe ---
	static function CreateDecal(world:World):Decal;
	static function CreateProbe(world:World):Probe;

	// --- TextureBuffer ---
	static function CreateTextureBuffer(width:Int, height:Int, colorattachments:Int = 1, depthattachment:Bool = false, samples:Int = 0):TextureBuffer;

	// --- Sprite / Tile ---
	@:overload(function(world:World, path:String, ?flags:Int):Sprite
	{
	})
	@:overload(function(world:World, stream:Stream, ?flags:Int):Sprite
	{
	})
	static function LoadSprite(world:World, pathOrStream:Dynamic, ?flags:Int):Sprite;

	@:overload(function(camera:Camera, width:Float, height:Float, wireframe:Bool = false):Tile
	{
	})
	@:overload(function(camera:Camera, size:Vec2, wireframe:Bool = false):Tile
	{
	})
	@:overload(function(camera:Camera, font:Font, text:String, fontsize:Int = 14, alignment:Int = 0, linespacing:Float = 1.5):Tile
	{
	})
	@:overload(function(world:World, width:Float, height:Float, wireframe:Bool = false):Tile
	{
	})
	@:overload(function(world:World, size:Vec2, wireframe:Bool = false):Tile
	{
	})
	@:overload(function(world:World, font:Font, text:String, fontsize:Int = 14, alignment:Int = 0, linespacing:Float = 1.5):Tile
	{
	})
	static function CreateTile(cameraOrWorld:Dynamic, arg1:Dynamic, arg2:Dynamic, ?arg3:Dynamic, ?arg4:Dynamic, ?arg5:Dynamic, ?arg6:Dynamic):Tile;

	@:overload(function(camera:Camera, path:String, ?flags:Int):Tile
	{
	})
	@:overload(function(world:World, path:String, ?flags:Int):Tile
	{
	})
	static function LoadTile(cameraOrWorld:Dynamic, path:String, ?flags:Int):Tile;

	// --- Plugin / PostEffect / Prefab ---
	static function LoadPlugin(path:String):Dynamic;
	static function LoadPostEffect(path:String, ?flags:Int):Dynamic;
	static function LoadPrefab(world:World, path:String, ?flags:Int, ?extra:Dynamic):Entity;

	// --- GUI ---
	static function CreateInterface(windowOrCamera:Dynamic, ?font:Font, ?size:IVec2):Interface;
	static function CreateButton(text:String, x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateComboBox(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateLabel(text:String, x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateListBox(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateMenu(text:String, parent:Widget):Widget;
	static function CreatePanel(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateProgressBar(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateSlider(x:Int, y:Int, w:Int, h:Int, parent:Widget, ?orientation:Int):Widget;
	static function CreateTextArea(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateTextField(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;
	static function CreateTreeView(x:Int, y:Int, w:Int, h:Int, parent:Widget):Widget;

	// --- Stream ---
	static function OpenFile(path:String):Stream;
	static function ReadFile(path:String):Stream;
	static function WriteFile(path:String):Stream;

	// --- Scripting ---
	static function RunScript(path:String):Void;
	static function ExecuteString(source:String):Bool;
	static function CallFunction(name:Dynamic, args:Dynamic, ?results:Dynamic):Dynamic;
	static function CallMethod(obj:Dynamic, name:String, ?args:Dynamic, ?returnvalues:Dynamic):Dynamic;
	static function SetGlobal(name:String, value:Dynamic):Void;
	static function GetGlobal(name:String):Dynamic;

	// --- Color ---
	static function Rgba(r:Int, g:Int, b:Int, ?a:Int):Int;
	static function Red(rgba:Int):Int;
	static function Green(rgba:Int):Int;
	static function Blue(rgba:Int):Int;
	static function Alpha(rgba:Int):Int;

	// --- Multithreading (Ultra Engine only; NOT available in Leadwerks 5 Lua) ---
	static function CreateMutex():Mutex;
	static function CreateSemaphore():Semaphore;
	@:overload(function(func:Void->Void, ?start:Bool):Thread
	{
	})
	@:overload(function(func:Dynamic->Void, extra:Dynamic, ?start:Bool):Thread
	{
	})
	static function CreateThread(func:Void->Void, ?extra:Dynamic, ?start:Bool):Thread;
	static function MaxThreads():Int;

	// --- Math ---
	static function Random(?lo:Float, ?hi:Float):Float;
	static function Round(x:Float):Float;
	static function Sqrt(x:Float):Float;
	static function Abs(x:Float):Float;
	static function Clamp(value:Float, min:Float, max:Float):Float;
	static function Mix(a:Float, b:Float, t:Float):Float;
	static function MoveTowards(current:Float, target:Float, maxDelta:Float):Float;
	static function Cos(degrees:Float):Float;
	static function Sin(degrees:Float):Float;
	static function Tan(radians:Float):Float;
	static function ACos(value:Float):Float;
	static function ASin(value:Float):Float;
	static function ATan2(y:Float, x:Float):Float;
	static function Millisecs():Int;
	static function Min(a:Float, b:Float):Float;
	static function Max(a:Float, b:Float):Float;
	static function Floor(x:Float):Float;
	static function Ceil(x:Float):Float;
	static function Mod(a:Float, b:Float):Float;
	static function Sign(x:Float):Float;

	// --- I/O ---
	static function Print(msg:String):Void;
	static function Notify(msg:String, ?title:String, ?quit:Bool):Void;

	// --- Events ---
	static function EmitEvent(eventId:Int, ?source:Dynamic, ?extra:Dynamic):Void;
	static function ListenEvent(eventId:Int, source:Dynamic, handler:Dynamic, ?extra:Dynamic):Void;
	static function WaitEvent():Dynamic;
	static function PeekEvent():Bool;
	static function Sleep(milliseconds:Int):Void;

	// --- Constructors (global Lua functions) ---
	@:native("iVec2") static function IVec2(x:Int, y:Int):IVec2;
	@:native("iVec3") static function IVec3(x:Int, y:Int, z:Int):IVec3;
	@:native("iVec4") static function IVec4(x:Int, y:Int, z:Int, w:Int):IVec4;
	static function Vec3(x:Float, y:Float, z:Float):Vec3;
	static function Vec2(x:Float, y:Float):Vec2;
	static function Vec4(x:Float, y:Float, z:Float, w:Float):Vec4;
	static function Aabb(min:Vec3, max:Vec3):AabbBounds;
	static function Mat4(?a:Dynamic, ?b:Dynamic, ?c:Dynamic, ?d:Dynamic):Mat4;
	static function Quat(x:Float, y:Float, z:Float, w:Float):Quat;
	@:overload(function(point:Vec3, normal:Vec3):Plane
	{
	})
	@:overload(function(a:Vec3, b:Vec3, c:Vec3):Plane
	{
	})
	static function Plane(x:Float, y:Float, z:Float, d:Float):Plane;
	static function PickInfo():PickInfo;

	// --- Window flags ---
	static var WINDOW_CENTER:Int;
	static var WINDOW_TITLEBAR:Int;
	static var WINDOW_BORDERLESS:Int;
	static var WINDOW_RESIZABLE:Int;

	// --- Keyboard ---
	static var KEY_ESCAPE:Int;
	static var KEY_SPACE:Int;
	static var KEY_UP:Int;
	static var KEY_DOWN:Int;
	static var KEY_LEFT:Int;
	static var KEY_RIGHT:Int;
	static var KEY_SHIFT:Int;
	static var KEY_CONTROL:Int;
	static var KEY_ALT:Int;
	static var KEY_TAB:Int;
	static var KEY_ENTER:Int;
	static var KEY_BACKSPACE:Int;
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
	static var KEY_T:Int;
	static var KEY_Y:Int;
	static var KEY_U:Int;
	static var KEY_I:Int;
	static var KEY_O:Int;
	static var KEY_P:Int;
	static var KEY_H:Int;
	static var KEY_J:Int;
	static var KEY_K:Int;
	static var KEY_L:Int;
	static var KEY_Z:Int;
	static var KEY_X:Int;
	static var KEY_V:Int;
	static var KEY_B:Int;
	static var KEY_N:Int;
	static var KEY_M:Int;
	static var KEY_1:Int;
	static var KEY_2:Int;
	static var KEY_3:Int;
	static var KEY_4:Int;
	static var KEY_5:Int;
	static var KEY_6:Int;
	static var KEY_7:Int;
	static var KEY_8:Int;
	static var KEY_9:Int;
	static var KEY_0:Int;

	// --- Mouse ---
	static var MOUSE_LEFT:Int;
	static var MOUSE_RIGHT:Int;
	static var MOUSE_MIDDLE:Int;

	// --- Events ---
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
	static var EVENT_STARTRENDERER:Int;
	static var EVENT_WINDOWCLOSE:Int;
	static var EVENT_WINDOWSIZE:Int;
	static var EVENT_WINDOWPAINT:Int;
	static var EVENT_WINDOWACCEPT:Int;
	static var EVENT_WINDOWMOVE:Int;
	static var EVENT_WINDOWSELECT:Int;
	static var EVENT_WINDOWDESELECT:Int;
	static var EVENT_WINDOWDRAGBEGIN:Int;
	static var EVENT_WINDOWDRAGEND:Int;
	static var EVENT_WINDOWDPICHANGE:Int;
	static var EVENT_KEYCHAR:Int;
	static var EVENT_KEYREPEAT:Int;
	static var EVENT_DOUBLECLICK:Int;
	static var EVENT_TRIPLECLICK:Int;
	static var EVENT_TIMERTICK:Int;
	static var EVENT_WIDGETSELECT:Int;
	static var EVENT_WIDGETDESELECT:Int;
	static var EVENT_WIDGETOPEN:Int;
	static var EVENT_WIDGETCLOSE:Int;
	static var EVENT_WIDGETMENU:Int;
	static var EVENT_WIDGETGAINFOCUS:Int;
	static var EVENT_WIDGETLOSEFOCUS:Int;
	static var EVENT_WIDGETDROP:Int;
	static var EVENT_ZOOM:Int;

	// --- Physics modes ---
	static var PHYSICS_NONE:Int;
	static var PHYSICS_RIGIDBODY:Int;
	static var PHYSICS_PLAYER:Int;
	static var PHYSICS_DISABLED:Int;
	static var PHYSICS_CHARACTER:Int;

	// --- Collision types ---
	static var COLLISION_NONE:Int;
	static var COLLISION_PROP:Int;
	static var COLLISION_SCENE:Int;
	static var COLLISION_PLAYER:Int;
	static var COLLISION_TRIGGER:Int;
	static var COLLISION_DEBRIS:Int;
	static var COLLISION_PROJECTILE:Int;

	// --- Collision responses ---
	static var COLLISIONRESPONSE_NONE:Int;
	static var COLLISIONRESPONSE_COLLIDE:Int;
	static var COLLISIONRESPONSE_DETECT:Int;

	// --- Picking ---
	static var PICK_NONE:Int;
	static var PICK_MESH:Int;
	static var PICK_AABB:Int;
	static var PICK_CIRCLE:Int;
	static var PICK_SPHERE:Int;
	static var PICK_CAPSULE:Int;
	static var PICK_CYLINDER:Int;
	static var PICK_CONE:Int;
	static var PICK_PLANE:Int;

	// --- Bounds modes ---
	static var BOUNDS_LOCAL:Int;
	static var BOUNDS_GLOBAL:Int;
	static var BOUNDS_RECURSIVE:Int;
	static var BOUNDS_ALL:Int;

	// --- Environment map ---
	static var ENVIRONMENTMAP_BACKGROUND:Int;
	static var ENVIRONMENTMAP_SPECULAR:Int;
	static var ENVIRONMENTMAP_DIFFUSE:Int;

	// --- Projection ---
	static var PROJECTION_PERSPECTIVE:Int;
	static var PROJECTION_ORTHOGRAPHIC:Int;

	// --- Cursors ---
	static var CURSOR_DEFAULT:Int;
	static var CURSOR_TEXTINPUT:Int;
	static var CURSOR_HAND:Int;
	static var CURSOR_CROSS:Int;

	// --- Clear mode ---
	static var CLEAR_COLOR:Int;
	static var CLEAR_DEPTH:Int;

	// --- Blend modes ---
	static var BLEND_SOLID:Int;
	static var BLEND_ALPHA:Int;
	static var BLEND_MASK:Int;

	// --- Save flags ---
	static var SAVE_DEFAULT:Int;
	static var SAVE_SCENE:Int;
	static var SAVE_ENTITY:Int;

	// --- Network messages ---
	static var MESSAGE_CONNECT:Int;
	static var MESSAGE_DISCONNECT:Int;
	static var MESSAGE_DATA:Int;

	// --- Sprite view modes ---
	static var VIEWMODE_ORBIT:Int;
	static var VIEWMODE_PIVOT:Int;
	static var VIEWMODE_SCREEN:Int;
	static var VIEWMODE_CAMERA:Int;

	// --- Cubemap sides ---
	static var CUBEMAP_POSITIVEX:Int;
	static var CUBEMAP_NEGATIVEX:Int;
	static var CUBEMAP_POSITIVEY:Int;
	static var CUBEMAP_NEGATIVEY:Int;
	static var CUBEMAP_POSITIVEZ:Int;
	static var CUBEMAP_NEGATIVEZ:Int;

	// --- Texture slots ---
	static var TEXTURE_BASE:Int;
	static var TEXTURE_NORMAL:Int;
	static var TEXTURE_SPECULAR:Int;
	static var TEXTURE_EMISSIVE:Int;
	static var TEXTURE_DISPLACEMENT:Int;

	// --- Load flags ---
	static var LOAD_DEFAULT:Int;
	static var LOAD_UNMANAGED:Int;
	static var LOAD_QUIET:Int;
	static var LOAD_NO_CACHE:Int;
	static var LOAD_DUMP_INFO:Int;
	static var LOAD_NO_OVERRIDE:Int;

	// --- Mesh types ---
	static var MESH_TRIANGLES:Int;
	static var MESH_QUADS:Int;

	// --- Animation / playback ---
	static var PLAYBACK_ONCE:Int;
	static var PLAYBACK_LOOP:Int;
	static var PLAYBACK_PINGPONG:Int;
	static var PLAYBACK_ONCEFORWARD:Int;

	// --- Steam Lobby type ---
	static var LOBBYTYPE_PUBLIC:Int;
	static var LOBBYTYPE_FRIENDS_ONLY:Int;
	static var LOBBYTYPE_PRIVATE:Int;

	// --- Speaker state ---
	static var SPEAKER_STOPPED:Int;
	static var SPEAKER_PLAYING:Int;
	static var SPEAKER_PAUSED:Int;

	// --- Thread state (Ultra Engine only) ---
	static var THREAD_READY:Int;
	static var THREAD_RUNNING:Int;
	static var THREAD_FINISHED:Int;

	// --- Network send ---
	static var SENDTYPE_UNRELIABLE:Int;
	static var SENDTYPE_RELIABLE:Int;

	// --- Set by generated entity scripts ---
	static var _hxwerks_self_:Entity;
	static var _hxwerks_:Dynamic;
}

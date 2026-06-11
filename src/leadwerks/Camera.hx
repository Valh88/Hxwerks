package leadwerks;

import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

@:native("_G")
extern class Camera extends Entity
{
	// --- FOV / Range / Zoom ---
	function SetFov(fov:Float):Void;
	function GetFov():Float;
	function SetRange(near:Float, far:Float):Void;
	function GetRange():Dynamic;
	function SetZoom(zoom:Float):Void;
	function GetZoom():Float;

	// --- Clear ---
	function SetClearColor(color:Float):Void;
	function SetClearMode(mode:Int):Void;

	// --- Projection ---
	function SetProjectionMode(mode:Int):Void;
	function GetProjectionMode():Int;

	// --- Fog ---
	function SetFog(mode:Int):Void;
	function GetFog():Int;
	function SetFogAngle(angle:Float):Void;
	function GetFogAngle():Float;
	function SetFogColor(color:Vec3):Void;
	function GetFogColor():Vec3;
	function SetFogRange(near:Float, far:Float):Void;
	function GetFogRange():Dynamic;

	// --- Picking ---
	function Pick(framebuffer:Framebuffer, x:Float, y:Float, ?z:Float, ?recursive:Bool):PickInfo;

	// --- Coordinate transforms ---
	function ScreenToWorld(screenx:Float, screeny:Float, screenz:Float):Vec3;
	function WorldToScreen(worldpos:Vec3):Dynamic;

	// --- Render ---
	function Render():Void;

	// --- Post-processing ---
	function AddPostEffect(pathOrTable:Dynamic):Void;
	function ClearPostEffects():Void;
	function SetUniform(name:String, value:Dynamic):Void;

	// --- Modes ---
	function SetMouseLook(mode:Bool):Void;
	function SetMsaa(mode:Int):Void;
	function SetOrder(order:Int):Void;
	function SetRealtime(realtime:Bool):Void;
	function SetRefraction(enabled:Bool):Void;
	function SetRenderTarget(texture:Dynamic):Void;
	function SetSweptCulling(mode:Bool):Void;
	function SetSsr(mode:Bool):Void;
	function SetTessellation(density:Float):Void;
	function SetDepthPrepass(mode:Bool):Void;
	function SetBackfaceCulling(mode:Bool):Void;
}

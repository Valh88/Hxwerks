package leadwerks;

#if lua

import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

@:native("_G")
extern class Camera extends Entity
{
	function SetFov(fov:Float):Void;
	function SetClearColor(color:Float):Void;
	function Pick(framebuffer:Framebuffer, x:Float, y:Float, ?z:Float, ?recursive:Bool):PickInfo;
}

#elseif cpp

import leadwerks.CppBridge;
import leadwerks.support.CppPick;
import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

/** Boxed camera entity (`CreateCamera`). Same pointer type as `Entity`; use `cast` to call `Entity` API. **/
abstract Camera(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	@:from
	static inline function fromEntity(e:Entity):Camera
		return cast e.toRaw();

	public inline function SetFov(fov:Float):Void
		CppBridge.camera_set_fov(toRaw(), fov);

	public inline function SetClearColor(color:Float):Void
		CppBridge.camera_set_clear_color(toRaw(), color);

	public inline function SetRotation(rot:Vec3):Void
		CppBridge.camera_set_rotation(toRaw(), rot.x, rot.y, rot.z);

	public inline function Move(x:Float, y:Float, z:Float):Void
		CppBridge.camera_move(toRaw(), x, y, z);

	public function Pick(framebuffer:Framebuffer, x:Float, y:Float, ?z:Float = 0.0, ?recursive:Bool = false):PickInfo
	{
		var r = CppBridge.camera_pick(toRaw(), framebuffer.toRaw(), x, y, z, recursive ? 1 : 0);
		return CppPick.pickFromNative(r);
	}
}

#end

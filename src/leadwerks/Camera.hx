package leadwerks;

import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

@:native("_G")
extern class Camera extends Entity
{
	function SetFov(fov:Float):Void;
	function SetClearColor(color:Float):Void;
	function SetRotation(rot:Vec3):Void;
	function Pick(framebuffer:Framebuffer, x:Float, y:Float, ?z:Float, ?recursive:Bool):PickInfo;
}

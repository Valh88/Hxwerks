package leadwerks;

#if lua

import leadwerks.types.Vec3;

@:native("_G")
extern class NavAgent
{
	function SetPosition(pos:Vec3):Void;
	function GetPosition(?global:Bool):Vec3;
	function Navigate(dest:Vec3):Bool;
}

#elseif cpp

import leadwerks.CppBridge;
import leadwerks.types.Vec3;

/** Boxed `std::shared_ptr<Leadwerks::NavAgent>`. Release with `Globals.ReleaseNavAgent`. **/
abstract NavAgent(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	public function SetPosition(pos:Vec3):Void
		CppBridge.nav_agent_set_position(toRaw(), pos.x, pos.y, pos.z);

	public function GetPosition(?global:Bool = false):Vec3
	{
		var v = CppBridge.nav_agent_get_position(toRaw(), global ? 1 : 0);
		return new Vec3(v.x, v.y, v.z);
	}

	public function Navigate(dest:Vec3):Bool
		return CppBridge.nav_agent_navigate(toRaw(), dest.x, dest.y, dest.z) != 0;
}

#end

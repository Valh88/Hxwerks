package leadwerks;

#if lua

import leadwerks.types.Vec3;

@:native("_G")
extern class NavMesh
{
	function Build():Void;
	function RandomPoint():Vec3;
	function SetDebugging(enabled:Bool):Void;
}

#elseif cpp

import leadwerks.CppBridge;
import leadwerks.types.Vec3;

/** Boxed `std::shared_ptr<Leadwerks::NavMesh>`. Release with `Globals.ReleaseNavMesh`. **/
abstract NavMesh(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	public inline function Build():Void
		CppBridge.navmesh_build(toRaw());

	public function RandomPoint():Vec3
	{
		var v = CppBridge.navmesh_random_point(toRaw());
		return new Vec3(v.x, v.y, v.z);
	}

	public inline function SetDebugging(enabled:Bool):Void
		CppBridge.navmesh_set_debugging(toRaw(), enabled ? 1 : 0);
}

#end

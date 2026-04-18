package leadwerks.support;

#if cpp
import leadwerks.CppBridge.HxwerksPickResultNative;
import leadwerks.CppBridge.HxwerksVec3Native;
import leadwerks.Entity;
import leadwerks.types.PickInfo;
import leadwerks.types.Vec3;

class CppPick
{
	public static inline function vec3FromNative(v:HxwerksVec3Native):Vec3
		return new Vec3(v.x, v.y, v.z);

	public static function pickFromNative(n:HxwerksPickResultNative):PickInfo
		return {
			success: n.success != 0,
			entity: n.entity == null ? null : new Entity(n.entity),
			position: vec3FromNative(n.position),
		};
}
#end

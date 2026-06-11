package leadwerks.types;

@:forward
abstract Quat(Dynamic) from Dynamic to Dynamic
{
	public inline function new(x:Float, y:Float, z:Float, w:Float)
		this = untyped __lua__("Quat({0}, {1}, {2}, {3})", x, y, z, w);

	public inline function Inverse():Quat
		return untyped __lua__("({0}):Inverse()", this);

	public inline function Normalize():Quat
		return untyped __lua__("({0}):Normalize()", this);

	public inline function Slerp(dest:Quat, t:Float):Quat
		return untyped __lua__("({0}):Slerp({1}, {2})", this, dest, t);

	public inline function ToEuler():Vec3
		return untyped __lua__("({0}):ToEuler()", this);
}

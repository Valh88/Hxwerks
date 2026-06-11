package leadwerks.types;

/**
	4-component vector (color/position) from Leadwerks API.
**/
@:forward
abstract Vec4(Dynamic) from Dynamic to Dynamic
{
	public inline function new(x:Float, y:Float, z:Float, w:Float = 1)
		this = untyped __lua__("Vec4({0}, {1}, {2}, {3})", x, y, z, w);

	public static inline function splat(n:Float):Vec4
		return new Vec4(n, n, n, n);
}

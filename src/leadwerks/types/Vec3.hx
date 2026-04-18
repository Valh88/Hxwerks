package leadwerks.types;

#if lua

import leadwerks.Globals;

/**
	Thin wrapper for Leadwerks `Vec3` userdata; used for typed `@property` defaults in entity scripts.
**/
@:forward
abstract Vec3(Dynamic) from Dynamic to Dynamic
{
	public inline function new(x:Float, y:Float, z:Float)
		this = Globals.Vec3(x, y, z);

	public static inline function splat(n:Float):Vec3
		return new Vec3(n, n, n);

	public static inline function zero():Vec3
		return new Vec3(0, 0, 0);

	@:from
	static function fromFloat(n:Float):Vec3
		return splat(n);
}

#elseif cpp

/** Simple 3-vector for native builds (no Lua userdata). **/
class Vec3
{
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public function new(x:Float, y:Float, z:Float)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public static inline function splat(n:Float):Vec3
		return new Vec3(n, n, n);

	public static inline function zero():Vec3
		return new Vec3(0, 0, 0);
}

#end

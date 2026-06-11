package leadwerks.types;

import leadwerks.Globals;

/**
	2D vector from Leadwerks API (Vec2).
**/
@:forward
abstract Vec2(Dynamic) from Dynamic to Dynamic
{
	public inline function new(x:Float, y:Float)
		this = Globals.Vec2(x, y);

	public static inline function splat(n:Float):Vec2
		return new Vec2(n, n);

	/** Returns the length (magnitude) of the vector. **/
	public inline function Length():Float
		return Globals.Sqrt(this.x * this.x + this.y * this.y);

	/** Returns a normalized copy of this vector (length = 1). **/
	public inline function Normalize():Vec2
	{
		var len = this.Length();
		if (len == 0.0)
			return new Vec2(0, 0);
		return new Vec2(this.x / len, this.y / len);
	}
}

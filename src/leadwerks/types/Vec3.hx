package leadwerks.types;

@:forward
extern abstract Vec3(Vec3Data) from Vec3Data to Vec3Data
{
	@:op(a + b)
	private static inline function _add(a:Vec3, b:Vec3):Vec3
	{
		return cast (untyped __lua__("({0}) + ({1})", a, b));
	}

	@:op(a - b)
	private static inline function _sub(a:Vec3, b:Vec3):Vec3
	{
		return cast (untyped __lua__("({0}) - ({1})", a, b));
	}

	@:op(-b)
	private static inline function _neg(a:Vec3):Vec3
	{
		return cast (untyped __lua__("-({0})", a));
	}

	@:op(a * b) @:commutative
	private static inline function _mulScalar(a:Vec3, b:Float):Vec3
	{
		return cast (untyped __lua__("({0}) * ({1})", a, b));
	}

	@:op(a / b)
	private static inline function _divScalar(a:Vec3, b:Float):Vec3
	{
		return cast (untyped __lua__("({0}) / ({1})", a, b));
	}

	@:op(a * b)
	private static inline function _mul(a:Vec3, b:Vec3):Vec3
	{
		return cast (untyped __lua__("({0}) * ({1})", a, b));
	}
}

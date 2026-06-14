package leadwerks.types;

@:forward
extern abstract Vec2(Vec2Data) from Vec2Data to Vec2Data
{
	@:op(a + b)
	private static inline function _add(a:Vec2, b:Vec2):Vec2
	{
		return cast (untyped __lua__("({0}) + ({1})", a, b));
	}

	@:op(a - b)
	private static inline function _sub(a:Vec2, b:Vec2):Vec2
	{
		return cast (untyped __lua__("({0}) - ({1})", a, b));
	}

	@:op(-b)
	private static inline function _neg(a:Vec2):Vec2
	{
		return cast (untyped __lua__("-({0})", a));
	}

	@:op(a * b) @:commutative
	private static inline function _mulScalar(a:Vec2, b:Float):Vec2
	{
		return cast (untyped __lua__("({0}) * ({1})", a, b));
	}

	@:op(a / b)
	private static inline function _divScalar(a:Vec2, b:Float):Vec2
	{
		return cast (untyped __lua__("({0}) / ({1})", a, b));
	}

	@:op(a * b)
	private static inline function _mul(a:Vec2, b:Vec2):Vec2
	{
		return cast (untyped __lua__("({0}) * ({1})", a, b));
	}
}

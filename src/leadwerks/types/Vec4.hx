package leadwerks.types;

@:forward
extern abstract Vec4(Vec4Data) from Vec4Data to Vec4Data
{
	@:op(a + b)
	private static inline function _add(a:Vec4, b:Vec4):Vec4
	{
		return cast(untyped __lua__("({0}) + ({1})", a, b));
	}

	@:op(a - b)
	private static inline function _sub(a:Vec4, b:Vec4):Vec4
	{
		return cast(untyped __lua__("({0}) - ({1})", a, b));
	}

	@:op(-b)
	private static inline function _neg(a:Vec4):Vec4
	{
		return cast(untyped __lua__("-({0})", a));
	}

	@:op(a * b) @:commutative
	private static inline function _mulScalar(a:Vec4, b:Float):Vec4
	{
		return cast(untyped __lua__("({0}) * ({1})", a, b));
	}

	@:op(a / b)
	private static inline function _divScalar(a:Vec4, b:Float):Vec4
	{
		return cast(untyped __lua__("({0}) / ({1})", a, b));
	}

	@:op(a * b)
	private static inline function _mul(a:Vec4, b:Vec4):Vec4
	{
		return cast(untyped __lua__("({0}) * ({1})", a, b));
	}
}

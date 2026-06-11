package leadwerks.types;

@:forward
abstract Mat4(Dynamic) from Dynamic to Dynamic
{
	public inline function new(?a:Dynamic, ?b:Dynamic, ?c:Dynamic, ?d:Dynamic)
		this = untyped __lua__("Mat4({0}, {1}, {2}, {3})", a, b, c, d);

	public inline function Inverse():Mat4
		return untyped __lua__("({0}):Inverse()", this);

	public inline function Determinant():Float
		return untyped __lua__("({0}):Determinant()", this);

	public inline function Transpose():Mat4
		return untyped __lua__("({0}):Transpose()", this);

	public inline function Normalize():Mat4
		return untyped __lua__("({0}):Normalize()", this);

	public inline function GetTranslation():Vec3
		return untyped __lua__("({0}):GetTranslation()", this);

	public inline function GetRotation():Vec3
		return untyped __lua__("({0}):GetRotation()", this);

	public inline function GetScale():Vec3
		return untyped __lua__("({0}):GetScale()", this);

	public inline function GetQuaternion():Dynamic
		return untyped __lua__("({0}):GetQuaternion()", this);
}

package leadwerks.types;

@:native("_G")
extern class Plane
{
	var x:Float;
	var y:Float;
	var z:Float;
	var d:Float;

	@:overload(function(point:Vec3, normal:Vec3):Void
	{
	})
	@:overload(function(a:Vec3, b:Vec3, c:Vec3):Void
	{
	})
	function new(x:Float, y:Float, z:Float, d:Float);

	@:overload(function(point:Vec3):Float
	{
	})
	function DistanceToPoint(x:Float, y:Float, z:Float):Float;

	function IntersectsLine(p0:Vec3, p1:Vec3, result:Vec3, ?twosided:Bool, ?infinite:Bool):Bool;
}

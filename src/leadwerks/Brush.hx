package leadwerks;

import leadwerks.types.Vec3;
import leadwerks.types.Plane;

@:native("_G")
extern class Brush extends Entity
{
	var faces:Array<Face>;

	@:overload(function(?material:Material):Face
	{
	})
	function AddFace(?material:Material):Face;

	@:overload(function(position:Vec3):Int
	{
	})
	function AddVertex(x:Float, y:Float, z:Float):Int;

	function Build():Void;
	function IntersectsBrush(brush:Brush):Bool;
	function IntersectsPoint(point:Vec3, ?padding:Float):Bool;

	@:overload(function(v:Int, position:Vec3):Void
	{
	})
	function SetVertexPosition(v:Int, x:Float, y:Float, z:Float):Void;

	function Slice(plane:Plane, operandA:Brush, operandB:Brush, ?sliceface:Face, ?tolerance:Float):Bool;
}

package leadwerks;

import leadwerks.types.AabbBounds;
import leadwerks.types.Mat4;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.types.Vec4;

@:native("_G")
extern class Mesh extends Object
{
	var bounds:AabbBounds;
	var extra:Dynamic;
	var material:Material;
	var materials:Array<Material>;
	var name:String;
	var type:Int;

	function AddPrimitive(type:Int):Void;

	@:overload(function(position:Vec3):Int
	{
	})
	function AddVertex(x:Float, y:Float, z:Float):Int;

	function Copy():Mesh;
	function CountPrimitives():Int;
	function CountVertices():Int;
	function GetPrimitiveAttributes(index:Int):Dynamic;
	function GetRenderLayers():Int;
	function GetSkinned():Bool;
	function GetVertexColor(index:Int):Vec4;
	function GetVertexPosition(index:Int):Vec3;
	function GetVertexNormal(index:Int):Vec3;
	function GetVertexTexCoords(index:Int, set:Int):Vec2;
	function Modify(type:Int, positions:Buffer, normals:Buffer, texcoords:Buffer, colors:Buffer, indices:Buffer):Void;
	function Recenter(?x:Bool, ?y:Bool, ?z:Bool):Void;
	function Rotate(angle:Float, x:Float, y:Float, z:Float):Void;
	function Scale(x:Float, y:Float, z:Float):Void;
	function SetMaterial(material:Material, ?layer:Int):Void;
	function SetRenderLayers(layers:Int):Void;
	function SetSkinned(skinned:Bool):Void;
	function SetVertexColor(index:Int, color:Vec4):Void;
	function SetVertexPosition(index:Int, position:Vec3):Void;
	function SetVertexNormal(index:Int, normal:Vec3):Void;
	function SetVertexTexCoords(index:Int, set:Int, coords:Vec2):Void;
	function Transform(matrix:Mat4):Void;
	function Translate(x:Float, y:Float, z:Float):Void;
	function UpdateBounds():Void;
	function UpdateNormals():Void;
	function UpdateTangents():Void;
}

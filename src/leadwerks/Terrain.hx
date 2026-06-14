package leadwerks;

import leadwerks.types.IVec2;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.types.Vec4;

@:native("_G")
extern class Terrain extends Entity
{
	var heightmap(default, null):Pixmap;
	var material(default, null):Material;
	var resolution(default, null):IVec2;

	function AddLayer(?material:Material):Int;
	function Fill(layer:Int):Void;
	function GetElevation(x:Int, y:Int):Float;
	function GetHeight(x:Int, y:Int):Float;
	function GetLayers(x:Int, y:Int):Int;
	function GetLayerWeight(layer:Int, x:Int, y:Int):Float;
	function GetLayerHeightConstraints(layer:Int):Vec4;
	function GetLayerMapping(layer:Int):Int;
	function GetLayerMaterial(layer:Int):Material;
	function GetLayerSlopeConstraints(layer:Int):Vec2;
	function GetNormal(x:Int, y:Int):Vec3;
	function GetSlope(x:Int, y:Int):Float;
	function GetTileHidden(tilex:Int, tilez:Int):Bool;
	function LoadHeightmap(path:String, ?flags:Int):Void;
	function SetHeight(x:Int, y:Int, height:Float):Void;
	function SetLayerHeightConstraints(layer:Int, constraints:Vec4):Void;
	function SetLayerMapping(layer:Int, mode:Int):Void;
	function SetLayerScale(layer:Int, scale:Float):Void;

	@:overload(function(layer:Int, scale:Vec2):Void
	{
	})
	function SetLayerSlopeConstraints(layer:Int, minSlope:Float, maxSlope:Float):Void;

	function SetLayerWeight(layer:Int, x:Int, y:Int, weight:Float):Void;
	function SetTileHidden(tilex:Int, tilez:Int, hidden:Bool):Void;
}

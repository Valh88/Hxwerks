package leadwerks;

import leadwerks.types.Vec2;
import leadwerks.types.Plane;

@:native("_G")
extern class Face extends Object
{
	var plane:Plane;

	function AddIndice(v:Int):Int;
	function GetMaterial():Material;
	function GetTextureMappingPlane(axis:Int):Plane;
	function GetTextureMappingRotation():Float;
	function GetTextureMappingScale():Vec2;
	function GetTextureMappingTranslation():Vec2;
	function SetMaterial(material:Material):Void;
	function SetTextureMappingPlane(plane:Plane, axis:Int):Void;
	function SetTextureMappingRotation(angle:Float):Void;

	@:overload(function(scale:Vec2):Void
	{
	})
	function SetTextureMappingScale(x:Float, y:Float):Void;

	@:overload(function(translation:Vec2):Void
	{
	})
	function SetTextureMappingTranslation(x:Float, y:Float):Void;
}

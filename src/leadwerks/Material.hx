package leadwerks;

import leadwerks.types.Vec4;

@:native("_G")
extern class Material extends Asset
{
	var color:Vec4;
	var textures:Array<Dynamic>;

	function GetColor():Vec4;
	function SetBlend(mode:Int):Void;
	function SetColor(r:Float, g:Float, b:Float, ?a:Float):Void;
	function GetMetalness():Float;
	function SetMetalness(metalness:Float):Void;
	function GetRoughness():Float;
	function SetRoughness(roughness:Float):Void;
	function GetShaderFamily():Int;
	function SetShaderFamily(family:Int):Void;
	function GetTexture(index:Int):Dynamic;
	function SetTexture(texture:Dynamic, slot:Int):Void;
	function GetTransparent():Bool;
	function SetTransparent(transparent:Bool):Void;
	function SetDisplacement(displacement:Float):Void;
	function SetTessellation(tessellation:Float):Void;
}

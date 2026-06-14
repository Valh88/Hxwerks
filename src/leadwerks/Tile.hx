package leadwerks;

import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.types.Vec4;

@:native("_G")
extern class Tile extends Object
{
	var color(default, null):Vec4;
	var position(default, null):Vec3;
	var rotation(default, null):Float;
	var scale(default, null):Vec2;
	var text(default, null):String;

	function GetColor():Vec4;
	function GetMaterial():Material;
	function GetOrder():Int;
	function GetPosition():Vec3;
	function GetRotation():Float;
	function GetScale():Vec2;
	function MidHandle():Void;
	function Move(x:Float, y:Float):Void;
	function SetColor(r:Float, g:Float, b:Float, ?a:Float):Void;
	function SetHandle(x:Float, y:Float):Void;
	function SetMaterial(material:Material):Void;
	function SetOrder(order:Int):Void;
	function SetPosition(x:Float, y:Float, ?z:Float):Void;
	function SetRotation(rotation:Float):Void;
	function SetScale(x:Float, y:Float):Void;
	function SetText(text:String, ?fontsize:Int, ?alignment:Int, ?linespacing:Float):Void;
	function Turn(rotation:Float):Void;
}

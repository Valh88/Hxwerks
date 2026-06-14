package leadwerks;

@:native("_G")
extern class Buffer extends Object
{
	function Clear():Void;
	function Copy(dest:Buffer):Void;
	function Data():Dynamic;
	function GetSize():Int;
	function Peek(offset:Int, typ:Dynamic):Dynamic;
	function PeekByte(offset:Int):Int;
	function PeekDouble(offset:Int):Float;
	function PeekInt(offset:Int):Int;
	function PeekFloat(offset:Int):Float;
	function PeekShort(offset:Int):Int;
	function PeekString(offset:Int):String;
	function Poke(offset:Int, value:Dynamic, typ:Dynamic):Void;
	function PokeByte(offset:Int, value:Int):Void;
	function PokeDouble(offset:Int, value:Float):Void;
	function PokeInt(offset:Int, value:Int):Void;
	function PokeFloat(offset:Int, value:Float):Void;
	function PokeShort(offset:Int, value:Int):Void;
	function PokeString(offset:Int, value:String):Void;
	function Resize(size:Int):Void;
	function Save(path:String):Bool;
}

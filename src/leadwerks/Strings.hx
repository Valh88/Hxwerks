package leadwerks;

@:native("_G")
extern class Strings
{
	static function Find(str:String, pattern:String):Int;
	static function Left(str:String, count:Int):String;
	static function Len(str:String):Int;
	static function Lower(str:String):String;
	static function Mid(str:String, start:Int, ?count:Int):String;
	static function Replace(str:String, find:String, replaceWith:String):String;
	static function Right(str:String, count:Int):String;
	static function Split(str:String, delimiter:String):Array<String>;
	static function StartsWith(str:String, prefix:String):Bool;
	static function Trim(str:String):String;
	static function Upper(str:String):String;
	static function Xor(str:String, key:Int):String;
	static function Uuid():String;
}

package leadwerks;

@:native("_G")
extern class Stream
{
	var path:String;
	@:native("package") var packageName:String;

	function Close():Void;
	function Eof():Bool;
	function Flush():Void;
	function GetPackage():String;
	function GetPosition():Int;
	function GetSize():Int;
	function Read(size:Int):String;
	function ReadByte():Int;
	function ReadInt():Int;
	function ReadShort():Int;
	function ReadFloat():Float;
	function ReadDouble():Float;
	function ReadString(?size:Int):String;
	function ReadLine():String;
	function Seek(position:Int, ?mode:Int):Void;
	function Align(alignment:Int):Void;
	function Write(data:String):Void;
	function WriteByte(b:Int):Void;
	function WriteInt(i:Int):Void;
	function WriteShort(s:Int):Void;
	function WriteFloat(f:Float):Void;
	function WriteDouble(d:Float):Void;
	function WriteString(s:String):Void;
	function WriteLine(s:String):Void;
}

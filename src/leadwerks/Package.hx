package leadwerks;

@:native("_G")
extern class Package extends Asset
{
	function AddFile(path:String, data:Buffer):Void;
	function Close():Void;
	function DeleteFile(path:String):Void;
	function ExtractFile(path:String, destpath:String):Void;
	function FileSize(path:String):Int;
	function FileTime(path:String):Int;
	function FileType(path:String):Int;
	function LoadDir(path:String):Array<String>;
	function ReadFile(path:String):Buffer;
	function Restrict(restrict:Bool):Void;
	function SetPassword(password:String):Void;
}

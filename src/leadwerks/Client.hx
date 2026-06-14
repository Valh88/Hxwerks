package leadwerks;

@:native("_G")
extern class Client extends Object
{
	function Disconnect():Void;
	function Send(message:Dynamic, ?data:Dynamic):Void;
	function Update():Dynamic;
}

package leadwerks;

@:native("_G")
extern class Server extends Object
{
	function Broadcast(message:Dynamic, ?data:Dynamic):Void;
	function Disconnect(client:Dynamic):Void;
	function Send(client:Dynamic, message:Dynamic, ?data:Dynamic):Void;
	function Update():Dynamic;
}

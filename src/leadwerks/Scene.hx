package leadwerks;

@:native("_G")
extern class Scene extends Object
{
	var entities:Array<Entity>;
	var path(default, null):String;

	function GetEntity(uuid:String):Entity;
}

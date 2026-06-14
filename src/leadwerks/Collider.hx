package leadwerks;

@:native("_G")
extern class Collider extends Asset
{
	function Save(path:String, ?flags:Int):Bool;
}

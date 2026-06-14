package leadwerks;

@:native("_G")
extern class Asset extends Object
{
	@:overload(function(?flags:Int):Bool
	{
	})
	function Reload():Bool;

	@:overload(function(path:String, ?flags:Int):Bool
	{
	})
	function Save(path:String):Bool;
}

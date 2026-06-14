package leadwerks;

@:native("_G")
extern class Sprite extends Entity
{
	var mesh(default, null):Mesh;

	function SetViewMode(mode:Int):Void;
}

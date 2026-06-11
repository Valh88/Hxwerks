package leadwerks;

@:native("_G")
extern class Light
{
	function SetRange(a:Float, b:Float):Void;
	function SetArea(w:Float, h:Float):Void;
	function SetRotation(x:Float, y:Float, z:Float):Void;
}

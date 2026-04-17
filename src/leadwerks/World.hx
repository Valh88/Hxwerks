package leadwerks;

@:native("_G")
extern class World
{
	function Update():Void;
	function Render(framebuffer:Framebuffer):Void;
}

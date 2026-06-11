package leadwerks;

import leadwerks.types.MousePosition;

@:native("_G")
extern class Window
{
	function Closed():Bool;
	function KeyDown(key:Int):Bool;
	function KeyHit(key:Int):Bool;
	function MouseHit(button:Int):Bool;
	function GetMousePosition():MousePosition;
	function ClientSize():MousePosition;
	function SetMousePosition(x:Float, y:Float):Void;
	function GetFramebuffer():Framebuffer;
}

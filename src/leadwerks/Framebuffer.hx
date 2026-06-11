package leadwerks;

import leadwerks.types.IVec2;

@:native("_G")
extern class Framebuffer
{
	var window:Window;
	var size:IVec2;
	var colorBuffer:Dynamic;
	var depthBuffer:Dynamic;

	function GetSize():IVec2;
	function Capture():Void;
	function GetCaptures():Dynamic;
}

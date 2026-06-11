package leadwerks;

import leadwerks.types.IVec2;

@:native("_G")
extern class Interface
{
	var background:Widget;
	var font:Font;
	var scale:Float;

	function LoadColorScheme(path:String):Void;
	function ProcessEvent(event:Dynamic):Void;
	function SetRenderLayers(layers:Int):Void;
	function SetScale(scale:Float):Void;
	function SetSize(w:Int, h:Int):Void;
}

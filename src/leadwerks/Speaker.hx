package leadwerks;

@:native("_G")
extern class Speaker
{
	function Play():Void;
	function Pause():Void;
	function Stop():Void;
	function SetVolume(volume:Float):Void;
	function GetVolume():Float;
	function SetRange(near:Float, far:Float):Void;
	function GetRange():Dynamic;
	function SetPitch(pitch:Float):Void;
	function GetPitch():Float;
	function SetLooping(loop:Bool):Void;
	function SetTime(time:Float):Void;
	function GetTime():Float;
	function GetState():Int;
	function SetPosition(pos:Dynamic):Void;
	function SetFilter(filter:Dynamic):Void;
}

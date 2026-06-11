package leadwerks;

@:native("_G")
extern class GamePad
{
	function ButtonDown(button:Int):Bool;
	function ButtonHit(button:Int):Bool;
	function GetAxisPosition(axis:Int):Float;
	function GetConnected():Bool;
	function Flush():Void;
	function Rumble(left:Float, right:Float):Void;

	static function GetGamePads():Array<GamePad>;
}

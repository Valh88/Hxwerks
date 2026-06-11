package leadwerks;

@:native("_G")
extern class Font extends Asset
{
	function GetTextWidth(text:String, size:Float):Float;
	function GetHeight(size:Float):Float;
}

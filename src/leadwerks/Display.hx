package leadwerks;

import leadwerks.types.IVec2;

/**
	Display interface from Leadwerks 5 API.
**/
@:native("_G")
extern class Display
{
	/** Available screen resolutions. **/
	@:native("graphicsmodes") var graphicsModes:IVec2;

	/** Screen position on the virtual desktop. **/
	@:native("position") var position:IVec2;

	/** DPI scaling value. **/
	@:native("scale") var scale:Float;

	/** Screen dimensions in pixels. **/
	@:native("size") var size:IVec2;

	/** Returns the usable area within the screen. **/
	function ClientArea():IVec2;

	/** Returns the position of the display on the virtual monitor space. **/
	function GetPosition():IVec2;

	/** Returns the display dimensions in pixels. **/
	function GetSize():IVec2;

	/** Returns the current DPI scale value. **/
	function GetScale():Float;
}

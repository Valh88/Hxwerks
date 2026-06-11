package leadwerks;

import leadwerks.types.MousePosition;
import leadwerks.types.IVec2;

@:native("_G")
extern class Window
{
	// --- Properties ---
	var display:Display;
	var position:IVec2;
	var size:IVec2;
	var style:Int;
	var text:String;

	// --- State ---
	function Closed():Bool;
	function KeyDown(key:Int):Bool;
	function KeyHit(key:Int):Bool;
	function MouseDown(button:Int):Bool;
	function MouseHit(button:Int):Bool;
	function Minimized():Bool;
	function Maximized():Bool;

	// --- Position / Size ---
	function GetMousePosition():MousePosition;
	function GetPosition():IVec2;
	function GetSize():IVec2;
	function ClientSize():MousePosition;
	function SetMousePosition(x:Float, y:Float):Void;
	function SetShape(x:Int, y:Int, w:Int, h:Int):Void;
	function SetMinSize(w:Int, h:Int):Void;

	// --- Framebuffer ---
	function GetFramebuffer():Framebuffer;

	// --- Visibility ---
	function GetHidden():Bool;
	function SetHidden(hidden:Bool):Void;
	function Show():Void;

	// --- State changes ---
	function Activate():Void;
	function Maximize():Void;
	function Minimize():Void;
	function Restore():Void;

	// --- Input ---
	function FlushKeys():Void;
	function FlushMouse():Void;
	function SetCursor(cursor:Int):Void;

	// --- System ---
	function GetHandle():Dynamic;
}

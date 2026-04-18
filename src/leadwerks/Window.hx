package leadwerks;

import leadwerks.types.MousePosition;

#if lua

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

#elseif cpp

import leadwerks.CppBridge;

/** Boxed `std::shared_ptr<Leadwerks::Window>`. **/
abstract Window(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	public inline function Closed():Bool
		return CppBridge.window_closed(toRaw()) != 0;

	public inline function KeyDown(key:Int):Bool
		return CppBridge.window_key_down(toRaw(), key) != 0;

	public inline function KeyHit(key:Int):Bool
		return CppBridge.window_key_hit(toRaw(), key) != 0;

	public inline function MouseHit(button:Int):Bool
		return CppBridge.window_mouse_hit(toRaw(), button) != 0;

	public function GetMousePosition():MousePosition
	{
		var v = CppBridge.window_get_mouse_position(toRaw());
		return {x: v.x, y: v.y};
	}

	public function ClientSize():MousePosition
	{
		var v = CppBridge.window_client_size(toRaw());
		return {x: v.x, y: v.y};
	}

	public inline function SetMousePosition(x:Float, y:Float):Void
		CppBridge.window_set_mouse_position(toRaw(), x, y);

	public function GetFramebuffer():Framebuffer
		return new Framebuffer(CppBridge.window_get_framebuffer(toRaw()));
}

#end

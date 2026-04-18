package leadwerks;

import leadwerks.types.MousePosition;

#if lua

@:native("_G")
extern class Framebuffer
{
	function GetSize():MousePosition;
}

#elseif cpp

import leadwerks.CppBridge;

/** Boxed `std::shared_ptr<Leadwerks::Framebuffer>`. **/
abstract Framebuffer(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	public function GetSize():MousePosition
	{
		var v = CppBridge.framebuffer_get_size(this);
		return {x: v.x, y: v.y};
	}
}

#end

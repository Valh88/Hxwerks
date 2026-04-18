package leadwerks;

#if lua

@:native("_G")
extern class Light
{
	function SetRange(a:Float, b:Float):Void;
	function SetArea(w:Float, h:Float):Void;
	function SetRotation(x:Float, y:Float, z:Float):Void;
}

#elseif cpp

import leadwerks.CppBridge;

/** Point / area light from `CreateBoxLight` (same handle as `Entity`). **/
abstract Light(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;

	@:from
	static inline function fromEntity(e:Entity):Light
		return cast e.toRaw();

	public inline function SetRange(a:Float, b:Float):Void
		CppBridge.light_set_range(toRaw(), a, b);

	public inline function SetArea(w:Float, h:Float):Void
		CppBridge.light_set_area(toRaw(), w, h);

	public inline function SetRotation(x:Float, y:Float, z:Float):Void
		CppBridge.light_set_rotation(toRaw(), x, y, z);
}

#end

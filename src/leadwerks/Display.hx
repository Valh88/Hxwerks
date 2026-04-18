package leadwerks;

#if cpp

/** Boxed `std::shared_ptr<Leadwerks::Display>` from C++ bridge. **/
abstract Display(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	@:from
	static inline function fromRaw(p:cpp.RawPointer<cpp.Void>):Display
		return new Display(p);

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;
}

#end

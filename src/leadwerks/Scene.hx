package leadwerks;

#if cpp

/** Boxed `std::shared_ptr<Leadwerks::Scene>` from `Globals.LoadScene`. **/
abstract Scene(cpp.RawPointer<cpp.Void>) from cpp.RawPointer<cpp.Void> to cpp.RawPointer<cpp.Void>
{
	public inline function new(p:cpp.RawPointer<cpp.Void>)
		this = p;

	public inline function toRaw():cpp.RawPointer<cpp.Void>
		return cast this;
}

#end

package leadwerks;

import leadwerks.types.IVec2;

@:native("_G")
extern class Event
{
	var data:Float;
	var extra:Object;
	var id:Int;
	var position:IVec2;
	var size:IVec2;
	var source:Object;
	var text:String;
}

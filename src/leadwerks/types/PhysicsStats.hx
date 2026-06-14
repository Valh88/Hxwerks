package leadwerks.types;

@:native("_G")
extern class PhysicsStats
{
	var activebodies:Int;
	var contacts:Int;
	var collisiontests:Int;
	var islands:Int;
}

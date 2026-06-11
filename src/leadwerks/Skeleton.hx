package leadwerks;

@:native("_G")
extern class Skeleton
{
	var root:Bone;

	function FindBone(name:String):Bone;
}

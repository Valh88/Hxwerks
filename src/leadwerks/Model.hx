package leadwerks;

@:native("_G")
extern class Model extends Entity
{
	var lods:Dynamic;
	var skeleton:Skeleton;

	function AddMesh(mesh:Dynamic):Void;
	function AddLod(?distance:Float):Void;
	function Animate(animation:Int, ?loopmode:Int, ?speed:Float, ?blend:Float):Void;
	function Clear():Void;
	function Collapse():Void;
	function CountAnimationFrames(animation:Int):Int;
	function CountAnimations():Int;
	function GetAnimationSpeed(animation:Int):Float;
	function GetAnimationName(animation:Int):String;
	function Save(path:String):Void;
	function SetLodDistance(distance:Float):Void;
	function SetSkeleton(skeleton:Skeleton):Void;
	function UpdateNormals():Void;
}

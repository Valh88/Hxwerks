package leadwerks;

@:native("_G")
extern class Joint
{
	function GetLimits():Dynamic;
	function GetOffset():Float;
	function SetFriction(friction:Float):Void;
	function SetLimits(min:Float, max:Float):Void;
	function SetMaxForce(force:Float):Void;
	function SetMaxTorque(torque:Float):Void;
	function SetPose(?position:Dynamic, ?rotation:Dynamic):Void;
	function SetSpring(stiffness:Float, damping:Float):Void;
}

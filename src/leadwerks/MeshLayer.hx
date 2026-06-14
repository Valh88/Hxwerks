package leadwerks;

import leadwerks.types.Vec3;

@:native("_G")
extern class MeshLayer extends Object
{
	function AddVariation(model:Model, ?spacing:Float):Void;
	function SetPosition(position:Vec3):Void;
	function SetRotation(rotation:Vec3):Void;
	function SetScale(scale:Vec3):Void;
}

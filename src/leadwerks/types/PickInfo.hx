package leadwerks.types;

import leadwerks.Entity;
import leadwerks.Face;

@:native("_G")
extern class PickInfo
{
	var success:Bool;
	var entity:Entity;
	var face:Face;
	var mesh:Dynamic;
	var meshlayer:Int;
	var meshlayerinstance:IVec2;
	var normal:Vec3;
	var polygon:Int;
	var position:Vec3;
	var texcoords:Dynamic;
}

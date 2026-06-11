package leadwerks;

import leadwerks.types.IVec2;
import leadwerks.types.Vec3;

@:native("_G")
extern class Texture extends Asset
{
	var size:Vec3;
	var mipchain:Dynamic;

	function BuildMipmaps():Void;
	function SetPixels(data:String, ?width:Int, ?height:Int, ?format:Int):Void;
	function SetSubPixels(x:Int, y:Int, w:Int, h:Int, data:String, ?format:Int):Void;
}

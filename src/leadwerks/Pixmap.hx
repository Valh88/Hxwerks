package leadwerks;

import leadwerks.types.IVec2;
import leadwerks.types.Vec4;

@:native("_G")
extern class Pixmap extends Asset
{
	var format(default, null):Int;
	var size(default, null):IVec2;
	var blocks(default, null):IVec2;
	var pixels(default, null):Buffer;
	var blocksize(default, null):Int;

	function Blit(src:Pixmap, srcx:Int, srcy:Int, srcw:Int, srch:Int, dstx:Int, dsty:Int, dstw:Int, dsth:Int):Void;
	function Convert(format:Int):Pixmap;
	function CopyRect(src:Pixmap, srcx:Int, srcy:Int, srcw:Int, srch:Int, dstx:Int, dsty:Int):Void;
	function Extract(x:Int, y:Int, width:Int, height:Int):Pixmap;
	function Fill(r:Float, g:Float, b:Float, ?a:Float):Void;
	function ReadPixel(x:Int, y:Int):Vec4;
	function Resize(width:Int, height:Int):Void;
	function Sample(x:Float, y:Float, ?wrapmode:Int):Vec4;
	function WritePixel(x:Int, y:Int, color:Vec4):Void;
}

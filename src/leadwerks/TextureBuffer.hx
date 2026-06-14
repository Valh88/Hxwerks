package leadwerks;

import leadwerks.types.IVec2;

@:native("_G")
extern class TextureBuffer extends Object
{
	var size(default, null):IVec2;
	var textures(default, null):Dynamic;

	function CountColorAttachments():Int;
	function GetColorAttachment(?index:Int):Texture;
	function GetDepthAttachment():Texture;
	function GetSize():IVec2;
	function SetColorAttachment(texture:Texture, ?index:Int):Void;
	function SetDepthAttachment(texture:Texture):Void;
}

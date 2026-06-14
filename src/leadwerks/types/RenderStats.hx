package leadwerks.types;

@:native("_G")
extern class RenderStats
{
	var drawcalls:Int;
	var triangles:Int;
	var entities:Int;
	var visibleentities:Int;
	var shadowmaps:Int;
	var culledentities:Int;
}

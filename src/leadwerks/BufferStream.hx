package leadwerks;

@:native("_G")
extern class BufferStream extends Stream
{
	var data(default, null):Buffer;
}

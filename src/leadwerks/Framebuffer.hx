package leadwerks;

import leadwerks.types.MousePosition;

@:native("_G")
extern class Framebuffer
{
	function GetSize():MousePosition;
}

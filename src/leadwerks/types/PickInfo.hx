package leadwerks.types;

import leadwerks.Globals;

/**
	Result of `World.Pick` / `Camera.Pick` (world line picks expose `success`).
**/
typedef PickInfo =
{
	/** True if the line-of-sight is clear (for world line picks). **/
	@:optional var success:Bool;

	var entity:Dynamic;

	var position:Dynamic;
}
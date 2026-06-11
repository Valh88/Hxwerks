package leadwerks;

import leadwerks.types.Vec3;

/**
	Collision info stored in `world.collisions` array.
**/
typedef Collision =
{
	var entities:Array<Entity>;
	var position:Vec3;
	var normal:Vec3;
	var speed:Float;
}

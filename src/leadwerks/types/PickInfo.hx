package leadwerks.types;

import leadwerks.Entity;

typedef PickInfo =
{
	var success:Bool;
	var entity:Entity;
	var position:Dynamic;
	var normal:Vec3;
}

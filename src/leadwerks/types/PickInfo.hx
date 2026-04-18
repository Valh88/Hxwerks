package leadwerks.types;

#if lua

/** Result of `World.Pick` / `Camera.Pick` (world line picks expose `success`). **/
typedef PickInfo =
{
	?success:Bool,
	entity:Dynamic,
	position:Dynamic,
}

#elseif cpp

import leadwerks.Entity;

typedef PickInfo =
{
	var success:Bool;
	var entity:Null<Entity>;
	var position:Vec3;
}

#end

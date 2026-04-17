package leadwerks.types;

/** Return value of `Globals.Aabb(min, max)` for `World.GetEntitiesInArea`. **/
typedef AabbBounds =
{
	var min:Vec3;
	var max:Vec3;
}

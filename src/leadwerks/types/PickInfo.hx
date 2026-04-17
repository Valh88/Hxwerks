package leadwerks.types;

/** Result of `World.Pick` / `Camera.Pick` (world line picks expose `success`). **/
typedef PickInfo =
{
	?success:Bool,
	entity:Dynamic,
	position:Dynamic,
}

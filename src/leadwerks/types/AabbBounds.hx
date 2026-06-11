package leadwerks.types;

import leadwerks.types.Vec3;

/**
	Axis-aligned bounding box (aabb) defined by min/max corners.
**/
class AabbBounds
{
	public final min:Vec3;
	public final max:Vec3;

	public function new(min:Vec3, max:Vec3)
	{
		this.min = min;
		this.max = max;
	}
}

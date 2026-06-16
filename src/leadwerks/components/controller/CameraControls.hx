package controller;

import leadwerks.Globals;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.support.EntityScript;

class CameraControls extends EntityScript
{
	@property("Mouse smoothing") var mousesmoothing:Float = 1.0;
	@property("Look speed") var mouselookspeed:Float = 1.0;
	@property("Move speed") var movespeed:Float = 4.0;

	var freelookstarted:Bool = false;
	var freelookrotation:Vec3 = Globals.Vec3(0, 0, 0);
	var lookchange:Vec2 = Globals.Vec2(0, 0);

	override function update():Void
	{
		var window = Globals.ActiveWindow();
		if (window == null)
			return;

		var center = window.ClientSize();
		center.x = Globals.Round(center.x * 0.5);
		center.y = Globals.Round(center.y * 0.5);

		if (freelookstarted != true)
		{
			freelookstarted = true;
			freelookrotation = entity.GetRotation(true);
		}

		var newMousePos = window.GetMousePosition();
		window.SetMousePosition(center.x, center.y);

		var smoothFactor:Float = 0;
		if (mousesmoothing > 0)
		{
			smoothFactor = 1.0 - 1.0 / (1.0 + mousesmoothing);
		}
		lookchange.x = lookchange.x * smoothFactor + (newMousePos.y - center.y) * 0.1 * mouselookspeed * (1.0 - smoothFactor);
		lookchange.y = lookchange.y * smoothFactor + (newMousePos.x - center.x) * 0.1 * mouselookspeed * (1.0 - smoothFactor);

		if (Math.abs(lookchange.x) < 0.001)
			lookchange.x = 0.0;
		if (Math.abs(lookchange.y) < 0.001)
			lookchange.y = 0.0;

		if (lookchange.x != 0.0 || lookchange.y != 0.0)
		{
			freelookrotation.x = freelookrotation.x + lookchange.x;
			freelookrotation.y = freelookrotation.y + lookchange.y;
			entity.SetRotation(freelookrotation, true);
		}

		var speed:Float = movespeed / 60.0;

		if (window.KeyDown(Globals.KEY_SHIFT))
			speed = speed * 10.0;
		else if (window.KeyDown(Globals.KEY_CONTROL))
			speed = speed * 0.25;

		if (window.KeyDown(Globals.KEY_E))
			entity.Translate(0, speed, 0);
		if (window.KeyDown(Globals.KEY_Q))
			entity.Translate(0, -speed, 0);
		if (window.KeyDown(Globals.KEY_D))
			entity.Move(speed, 0, 0);
		if (window.KeyDown(Globals.KEY_A))
			entity.Move(-speed, 0, 0);
		if (window.KeyDown(Globals.KEY_W))
			entity.Move(0, 0, speed);
		if (window.KeyDown(Globals.KEY_S))
			entity.Move(0, 0, -speed);
	}
}

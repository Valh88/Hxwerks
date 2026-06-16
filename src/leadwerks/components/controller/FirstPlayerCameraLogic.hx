package controller;

import leadwerks.Camera;
import leadwerks.Entity;
import leadwerks.Globals;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.Window;

class FirstPlayerCameraLogic
{
	public static function setup(entity:Entity):Void
	{
		var camera:Camera = entity.camera;
		if (camera == null)
			camera = cast entity.FindChild("Camera");
		if (camera == null && entity.kids != null)
		{
			camera = cast(entity.kids[1]);
		}
		if (camera == null)
		{
			camera = Globals.CreateCamera(entity.GetWorld());
			camera.Listen();
		}
		entity.camera = camera;

		entity.SetPhysicsMode(Globals.PHYSICS_PLAYER);
		if (entity.GetMass() == 0.0)
			entity.SetMass(78);
		entity.SetCollisionType(Globals.COLLISION_PLAYER);
		entity.SetShadows(false);

		var state:Dynamic = untyped entity._fpcState;
		if (state == null)
		{
			state =
				{};
			untyped entity._fpcState = state;
		}
		state.freelookstarted = false;
		state.freelookrotation = Globals.Vec3(0, 0, 0);
		state.lookchange = Globals.Vec2(0, 0);
		state.freelookrotation.y = entity.GetRotation(true).y;
		state.freelookrotation.x = 0;
	}

	public static function update(entity:Entity, mouseSmoothing:Float, mouseLookSpeed:Float, moveSpeed:Float, jumpForce:Float):Void
	{
		var camera:Camera = entity.camera;
		if (camera == null)
			return;

		var window:Window = Globals.ActiveWindow();
		if (window == null)
			return;

		var state:Dynamic = untyped entity._fpcState;
		if (state == null)
		{
			state =
				{};
			untyped entity._fpcState = state;
		}

		var center = window.ClientSize();
		center.x = Globals.Round(center.x * 0.5);
		center.y = Globals.Round(center.y * 0.5);

		if (state.freelookstarted != true)
		{
			state.freelookstarted = true;
			window.SetMousePosition(center.x, center.y);
			state.freelookrotation.y = entity.GetRotation(true).y;
			state.freelookrotation.x = camera.GetRotation(true).x;
		}

		var newMousePos = window.GetMousePosition();
		window.SetMousePosition(center.x, center.y);

		var smoothFactor:Float = 0;
		if (mouseSmoothing > 0)
		{
			smoothFactor = 1.0 - 1.0 / (1.0 + mouseSmoothing);
		}
		state.lookchange.x = state.lookchange.x * smoothFactor + (newMousePos.y - center.y) * 0.1 * mouseLookSpeed * (1.0 - smoothFactor);
		state.lookchange.y = state.lookchange.y * smoothFactor + (newMousePos.x - center.x) * 0.1 * mouseLookSpeed * (1.0 - smoothFactor);

		if (Math.abs(state.lookchange.x) < 0.001)
			state.lookchange.x = 0.0;
		if (Math.abs(state.lookchange.y) < 0.001)
			state.lookchange.y = 0.0;

		if (state.lookchange.x != 0.0 || state.lookchange.y != 0.0)
		{
			state.freelookrotation.x = state.freelookrotation.x + state.lookchange.x;
			state.freelookrotation.y = state.freelookrotation.y + state.lookchange.y;
			state.freelookrotation.x = Math.max(-90, Math.min(90, state.freelookrotation.x));
		}

		entity.SetRotation(Globals.Vec3(0, state.freelookrotation.y, 0), true);
		camera.SetRotation(Globals.Vec3(state.freelookrotation.x, 0, 0), false);

		if (window.KeyDown(Globals.KEY_SHIFT))
			moveSpeed = moveSpeed * 2.0;

		var moveX:Float = 0;
		var moveZ:Float = 0;
		if (window.KeyDown(Globals.KEY_D))
			moveX = moveX + moveSpeed;
		if (window.KeyDown(Globals.KEY_A))
			moveX = moveX - moveSpeed;
		if (window.KeyDown(Globals.KEY_W))
			moveZ = moveZ + moveSpeed;
		if (window.KeyDown(Globals.KEY_S))
			moveZ = moveZ - moveSpeed;
		if (moveX != 0 && moveZ != 0)
		{
			var k:Float = 0.707;
			moveX = moveX * k;
			moveZ = moveZ * k;
		}

		var jump:Float = (jumpForce > 0 && window.KeyDown(Globals.KEY_SPACE)) ? jumpForce : 0;
		entity.SetInput(state.freelookrotation.y, moveZ, moveX, jump, false);
	}
}

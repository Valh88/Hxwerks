package controller;

import leadwerks.Camera;
import leadwerks.Entity;
import leadwerks.Globals;
import leadwerks.Sound;
import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.support.EntityScript;
import leadwerks.types.Quat;

class FPSPlayer extends EntityScript
{
	@property("Enabled") var enabled:Bool = true;
	@property("Health") var health:Float = 100;
	@property("Team") var team:Int = 0;
	@property("FOV") var fov:Float = 70;
	@property("Eye height") var eyeheight:Float = 1.65;
	@property("Crouch eye height") var croucheyeheight:Float = 0.7;
	@property("Mouse smoothing") var mousesmoothing:Float = 2.0;
	@property("Mouse look speed") var mouselookspeed:Float = 1.0;
	@property("Move speed") var movespeed:Float = 4.0;
	@property("Jump force") var jumpforce:Float = 5.0;
	@property("Jump lunge") var jumplunge:Float = 1.2;
	@property("Initial slot") var initialslot:Int = 0;
	@property("Flashlight on") var flashlighton:Bool = false;

	var freelookstarted:Bool = false;
	var freelookmousepos:Vec3 = Globals.Vec3(0, 0, 0);
	var freelookrotation:Vec3 = Globals.Vec3(0, 0, 0);
	var lookchange:Vec2 = Globals.Vec2(0, 0);
	var mousedelta:Vec2 = Globals.Vec2(0, 0);
	var currentcameraposition:Vec3 = Globals.Vec3(0, 0, 0);
	var lastfootsteptime:Float = 0;
	var jumpkey:Bool = false;
	var running:Bool = false;
	var maxlean:Float = 0;
	var leanspeed:Float = 1;
	var selectedslot:Int = 0;
	var movement:Vec3 = Globals.Vec3(0, 0, 0);
	var lean:Float = 0;

	var sound_step:Array<Sound>;
	var sound_hit:Array<Sound>;
	var sound_jump:Sound;
	var sound_flashlight:Sound;

	var camerashakerotation:Quat;
	var smoothedcamerashakerotation:Quat;
	var flashlightrotation:Quat;

	var weapons:Array<Dynamic>;
	var weapon:Dynamic;
	var flashlight:Dynamic;
	var camera:Camera;
	var deadbodycollider:Dynamic;
	var agent:Dynamic;
	var navmesh:Dynamic;

	override function start():Void
	{
		camera = entity.camera;
		if (camera == null && entity.kids != null)
		{
			camera = cast entity.kids[0];
		}

		currentcameraposition = camera.GetPosition(true);

		entity.SetPhysicsMode(Globals.PHYSICS_PLAYER);
		if (entity.GetMass() == 0.0)
			entity.SetMass(78);
		entity.SetCollisionType(Globals.COLLISION_PLAYER);
		entity.SetShadows(false);
		entity.SetRenderLayers(0);
		entity.SetNavObstacle(false);

		untyped
		{
			if (entity.navmesh != null)
			{
				agent = Globals.CreateNavAgent(entity.navmesh, 0.25, 1.8);
				agent.SetPosition(entity.GetPosition(true));
			}
		}

		flashlightrotation = camera.GetQuaternion(true);

		var self = this;
		Globals.ListenEvent(Globals.EVENT_KEYDOWN, null, function(ev:Dynamic, extra:Dynamic):Dynamic
		{
			return self.processEvent(ev);
		}, null);
		Globals.ListenEvent(Globals.EVENT_KEYUP, null, function(ev:Dynamic, extra:Dynamic):Dynamic
		{
			return self.processEvent(ev);
		}, null);
		Globals.ListenEvent(Globals.EVENT_WORLDRESUME, entity.GetWorld(), function(ev:Dynamic, extra:Dynamic):Dynamic
		{
			return self.processEvent(ev);
		}, null);

		sound_hit = [];
		var n:Int;
		for (n in 1...4)
		{
			if (Globals.FileType("Sound/Impact/bodypunch" + n + ".wav") == 1)
			{
				sound_hit.push(Globals.LoadSound("Sound/Impact/bodypunch" + n + ".wav"));
			}
		}
		sound_jump = Globals.LoadSound("Sound/Footsteps/Concrete/jump.wav");
		sound_flashlight = Globals.LoadSound("Sound/Items/flashlightswitch.wav");
		sound_step = [];
		for (n in 1...5)
		{
			sound_step.push(Globals.LoadSound("Sound/Footsteps/Concrete/step" + n + ".wav"));
		}

		var scale:Float = 0.25;
		var points:Array<Vec3> = [];

		points.push(Globals.Vec3(0.5, 0.5, 0.5) * scale);
		points.push(Globals.Vec3(-0.5, 0.5, 0.5) * scale);
		points.push(Globals.Vec3(0.5, -0.5, 0.5) * scale);
		points.push(Globals.Vec3(-0.5, -0.5, 0.5) * scale);
		points.push(Globals.Vec3(0.5, 0.5, -0.5) * scale);
		points.push(Globals.Vec3(-0.5, 0.5, -0.5) * scale);
		points.push(Globals.Vec3(0.5, -0.5, -0.5) * scale);
		points.push(Globals.Vec3(-0.5, -0.5, -0.5) * scale);
		points.push(Globals.Vec3(0.0, 0.0, -0.667) * scale);
		points.push(Globals.Vec3(0.0, 0.0, 0.667) * scale);
		points.push(Globals.Vec3(0.0, -0.667, 0.0) * scale);
		points.push(Globals.Vec3(0.0, 0.667, 0.0) * scale);
		points.push(Globals.Vec3(-0.667, 0.0, 0.0) * scale);
		points.push(Globals.Vec3(0.667, 0.0, 0.0) * scale);

		deadbodycollider = Globals.CreateConvexHullCollider(points);

		health = 100;

		if (flashlighton)
		{
			var temp = sound_flashlight;
			sound_flashlight = null;
			showFlashlight();
			sound_flashlight = temp;
		}

		weapons = [];
		untyped
		{
			var props = entity.properties;
			for (n in 0...4)
			{
				var key = "slot" + n;
				var path = props[key];
				if (path != null && path != "")
				{
					var prefab = Globals.LoadPrefab(entity.GetWorld(), path);
					weapons[n] = prefab;
				}
			}
		}

		if (camera == null)
		{
			camera = Globals.CreateCamera(entity.GetWorld());
			camera.Listen();
		}
		var pos = entity.GetPosition(true);
		camera.SetPosition(Globals.Vec3(pos.x, pos.y + eyeheight, pos.z));
		camera.SetRotation(Globals.Vec3(0, entity.rotation.y, 0));
		camera.SetFov(fov);

		selectedslot = initialslot + 1;
		if (weapons.length >= selectedslot && weapons[selectedslot - 1] != null)
		{
			untyped weapons[selectedslot - 1].AttachToPlayer(entity);
			weapon = weapons[selectedslot - 1];
		}

		untyped
		{
			if (entity.scene != null && entity.scene.navmeshes != null)
			{
				for (i in 0...entity.scene.navmeshes.length)
				{
					navmesh = entity.scene.navmeshes[i];
				}
			}
		}
	}

	function kill(attacker:Dynamic):Void
	{
		camera.SetParent(null);
		camera.SetCollider(deadbodycollider);
		camera.SetVelocity(entity.GetVelocity());
		camera.SetMass(10);
		camera.SetCollisionType(Globals.COLLISION_DEBRIS);
		camera.AddTorque(50, Globals.Random(-20, 20), Globals.Random(-20, 20));

		if (weapon != null)
			untyped weapon.DetachFromPlayer(entity);
		weapon = null;
		entity.SetMass(0);
		entity.SetCollisionType(Globals.COLLISION_NONE);
		entity.SetCollider(null);
		entity.SetPhysicsMode(Globals.PHYSICS_DISABLED);

		if (flashlight != null)
			flashlight.SetHidden(true);
		entity.Disable();
	}

	function toggleFlashlight():Void
	{
		if (flashlight == null || flashlight.GetHidden())
		{
			showFlashlight();
		} else
		{
			hideFlashlight();
		}
	}

	function showFlashlight():Void
	{
		if (flashlight == null || flashlight.GetHidden())
		{
			if (sound_flashlight != null)
				sound_flashlight.Play();
			if (flashlight == null)
			{
				flashlight = Globals.CreateSpotLight(entity.GetWorld());
				flashlight.SetConeAngles(20, 10);
				flashlight.SetRange(0.01, 10);
			}
			flashlightrotation = camera.GetQuaternion(true);
			flashlight.SetHidden(false);
			updateFlashlight();
			untyped entity.FireOutputs("ShowFlashlight");
		}
		flashlighton = true;
	}

	function hideFlashlight():Void
	{
		if (flashlight != null && !flashlight.GetHidden())
		{
			if (sound_flashlight != null)
				sound_flashlight.Play();
			flashlight.SetHidden(true);
			untyped entity.FireOutputs("HideFlashlight");
		}
		flashlighton = false;
	}

	function processEvent(e:Dynamic):Bool
	{
		if (!entity.GetEnabled())
			return true;
		if (health <= 0)
			return true;
		if (entity.GetWorld().GetPaused())
			return true;

		if (e.id == Globals.EVENT_KEYDOWN)
		{
			if (e.data == Globals.KEY_SPACE)
			{
				jumpkey = true;
			} else if (e.data == Globals.KEY_F)
			{
				toggleFlashlight();
			} else if (e.data == Globals.KEY_E)
			{
				if (entity.GetWorld() != null)
				{
					var pos = entity.GetPosition(true);
					var bounds = Globals.Aabb(pos - Globals.Vec3(2, 2, 2), pos + Globals.Vec3(2, 2, 2));
					var entities:Array<Entity> = cast entity.GetWorld().GetEntitiesInArea(bounds.min, bounds.max, "Use", "~=", null);
					for (e2 in entities)
					{
						if (e2 != entity)
						{
							untyped
							{
								if (e2.Use != null)
									e2.Use();
							}
						}
					}
				}
			}
		} else if (e.id == Globals.EVENT_WORLDRESUME)
		{
			var window = Globals.ActiveWindow();
			if (window != null)
			{
				var size = window.ClientSize();
				window.SetMousePosition(Globals.Round(size.x / 2), Globals.Round(size.y) / 2);
			}
		} else if (e.id == Globals.EVENT_KEYUP)
		{
			if (e.data == Globals.KEY_SPACE)
			{
				jumpkey = false;
			}
		}
		return true;
	}

	override function update():Void
	{
		if (health <= 0)
			return;
		if (entity.GetWorld().GetPaused())
			return;

		if (running && weapon != null)
		{
			untyped
			{
				if (!weapon.PlayerCanRun())
					running = false;
			}
		}
		movement = Globals.Vec3(0, 0, 0);

		var jump:Float = 0;
		var crouchkey:Bool = false;
		var crouched:Bool = false;

		var window = Globals.ActiveWindow();
		if (window != null)
		{
			running = !entity.GetCrouched() && window.KeyDown(Globals.KEY_SHIFT);

			var framebuffer = window.GetFramebuffer();
			var fbSize = framebuffer.GetSize();

			var cx:Float = Globals.Round(fbSize.x / 2);
			var cy:Float = Globals.Round(fbSize.y / 2);
			var mpos = window.GetMousePosition();
			window.SetMousePosition(cx, cy);
			var centerPos = window.GetMousePosition();

			if (freelookstarted)
			{
				var looksmoothing:Float = mousesmoothing;
				var lookspeed:Float = mouselookspeed / 10.0;

				var dx:Float = mpos.x - centerPos.x;
				var dy:Float = mpos.y - centerPos.y;

				if (looksmoothing > 0.0)
				{
					mousedelta.x = Globals.CurveValue(dx, mousedelta.x, 1.0 + looksmoothing);
					mousedelta.y = Globals.CurveValue(dy, mousedelta.y, 1.0 + looksmoothing);
				} else
				{
					mousedelta.x = dx;
					mousedelta.y = dy;
				}

				freelookrotation.x = Globals.Clamp(freelookrotation.x + mousedelta.y * lookspeed, -90.0, 90.0);
				freelookrotation.y = freelookrotation.y + mousedelta.x * lookspeed;
				camera.SetRotation(freelookrotation, true);
				freelookmousepos = Globals.Vec3(mpos.x, mpos.y, 0);
			} else
			{
				freelookstarted = true;
				freelookrotation = camera.GetRotation(true);
				freelookmousepos = Globals.Vec3(window.GetMousePosition().x, window.GetMousePosition().y, 0);
				window.SetCursor(Globals.CURSOR_NONE);
			}

			if (window.KeyHit(Globals.KEY_G))
			{
				var a:Float = Globals.Random(360.0);
				camerashakerotation = Globals.Quat(Globals.Vec3(Globals.Cos(a) * 30.0, Globals.Sin(a) * 30.0, 0.0));
			}

			var speed:Float = 0.1;
			var diff:Float = Math.sqrt(camerashakerotation.x * camerashakerotation.x + camerashakerotation.y * camerashakerotation.y
				+ camerashakerotation.z * camerashakerotation.z + camerashakerotation.w * camerashakerotation.w);
			camerashakerotation = camerashakerotation.Slerp(Globals.Quat(0, 0, 0, 1), Math.min(1.0, speed / diff));
			smoothedcamerashakerotation = smoothedcamerashakerotation.Slerp(camerashakerotation, 0.5);
			camera.Turn(smoothedcamerashakerotation.ToEuler(), false);

			crouched = entity.GetCrouched();

			if (entity.GetEnabled())
			{
				var spd:Float = movespeed;
				crouchkey = window.KeyDown(Globals.KEY_C);
				if (entity.GetAirborne())
				{
					spd = spd * 0.25;
				} else
				{
					if (running)
					{
						spd = spd * 2.0;
					} else if (crouched)
					{
						spd = spd * 0.5;
					}
					if (jumpkey && !crouched)
					{
						jump = jumpforce;
						if (sound_jump != null)
							sound_jump.Play();
					}
				}

				if (window.KeyDown(Globals.KEY_D))
					movement.x = movement.x + spd;
				if (window.KeyDown(Globals.KEY_A))
					movement.x = movement.x - spd;
				if (window.KeyDown(Globals.KEY_W))
					movement.z = movement.z + spd;
				if (window.KeyDown(Globals.KEY_S))
					movement.z = movement.z - spd;
				if (movement.x != 0.0 && movement.z != 0.0)
				{
					movement = movement * 0.707;
				}
				if (jump != 0.0)
				{
					movement.x = movement.x * jumplunge;
					if (movement.z > 0.0)
					{
						movement.z = movement.z * jumplunge;
					}
				}
			}
		}

		entity.SetInput(camera.rotation.y, movement.z, movement.x, jump, crouchkey);

		if (agent != null)
			agent.SetPosition(entity.GetPosition(true));

		var eye:Float = eyeheight;
		if (entity.GetCrouched())
		{
			if (!entity.GetAirborne())
				eye = croucheyeheight;
			crouched = true;
		} else
		{
			eye = eyeheight;
			crouched = false;
		}

		var y:Float = Globals.TransformPoint(currentcameraposition, null, entity).y;
		var h:Float = eye;
		if (!entity.GetAirborne() && (y < eye || eye != eyeheight))
		{
			h = Globals.Mix(y, eye, 0.25);
		}
		var tPos:Vec3 = Globals.TransformPoint(0, h, 0, entity, null);
		currentcameraposition = tPos;
		camera.SetPosition(currentcameraposition, true);

		if (maxlean > 0.0)
		{
			var localPos:Vec3 = Globals.TransformPoint(camera.GetPosition(true), null, entity);
			if (window.KeyDown(Globals.KEY_E))
				lean = lean - leanspeed;
			if (window.KeyDown(Globals.KEY_Q))
				lean = lean + leanspeed;
			lean = Globals.Clamp(lean, -maxlean, maxlean);
			if (lean != 0.0)
			{
				camera.SetPosition(entity.GetPosition(true), true);
				var r = camera.GetRotation(true);
				camera.SetRotation(Globals.Vec3(0, r.y, 0), true);
				camera.Turn(0, 0, lean);
				camera.Move(localPos.x, localPos.y, localPos.z);
				camera.Turn(r.x, 0, 0);
			}
			if (!window.KeyDown(Globals.KEY_E) && !window.KeyDown(Globals.KEY_Q))
			{
				if (lean > 0.0)
				{
					lean = lean - leanspeed;
					lean = Math.max(lean, 0.0);
				} else if (lean < 0.0)
				{
					lean = lean + leanspeed;
					lean = Math.min(lean, 0.0);
				}
			}
		}

		updateFlashlight();
		updateFootsteps();

		jumpkey = false;
	}

	function updateFootsteps():Void
	{
		if (entity.GetWorld() == null)
			return;
		if (!entity.GetAirborne() && movement.Length() > 0.0)
		{
			var now:Float = entity.GetWorld().GetTime();
			var vel = entity.GetVelocity();
			var speed:Float = untyped __lua__("Vec2({0}, {1}):Length()", vel.x, vel.z);
			var footsteptime:Float = Globals.Clamp(500.0 * movespeed / speed, 250.0, 1000.0);
			if (now - lastfootsteptime > footsteptime && sound_step.length > 0)
			{
				lastfootsteptime = now;
				var index:Int = Std.int(Globals.Floor(Globals.Random(1, sound_step.length)));
				if (sound_step[index - 1] != null)
					sound_step[index - 1].Play();
			}
		}
	}

	function updateFlashlight():Void
	{
		if (flashlight != null)
		{
			var pos = camera.GetPosition(true);
			pos = pos + Globals.TransformNormal(Globals.Vec3(0, -1, 0), camera, null) * 0.25;
			pos = pos + Globals.TransformNormal(Globals.Vec3(1, 0, 0), camera, null) * 0.25;
			flashlight.SetPosition(pos, true);
			flashlightrotation = flashlightrotation.Slerp(camera.GetQuaternion(true), 0.2);
			flashlight.SetRotation(flashlightrotation, true);
		}
	}

	function damage(amount:Float, attacker:Dynamic):Void
	{
		if (health <= 0)
			return;
		health = health - amount;
		if (health <= 0)
		{
			kill(attacker);
		} else
		{
			var a:Float = Globals.Random() * 360.0;
			camerashakerotation = Globals.Quat(Globals.Vec3(Globals.Cos(a) * 45.0, Globals.Sin(a) * 45.0, 0.0));
			if (sound_hit.length > 0)
			{
				var index:Int = Std.int(Globals.Floor(Globals.Random(1, sound_hit.length)));
				if (sound_hit[index - 1] != null)
					sound_hit[index - 1].Play();
			}
		}
	}
}

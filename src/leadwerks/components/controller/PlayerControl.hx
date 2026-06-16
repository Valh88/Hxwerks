package controller;

import leadwerks.support.EntityScript;

class PlayerControl extends EntityScript
{
	@property("Mouse smoothing") var mousesmoothing:Float = 1.0;
	@property("Look speed") var mouselookspeed:Float = 1.0;
	@property("Move speed") var movespeed:Float = 4.0;
	@property("Jump force") var jumpforce:Float = 5.0;
	@property("Eye height") var eyeheight:Float = 1.65;

	override function start():Void
	{
		FirstPlayerCameraLogic.setup(entity);
	}

	override function update():Void
	{
		FirstPlayerCameraLogic.update(entity, mousesmoothing, mouselookspeed, movespeed, jumpforce);
	}
}

package leadwerks;

import leadwerks.types.Vec2;
import leadwerks.types.Vec3;
import leadwerks.types.Vec4;

@:native("_G")
extern class ParticleEmitter extends Entity
{
	function CountParticles():Int;
	function GetEmissionArea():Vec2;
	function GetParticleAcceleration():Vec3;
	function GetParticleColor():Vec4;
	function GetParticleScale():Vec2;
	function GetParticleTurbulence():Vec3;
	function GetParticleVelocity():Vec3;
	function GetParticleViewMode():Int;
	function Pause():Void;
	function Play():Void;
	function Reset():Void;
	function SetEmissionArea(area:Vec2):Void;

	@:overload(function(min:Float, max:Float):Void
	{
	})
	function SetParticleAcceleration(accel:Vec3):Void;

	@:overload(function(color:Vec4):Void
	{
	})
	function SetParticleColor(r:Float, g:Float, b:Float, ?a:Float):Void;

	@:overload(function(min:Float, max:Float):Void
	{
	})
	function SetParticleScale(start:Float, end:Float):Void;

	@:overload(function(max:Float):Void
	{
	})
	function SetParticleSize(min:Float, max:Float):Void;

	@:overload(function(min:Float, max:Float):Void
	{
	})
	function SetParticleTurbulence(turbulence:Vec3):Void;

	@:overload(function(max:Float):Void
	{
	})
	@:overload(function(min:Float, max:Float):Void
	{
	})
	function SetParticleVelocity(velocity:Vec3):Void;

	function SetParticleViewMode(mode:Int):Void;
	function SetLooping(loop:Bool):Void;
}

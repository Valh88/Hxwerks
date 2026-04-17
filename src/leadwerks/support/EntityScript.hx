package leadwerks.support;

/**
	Base class for Leadwerks 5 entity scripts.
	Subclasses get a generated `.lua` next to the project Entities folder; see `ScriptMacro`.
**/
@:autoBuild(leadwerks.support.EntityScriptBuilder.build())
abstract class EntityScript
{
	final function new()
	{
	}

	/** Current entity while a lifecycle method runs (set by generated Lua). **/
	@:noCompletion
	public inline function luaEntity():Dynamic
		return leadwerks.Globals._hxwerks_self_;

	/** Called when the script is attached / entity starts. **/
	@:dox(show) function start():Void
	{
	}

	/** Called every frame while the entity is active. **/
	@:dox(show) function update():Void
	{
	}
}

package leadwerks.support;

import leadwerks.Entity;

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
	public var entity(get, never):Entity;

	inline function get_entity():Entity
		return cast leadwerks.Globals._hxwerks_self_;

	@:noCompletion public inline function luaEntity():Entity
		return entity;

	/** Called when the script is attached / entity starts. **/
	@:dox(show) function start():Void
	{
	}

	/** Called every frame while the entity is active. **/
	@:dox(show) function update():Void
	{
	}
}

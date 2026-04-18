package leadwerks.support;

#if lua
import leadwerks.Entity;
#end

/**
	Base class for Leadwerks 5 entity scripts.
	**Lua:** subclasses get generated `.lua` under `Entities/HxGen` and editor `@property` support (`ScriptMacro`).
	**Cpp:** `EntityScript` is not wired for the cpp target — use `build.hxml` + Lua for entity scripts, or `Globals` / native bridge for cpp-only code (see Hxwerks `Readme.md`).
**/
#if lua
@:autoBuild(leadwerks.support.EntityScriptBuilder.build())
#end
abstract class EntityScript
{
	final function new()
	{
	}

#if lua
	/** Current entity while a lifecycle method runs (set by generated Lua). **/
	@:noCompletion
	public inline function luaEntity():Entity
		return cast leadwerks.Globals._hxwerks_self_;
#end

	/** Called when the script is attached / entity starts. **/
	@:dox(show) function start():Void
	{
	}

	/** Called every frame while the entity is active. **/
	@:dox(show) function update():Void
	{
	}
}

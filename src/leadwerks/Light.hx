package leadwerks;

@:native("_G")
extern class Light extends Entity
{
	function SetRange(a:Float, b:Float):Void;
	function GetRange():Dynamic;
	function SetArea(w:Float, h:Float):Void;
	function SetRotation(x:Float, y:Float, z:Float):Void;

	// --- Cone (spotlight) ---
	function SetConeAngles(inner:Float, outer:Float):Void;
	function GetConeAngles():Dynamic;

	// --- Falloff ---
	function SetFalloff(mode:Int):Void;
	function GetFalloff():Int;

	// --- Shadow ---
	function SetShadowmapSize(size:Int):Void;
	function GetShadowMapSize():Int;
	function SetShadowCascadeDistance(distance:Float):Void;
}

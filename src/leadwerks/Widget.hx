package leadwerks;

import leadwerks.types.IVec2;

@:native("_G")
extern class Widget
{
	var items:Array<WidgetItem>;
	var kids:Array<Widget>;
	var parent:Widget;
	var position:IVec2;
	var size:IVec2;
	var text:String;

	function AddItem(text:String):WidgetItem;
	function AddNode(text:String):Dynamic;
	function ClearItems():Void;
	function ClientSize():IVec2;
	function Disable():Void;
	function Enable():Void;
	function GetItemText(index:Int):String;
	function GetHidden():Bool;
	function GetInterface():Interface;
	function GetParent():Widget;
	function GetPosition():IVec2;
	function GetSelectedItem():WidgetItem;
	function GetSelectedNode():Dynamic;
	function GetSize():IVec2;
	function GetState():Int;
	function GetText():String;
	function GetValue():Float;
	function Paint():Void;
	function RemoveItem(index:Int):Void;
	function SetColor(r:Float, g:Float, b:Float, ?a:Float):Void;
	function SetFontBold(bold:Bool):Void;
	function SetFontScale(scale:Float):Void;
	function SetHidden(hidden:Bool):Void;
	function SetIcon(icon:Dynamic):Void;
	function SetInteractive(interactive:Bool):Void;
	function SetItemState(index:Int, state:Int):Void;
	function SetItemText(index:Int, text:String):Void;
	function SetLayout(layout:Int, ?x:Int, ?y:Int, ?w:Int, ?h:Int):Void;
	function SetParent(parent:Widget):Void;
	function SetPixmap(pixmap:Dynamic):Void;
	function SetProgress(progress:Float):Void;
	function SetShape(x:Int, y:Int, w:Int, h:Int):Void;
	function SetRange(min:Float, max:Float):Void;
	function SetState(state:Int):Void;
	function SetText(text:String):Void;
	function SetTexture(texture:Dynamic):Void;
	function SetValue(value:Float):Void;
	function SelectItem(item:WidgetItem):Void;
	function SelectNode(node:Dynamic):Void;
}

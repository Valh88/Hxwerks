package leadwerks;

@:native("_G")
extern class AssetBrowser
{
	var splitter:Dynamic;
	var treeview:Widget;
	var propertygrid:PropertyGrid;
	var searchbar:Widget;
	var addbutton:Widget;
	var scaleslider:Widget;
	var path:String;

	function Search(text:String):Void;

	@:overload(function(path:String, ?pkg:Dynamic):Bool
	{
	})
	function SelectFile(path:String):Bool;

	@:overload(function(path:String, ?pkg:Dynamic):Bool
	{
	})
	function SelectFolder(path:String):Bool;
}

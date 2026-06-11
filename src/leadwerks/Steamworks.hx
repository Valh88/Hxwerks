package leadwerks;

@:native("_G")
extern class Steamworks
{
	static function Initialize():Bool;
	static function Shutdown():Void;
	static function Update():Void;

	static function CreateLobby(maxMembers:Int, ?type:Int):Dynamic;
	static function JoinLobby(lobbyId:Dynamic):Bool;
	static function LeaveLobby():Void;
	static function GetLobbies():Array<Dynamic>;
	static function GetLobbyMembers():Array<Dynamic>;
	static function GetLobbyOwner():Dynamic;
	static function GetLobbyCapacity():Int;
	static function GetLobbyProperty(key:String):String;
	static function SetLobbyProperty(key:String, value:String):Void;

	static function SendPacket(target:Dynamic, data:String, ?sendType:Int):Void;
	static function BroadcastPacket(data:String, ?sendType:Int):Void;
	static function GetPacket():Dynamic;

	static function GetStat(name:String):Float;
	static function SetStat(name:String, value:Float):Void;
	static function AddStat(name:String, amount:Float):Void;

	static function GetLeaderboard(name:String):Dynamic;
	static function GetLeaderboardEntries(leaderboard:Dynamic, ?count:Int, ?type:Int):Array<Dynamic>;
	static function SetLeaderboardScore(leaderboard:Dynamic, score:Int):Void;

	static function UnlockAchievement(name:String):Void;

	static function GetUserId():Dynamic;
	static function GetUserName():String;
	static function GetUserAvatar(size:Int):Dynamic;
	static function GetAppId():Int;
	static function GetBuildId():Int;

	static function DlcInstalled(appId:Int):Bool;
	static function AppInstalled(appId:Int):Bool;
	static function AppSubscribed(appId:Int):Bool;

	static function InviteFriends():Void;
	static function RecordVoice(record:Bool):Void;
}

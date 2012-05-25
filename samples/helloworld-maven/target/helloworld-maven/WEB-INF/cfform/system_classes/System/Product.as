//****************************************************************************
// ActionScript Standard Library
// System.Product for Central/Breeze
//****************************************************************************

intrinsic class System.Product
{
	static function isRunning():String;
	static function isInstalled():String;
	static function launch():Boolean;
	static function download():Void;
	function onStatus( status:Object ):Void;
	
}



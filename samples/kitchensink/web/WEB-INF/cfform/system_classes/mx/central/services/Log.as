intrinsic class mx.central.services.Log {
	function Log (logLevel:Number, name:String);
	function logInfo (msg:String, level:Number):Void;
	function logDebug (msg:String):Void;
	function getDateString():String;
	function onLog():Void;
}

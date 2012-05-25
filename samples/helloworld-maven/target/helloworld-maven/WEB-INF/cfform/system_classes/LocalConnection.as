//****************************************************************************
// ActionScript Standard Library
// LocalConnection object
//****************************************************************************
           
dynamic intrinsic class LocalConnection
{
	function LocalConnection();

	function allowDomain(domain:String):Boolean;
	function allowInsecureDomain(domain:String):Boolean;
	function close():Void;
	function connect(connectionName:String):Boolean;
	function domain():String;
	function send(connectionName:String, methodName:String, args:Object):Boolean;

	function onStatus(infoObject:Object):Void;
}



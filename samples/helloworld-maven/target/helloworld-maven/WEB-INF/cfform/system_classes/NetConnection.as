//****************************************************************************
// ActionScript Standard Library
// NetConnection object
//****************************************************************************
           
intrinsic class NetConnection
{
	var isConnected:Boolean;
	var uri:String;
	
	function connect(targetURI:String):Boolean;
	function close():Void;
	function call(remoteMethod:String, resultObject:Object):Void;
	function addHeader();
	
	function onStatus(infoObject:Object):Void;
	function onResult(infoObject:Object):Void;	
}



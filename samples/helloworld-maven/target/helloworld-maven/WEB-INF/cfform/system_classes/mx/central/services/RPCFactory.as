intrinsic class mx.central.services.RPCFactory {
	var response:String;
		
	function RPCFactory (RPCUrl:String);
	function onFault (fauly:Object):Void;
	function onResult (result:Object):Void;
	function createCall (myMethod:String):Object;

}

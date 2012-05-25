import mx.central.services.RPCFactory;
dynamic intrinsic class mx.central.services.RPC {
	function serialize (rpc:RPC, args:Array):Void;
	function deserialize (rpc:RPC, success:Boolean):Void;
	function deserializeFault (faultNode:XML):Object;
	function deserializeValue (valueNode:XML):Object;
	function deserializeArray (dataNode:XML):Object;
	function deserializeStruct (structNode:XML):Object;
	function deserializeDate (dateNode:XML):Object;
	function serializeParam (argObject:Object):XML;
	function serializeParamValue (argObject:Object):XML;
	function serializeDate (argObject:Object):XML;
	function serializeArray (argObject:Object):XML;
	function serializeObject (argObject:Object):XML;	
}

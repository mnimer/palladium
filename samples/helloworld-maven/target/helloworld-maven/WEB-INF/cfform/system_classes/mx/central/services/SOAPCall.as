import mx.central.services.PendingCall;
dynamic intrinsic class mx.central.services.SOAPCall {
	var doDecoding:Boolean;
	var doLazyDecoding:Boolean;
	
	function SOAPCall (operationName:String, targetNamespace:String, endpointURI:String, logObj:Object, operationStyle:String, useStyle:String, encodingStyle:String, soapAction:String, soapVersion:String, schemaContext:Array);
	function addParameter (soapParam:String):Void;
	function asyncInvoke (inputParams:Array, callbackMethod:Object):PendingCall;

}

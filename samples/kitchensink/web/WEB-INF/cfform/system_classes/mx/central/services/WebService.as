dynamic intrinsic class mx.central.services.WebService {
	function WebService(wsdlURI:String, logObject:Object);
	function getCall (operationName:String):mx.central.services.SOAPCall;
	function onFault (fault:Object):Void;
	function onLoad (wsdlDocument:Object):Void;
}

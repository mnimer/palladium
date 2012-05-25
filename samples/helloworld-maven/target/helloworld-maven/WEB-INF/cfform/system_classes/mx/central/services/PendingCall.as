intrinsic class mx.central.services.PendingCall {
	var myCall:mx.central.services.SOAPCall;
	var request:XML;
	var response:XML;
	
	function PendingCall (myCall:String);
	function setTimeout (timeoutMS:Number):Void;
	function addHeader (headerElement:Object):Void;
	function getOutputParameter(index:Number):mx.central.services.SOAPParameter;
	function getOutputParameterByName(localName:String):mx.central.services.SOAPParameter;
	function getOutputParameterByQName(qname:Array):mx.central.services.SOAPParameter;
	function getOutputParameters():Array;
	function getOutputValue(index:Number):Object;
	function getOutputValues():Array;
	function onFault (faultObj:mx.central.services.SOAPFault);
	function onResult (resultObj:Object);
}

dynamic intrinsic class mx.central.data.LCService {
	static function createClient (interfaceObj:Object, id:String, callbackObj:Object, bSync:Boolean):LCService ;
	static function createServer (interfaceObj:Object, callbackObj:Object, bSync:Boolean):LCService;
	
	function close():Void;
	function domain():String;
	function allowDomain(domain:String):Boolean;
}

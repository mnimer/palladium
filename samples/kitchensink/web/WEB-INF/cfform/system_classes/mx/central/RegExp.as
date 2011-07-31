intrinsic class mx.central.RegExp {
	function RegExp (myString:String, myflag:String);
	var dotall:Boolean;
	function exec (string:String):Object;
	var extended:Boolean;
	var global:Boolean;
	var ignoreCase:Boolean;
	var lastIndex:Number;
	function match (string:String):Object;
	var multiline:Boolean;
	function replace (string:String, repl:String):Void;
	var source:String;
	function test (string:String):Boolean;
}

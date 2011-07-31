//****************************************************************************
// ActionScript Standard Library
// String object
//****************************************************************************

intrinsic class String
{
	function String(string:String);
	function valueOf():String;
	function toString():String;
	function toUpperCase():String;
	function toLowerCase():String;
	function charAt(index:Number):String;
	function charCodeAt(index:Number):Number;
	function concat():String;
	function endswith( endString:String ):Number; // Central API
	function indexOf(value:String, startIndex:Number):Number;
	function lastIndexOf(value:String, startIndex:Number):Number;
	function replace( re:String, repl:String ):String; // Central API
	function slice(index1:Number,index2:Number):String;
	function substring(index1:Number,index2:Number):String;
	function split(delimiter:String):Array;
	function substr(index1:Number,index2:Number):String;
	static function fromCharCode():String;
	var length:Number;
}



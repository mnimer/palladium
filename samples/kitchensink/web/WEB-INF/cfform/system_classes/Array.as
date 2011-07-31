//****************************************************************************
// ActionScript Standard Library
// Array object
//****************************************************************************

intrinsic dynamic class Array
{
	static var CASEINSENSITIVE:Number;
	static var DESCENDING:Number;
	static var UNIQUESORT:Number;
	static var RETURNINDEXEDARRAY:Number;
	static var NUMERIC:Number;

	var length:Number;
	
	function push(value):Number; // should be value: Object, but is typeless as workaround for bug #68755
	function pop():Object;
	function concat(value:Object):Array;
	function shift():Object;
	function unshift(value:Object):Number;
	function slice(startIndex:Number, endIndex:Number):Array;
	function join(delimiter:String):String;
	function splice(startIndex:Number, deleteCount:Number, value:Object):Array;
	function toString():String;
	function sort(compare, options: Number):Array; // 'compare' might be omitted so untyped. 'options' is optional.
	function reverse():Void;
	function sortOn(key, options: Number):Array; // 'key' is a String, or an Array of String. 'options' is optional.
}



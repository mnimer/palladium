//****************************************************************************
// ActionScript Standard Library
// Object object
//****************************************************************************

intrinsic class Object
{
	function Object();
	function watch(name:String, callback:Function, userData:Object):Boolean;
	function unwatch(name:String):Boolean;
	function addProperty(name:String, getter:Function, setter:Function):Boolean;
	function toString():String;
	function valueOf():Object;
	function hasOwnProperty(name:String):Boolean;
	function isPrototypeOf(theClass:Object):Boolean;
	function isPropertyEnumerable(name:String):Boolean;
	function toLocaleString():String;
	static function registerClass(name:String, theClass:Function):Boolean;
	static var prototype:Object;
	var constructor:Object;
	var __proto__:Object;
}


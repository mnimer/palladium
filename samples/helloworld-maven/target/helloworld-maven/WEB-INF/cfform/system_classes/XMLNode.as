//****************************************************************************
// ActionScript Standard Library
// XML Document Object Model
//****************************************************************************

intrinsic class XMLNode
{
	var attributes:Object;
	var childNodes:Array;
	var firstChild:XMLNode;
	var lastChild:XMLNode;
	var nextSibling:XMLNode;
	var nodeName:String;
	var nodeType:Number;
	var nodeValue:String;
	var parentNode:XMLNode;
	var previousSibling:XMLNode;

	function XMLNode(type:Number, value:String);

	function cloneNode(deep:Boolean):XMLNode;
	function removeNode():Void;
	function insertBefore(newChild:XMLNode,insertPoint:XMLNode):Void;
	function appendChild(newChild:XMLNode):Void;
	function toString():String;

	// ITreeDataProvider
	function hasChildNodes() : Boolean;
	function getChildNodes() : Array;
	
	function getData() : Object;
	function setData(data : Object);
	
	function addTreeNode(arg,data);
	function addTreeNodeAt(index,arg,data);
	function removeTreeNodeAt(index);
	function removeTreeNode();
	function removeAll();
	function getTreeNodeAt(index : Number);

	function indexOf(item : Object) : Number;
	
	function getProperty(propertyName : String);
	function setProperty(propertyName : String,propertyValue);

	function isTreeDataProvider() : Boolean;
	
	function addEventListener(event:String, handler):Void;
	function removeEventListener(event:String, handler):Void;

	function removeMenuItem(Void) : Object
	function addMenuItemAt(index:Number, arg:Object) : Object
	function addMenuItem(arg : Object) : Object
	function removeMenuItemAt(index:Number) : Object
	function getMenuItemAt(index:Number) : Object

	// We add this one manually by modifying the prototype of XMLNode (see mx.services.Namespace.as).
	function getElementsByLocalName(name:String):Array;
}


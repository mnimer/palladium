intrinsic class mx.central.controls.MAccordionTab extends MovieClip {
	var _listeners:Array;
	function addItem (label:String, data):Void;
	function addItemAt (index:Number, label:String, data:Object):Void;
	function addListener (listener:Object):Void;
	function getBaseColor (Void):String;
	function getContentBounds (Void):Object;
	function getDataProvider (Void):Object;
	function getItemAt (index:Number):Object;
	function getLength (Void):Number;
	function getSelectedIndex (Void):Number;
	function getSelectedItem (Void):Object;
	function getValue (Void):Object;
	function removeAll (Void):Void;
	function removeItemAt (index:Number, data:String, label:String):Void;
	function removeListener (listener:Object):Void;
	function replaceItemAt (index:Number):Void;
	function setBaseColor (color:Number):Void;
	function setChangeHandler (handler:String, scope:Object):Void;
	function setDataProvider (dataProvider:Object):Void;
	function setSelectedIndex (index:Number):Void;
	function setSize (width:Number, height:Number):Void;
}

intrinsic class mx.central.controls.MIconMenu extends MovieClip {
	function addItem (label:String, data:Object):Void;
	function addItemAt (index:Number, label:String, data:Object):Void;
	function clearChecked (Void):Void;
	function clearDisabled (Void):Void;
	function getCheckedIndices (Void):Array;
	function getCheckedItems (Void):Array;
	function getCheckMarks (Void):Boolean;
	function getDisabledIndices (Void):Array;
	function getEnabled (Void):Boolean;
	function getIcon (Void):MovieClip;
	function getItemAt (index:Number):Object;
	function getItemID (index:Number):String;
	function getLabel (Void):String;
	function getLabelPlacement (Void):String;
	function getLength (Void):Number;
	function getRowCount (Void):Number;
	function getSelectedIndex (Void):Number;
	function getSelectedItem (Void):Object;
	function getValue (Void):Object;
	function isDisabled (index:Number):Boolean;
	function removeAll (Void):Void;
	function removeIcon (Void):Void;
	function removeItemAt (index:Number):Void;
	function replaceAllItems (items:Array):Void;
	function replaceItemAt (index:Number, item:Object):Void;
	function setCheckedIndices (itemArray:Array):Void;
	function setChangeHandler (functionName:String, location:Object):Void;
	function setDataProvider (dataProvider:Object):Void;
	function setEnabled (enable:Boolean):Void;
	function setEnabledIndices (itemsArray:Array, state:Boolean):Void;
	function setIcon(symbol:String):Void;
	function setLabel(label:String):Void; 
	function setLabelPlacement(placement:String):Void 
	function setMenuWidth(width:Number):Void;
	function setPopUpLocation(movieclip:MovieClip) :Void;
 	function setRowCount(index:Number) :Void
 	function setSize(width:Number, height:Number):Void 
 	function showCheckmarks(state:Boolean) :Void
}

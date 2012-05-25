intrinsic class mx.central.controls.MListBox extends MovieClip {
	function addItem (label:String, data:Object):Void;
	function addItemAt (index:Number, label:String, data:Object):Void;
	function clearDisabled (Void):Void;
	function getDisabledIndices (Void):Array;
	function getEnabled (Void):Boolean;
	function getItemAt (index:Number):Object;
	function getItemID (index:Number):String;
	function getLength (Void):Number;
	function getRowCount (Void):Number;
	function getScrollPosition (Void):Number;
	function getSelectedIndex (Void):Number;
	function getSelectedIndices (Void):Array;
	function getSelectedItem (Void):Object;
	function getSelectedItems (Void):Array;
	function getSelectMultiple (Void):Boolean;
	function getValue (Void):Object;
	function isDisabled (index:Number):Boolean;
	function removeAll (Void):Void;
	function removeItemAt (index:Number):Object;
	function replaceAllItems (items:Array):Void;
	function replaceItemAt (index:Number, label:String, data:Object):Void;
	function setAutoHideScrollBar (hideScroll:Boolean):Void;
	function setChangeHandler (functionName:String, location:Object):Void;
	function setDataProvider (dataProvider:Object):Void;
	function setEnabled (enable:Boolean):Void;
	function setEnabledIndices (itemsArray:Array, state:Boolean):Void;
	function setItemSymbol (symbolID:String):Void;
	function setRowCount (rows:Number):Void;
	function setScrollPosition(index:Number):Void;
	function setSelectedIndex (index:Number):Void;
	function setSelectedIndices(indexArray:Array):Void
	function setSelectMultiple(selectMultiple:Boolean):Void;
	function setSize (width:Number, height:Number):Void;
	function setWidth(width:Number):Void;
}

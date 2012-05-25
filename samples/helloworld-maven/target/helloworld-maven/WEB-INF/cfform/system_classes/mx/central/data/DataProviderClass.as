intrinsic class mx.central.data.DataProviderClass {
	function DataProviderClass (Void);
	function addItem (item:Object):Void;
	function addItemAt (index:Number, item:Object):Void;
	function addItems (items:Object):Void;
	function addItemsAt (index:Number, items:Object):Void;
	function addListener (view:Object, doNotUpdate:Boolean):Void;
	function addEventListener (event:String, handler:Object);
	function getAllItems (Void):Array;
	function getIndexByKey (key:String, value:Object):Number;
	function getIndicesByKey (key:String, value:Object):Array;
	function getItemAt (index:Number):Object;
	function getItemByKey (key:String, value:Object):Object;
	function getItemID (index:Number):String;
	function getItemsByKey (key:String, value:Object):Array;
	function getLength (Void):Number;
	function getSortState (Void):Object;
	function removeAll (Void):Void;
	function removeItemAt (index:Number):Object;
	function removeItemsAt (index:Number, len:Number):Array;
	function removeListener (listenerObj:Object):Void;
	function removeEventListener (event:String, handler:Object);
	function replaceAllItems (items:Array):Void;
	function replaceItemAt (index:Number, item:Object):Void;
	function setItemByKey (key:String, item:Object);
	function sort (sortFunction:Function, key:String, order:String);
	function sortItems (sortFunction:Function, optionFlags):Void;
	function sortItemsBy (key:String, order:String);
	function updateItem (item:Object):Number;
	function updateItemByIndex (index:Number, item:Object):Number;
	function updateView (view:Object, eventObject:Object):Void;
	function editField (index:Number, fieldName:Number, newData ):Void
	function getEditingData (index:Number, fieldName:String);
}

intrinsic class mx.central.controls.MDialogBox extends MovieClip {
	function doClose (Void):Void;
	function doOpen (Void):Void;
	function getContent (Void):MovieClip;
	function getDataProvider (Void):Object;
	function getSelectedContent (Void):MovieClip;
	function getSelectedIndex (Void):Number;
	function getSelectedItem (Void):Object;
	function onClosed (Void):Void;
	function onContentChanged (Void):Void;
	function setDataProvider (dp:Object):Void;
	function setSelectedByData (data:String):Void;
	function setSelectedByID (linkage:String):Void;
	function setSelectedByKey (label:String, data:Object):Void;
	function setSelectedByLabel (label:String):Void;
	function setSelectedIndex (index:Number):Void;
	function setSelectedItem (item:Object):Void;
	function setSelectedNextIndex (Void):Void;
	function setSelectedPrevIndex (Void):Void;
	function setSize (width:Number, height:Number, tween:Number):Void;
	function setTitle (title:String):Void;
	function showClose (close:Boolean):Void;
	function setIsModal (modal:Boolean):Void;
}

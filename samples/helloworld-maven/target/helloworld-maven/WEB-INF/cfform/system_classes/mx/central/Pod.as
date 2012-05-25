import mx.central.Console;
interface mx.central.Pod {
	function onActivate (console:Console, podID:Number, viewerID:Number, position:Number, baseTabIndex:Number, initialData:Object):Void;
	function onDeactivate (Void):Void;
	function onNoticeEvent (event:Object, noticeData:Object, initialData:Object):Void;
	function onNetworkChange (connected:Boolean):Void;
	function getLastTabIndex (Void):Number;
	function onPositionChange (newPosition:Number):Void;
	function setBaseTabIndex (newIndex:Number):Void;
	function onSelectedItem (data:Array):Void;
}

import mx.central.Shell;
interface mx.central.Application {
	function onActivate (shell:Shell, appID:Number, shellID:Number, baseTabIndex:Number, initialData:Object):Void;
	function onDeactivate (Void):Void;
	function onResize (Void):Void;
	function onNoticeEvent (event:Object, noticeData:Object, initalData:Object):Void;
	function onNetworkChange (connected:Boolean):Void;
	function onPaymentResult (result:Boolean, transactionID:Object):Void;
	function onSelectedItem (data:Array):Void;
	function onUninstall (Void):Void;
	function showPreferences (Void):Void;
	function getMinimumSize (Void):Object;
}

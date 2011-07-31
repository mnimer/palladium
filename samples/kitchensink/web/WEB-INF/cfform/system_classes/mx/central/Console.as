intrinsic class mx.central.Console {
	function addNotice (noticeData:Object, initialData:Object):Number;
	function addPod (podData:Object):Number;
	function addToLocalInternetCache (url:String, bOverwrite:Boolean, expiration:Object):Void;
	function editLocationDialog (Void):Void;
	function getAgent (Void):Object;
	function getHeight (Void):Number;
	function getNotices (Void):Array;
	function getPods (Void):Array;
	function getPreferences (Void):Object;
	function getViewedApplications (Void):Array;
	function getViewedPods(Void):Array;
	function inLocalInternetCache (url:String):Boolean;
	function isConnected (Void):Boolean;
	function loadApplication(initialData:Object):Void;
	function newLocationDialog(reqFields:Array):Void;
	function removeFromLocalInternetCache (url:String):Void;
	function removeNotice (noticeID:Number):Boolean;
	function removePod (podID:Number):Void;
	function startAgent (Void):Boolean;
	function stopAgent (Void):Boolean;
	function viewPod (podID:Number):Void;
}

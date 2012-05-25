intrinsic class mx.central.AgentManager {
	function addNotice (noticeData:Object, initialData:Object):Number;
	function addPod (podData:Object):Number;
	function addToLocalInternetCache (url:String, bOverwrite:Boolean, expiration:Object):Void;
	function getPods (Void):Array;
	function getPreferences (Void):Object;
	function getViewedApplications (Void):Array;
	function getViewedPods(Void):Array;
	function getNotices(Void):Array;
	function inLocalInternetCache (url:String):Boolean;
	function isConsoleOpen (Void):Boolean;
	function isConnected (Void):Boolean;
	function removeFromLocalInternetCache (url:String):Void;
	function removeNotice (noticeID:Number):Boolean;
	function removePod (podID:Number):Void;
	function stopAgent (Void):Boolean;
	function viewPod (podID:Number):Void;
}

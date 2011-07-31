import mx.central.AgentManager;
interface mx.central.Agent {
	function onActivate (agentManager:AgentManager, agentID:Number, initialData:Object):Void;
	function onDeactivate (Void):Void;
	function onNoticeEvent (event:Object, noticeData:Object, initialData:Object):Void;
	function onNetworkChange (connected:Boolean):Void;
	function onUninstall (Void):Void;
}

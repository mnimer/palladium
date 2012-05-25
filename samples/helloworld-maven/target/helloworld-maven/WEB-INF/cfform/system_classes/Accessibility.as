//****************************************************************************
// ActionScript Standard Library
// Accessibility object
//****************************************************************************

intrinsic class Accessibility
{
	static function isActive():Boolean;
	static function sendEvent(mc:MovieClip, childID, event:Object, isNonHtml:Boolean):Void;
	static function updateProperties():Void;
}


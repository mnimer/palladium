//****************************************************************************
// ActionScript Standard Library
// TextSnapshot object
//****************************************************************************

intrinsic class TextSnapshot
{
	function getCount():Number;
	function setSelected(start:Number, end:Number, select:Boolean):Void;
	function getSelected(start:Number, end:Number):Boolean;
	function getText(start:Number, end:Number, includeLineEndings:Boolean):String;
	function getSelectedText(includeLineEndings:Boolean):String;
	function hitTestTextNearPos(x:Number, y:Number, closeDist:Number):Number;
	function findText(startIndex:Number, textToFind:String, caseSensitive:Boolean):Number;
	function setSelectColor(color:Number):Void;
	function getTextRunInfo(start:Number, end:Number):Array;
}



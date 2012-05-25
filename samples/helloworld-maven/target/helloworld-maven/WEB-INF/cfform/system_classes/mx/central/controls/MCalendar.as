intrinsic class mx.central.controls.MCalendar extends MovieClip {
	function getDayOfWeekNames (Void):Array;
	function getDisplayedMonth (Void):Date;
	function getDisplayRange (Void):Object;
	function getEnabled (Void):Boolean;
	function getFirstDayOfWeek (Void):Number;
	function getMonthNames (Void):Array;
	function getSelectedItem (Void):Date;
	function getSelectedItems (Void):Array;
	function getSelectionRequired (Void):Boolean;
	function getSelectionType (Void):String;
	function getShowAsDisabled (Void):Boolean;
	function setChangeHandler (callBack:String):Boolean;
	function setDateFilter (dateFilter:Object):Object;
	function setDayOfWeekNames (dayNames:Array):Void;
	function setDisplayedMonth (newMonth:Date):Void;
	function setDisplayRange (dateRange:Object):Void;
	function setEnabled (enabledFlag:Boolean):Boolean;
	function setFirstDayOfWeek (dayNumber:Number):Void;
	function setMonthNames (monthNames:Array):Void;
	function setSelectedItem (date:Date, append:Boolean):Void;
	function setSelectedItems (dates:Array, append:Boolean):Void;
	function setSelectionRequired (requiredFlag:Boolean):Void;
	function setSelectionType (type:String):Void;
	function setShowAsDisabled (disable:Boolean):Void;
	function setSize (width:Number, height:Number):Void;
}

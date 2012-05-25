//****************************************************************************
// ActionScript Standard Library
// Date object
//****************************************************************************

intrinsic class Date
{
	function Date(year:Number,month:Number,date:Number,hour:Number,min:Number,sec:Number,ms:Number);

	function getFullYear():Number;
	function getYear():Number;
	function getMonth():Number;
	function getDate():Number;
	function getDay():Number;
	function getHours():Number;
	function getMinutes():Number;
	function getSeconds():Number;
	function getMilliseconds():Number;

	function getUTCFullYear():Number;
	function getUTCYear():Number;
	function getUTCMonth():Number;
	function getUTCDate():Number;
	function getUTCDay():Number;
	function getUTCHours():Number;
	function getUTCMinutes():Number;
	function getUTCSeconds():Number;
	function getUTCMilliseconds():Number;

	function setFullYear(value:Number):Void;
	function setMonth(value:Number):Void;
	function setDate(value:Number):Void;
	function setHours(value:Number):Void;
	function setMinutes(value:Number):Void;
	function setSeconds(value:Number):Void;
	function setMilliseconds(value:Number):Void;

	function setUTCFullYear(value:Number):Void;
	function setUTCMonth(value:Number):Void;
	function setUTCDate(value:Number):Void;
	function setUTCHours(value:Number):Void;
	function setUTCMinutes(value:Number):Void;
	function setUTCSeconds(value:Number):Void;
	function setUTCMilliseconds(value:Number):Void;

	function getTime():Number;
	function setTime(value:Number):Void;
	function getTimezoneOffset():Number;
	function toString():String;
	function valueOf():Number;
	function setYear(value:Number):Void;

	static function UTC(year:Number,month:Number,date:Number,
                        hour:Number,min:Number,sec:Number,ms:Number):Number;

    //Added by Matt Chotin to allow Date to function as a tag.
    //We mess with Date.prototype in mx.core.ext.UIObjectExtensions
    var year : Number;
    var fullYear : Number;
    var month : Number;
    var date : Number
    var hours : Number;
    var minutes : Number;
    var seconds : Number;
    var milliseconds : Number;
    var time : Number;

	var UTCFullYear : Number;
	var UTCMonth : Number;
	var UTCDate : Number;
	var UTCHours : Number;
	var UTCMinutes : Number;
	var UTCSeconds : Number;
	var UTCMilliseconds : Number;
}



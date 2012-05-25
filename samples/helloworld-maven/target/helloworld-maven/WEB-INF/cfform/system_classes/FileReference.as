//****************************************************************************
// FileReference object
//****************************************************************************

intrinsic class FileReference
{
	var name:String;
	var size:Number;
	var modificationDate:Date;
	var creationDate:Date;
	var readOnly:Boolean;
	var creator:String;
	var type:String;
	var _listeners:Array;

	function browse( typelist:Array, defaultName:String ):Boolean;
	function upload( remoteURL:String ):Boolean;
	function download( remoteURL:String ):Boolean;
	function cancel():Void;
	function readFile():String;
	function readString( count:Number ):String;
	function readBytes( count:Number ):Array;
	function writeString( str:String ):Boolean;
	function writeBytes( byteArray:Array ):Boolean;
	function deleteFile():Boolean;
	function copy( newName:String ):Boolean;
	function rename( newName:String ):Boolean;
	function close():Void;
	function getPosition():Number;
	function setPosition( newPosition:Number ):Boolean;
	function create( relativePath:String, bOverWrite:Boolean ):Boolean;
	function exists( relativePath:String ):Boolean;
	function locate():Boolean;
	function open( relativePath:String ):Boolean;
	function copyIntoCache( relativePath:String ):Boolean;
	function saveAs( fileRef:Object ):Boolean;
	function move( fileRef:Object ):Boolean;
	function addListener(listener:Object):Void;
	function removeListener(listener:Object):Boolean;
	
	function onStatus( status:Object ):Void;
	
}



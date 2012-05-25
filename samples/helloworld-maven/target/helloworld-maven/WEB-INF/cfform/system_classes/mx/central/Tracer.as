intrinsic class mx.central.Tracer {
	var fbEnabled:Boolean;
	var categoriesEnabled:Boolean;
	var timingEnabled:Boolean;

	static function enable():Void;
	static function disable():Void;
	static function snoop(arg1, arg2, arg3):Void;
	static function log(arg):String;
}

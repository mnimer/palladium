class Debug
{
	static public function trace(a, b, c, d, e, f, g)
	{
		trace(      mx.data.binding.ObjectDumper.toString(a)
			+ " " + mx.data.binding.ObjectDumper.toString(b)
			+ " " + mx.data.binding.ObjectDumper.toString(c)
			+ " " + mx.data.binding.ObjectDumper.toString(d)
			+ " " + mx.data.binding.ObjectDumper.toString(e)
			+ " " + mx.data.binding.ObjectDumper.toString(f)
			+ " " + mx.data.binding.ObjectDumper.toString(g)
		);
	}
	
	static public function string(a, b, c, d, e, f, g) : String
	{
		return mx.data.binding.ObjectDumper.toString(a, b, c, d, e, f, g);
	}
};




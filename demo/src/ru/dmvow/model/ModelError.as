package ru.dmvow.model
{
	public class ModelError extends Error
	{
		public static const FORMAT_ERROR:String = "Some format error.";
		
		public function ModelError(message:Object="", id:Object=0.0)
		{
			super(message, id);
		}
	}
}
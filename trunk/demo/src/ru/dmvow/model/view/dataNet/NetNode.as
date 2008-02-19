package ru.dmvow.model.view.dataNet
{
	public class NetNode
	{
		/** Any kind of data, that came from some model */
		public var data:Object;
		/** Array of NetLink objects */
		public var links:Array = new Array();
		
		public function toString():String
		{
			return data.toString();
		}
	}
}
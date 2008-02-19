package ru.dmvow.model.sql.associationModel
{
	public class SQLItem
	{
		public var name:String;
		public var value:String;
		
		/** Source string */
		public var string:String;
		
		public function toString():String
		{
			return string; 
		}
	}
}
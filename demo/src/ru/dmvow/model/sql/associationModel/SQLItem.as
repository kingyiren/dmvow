package ru.dmvow.model.sql.associationModel
{
	import ru.dmvow.model.common.IItem;
	
	public class SQLItem implements IItem
	{
		public var name:String;
		public var value:String;
		
		/** Source string */
		public var string:String;
		
		public function get itemName():String
		{
			return name;
		}
		
		public function get itemValue():String
		{
			return value;
		}
		
		public function toString():String
		{
			return string; 
		}
	}
}
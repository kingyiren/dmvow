package ru.dmvow.model.sql.associationModel
{
	import ru.dmvow.model.common.IItem;
	
	public class SQLItem implements IItem
	{
		public var name:String;
		public var value:String;
		
		/** Source string */
		public var string:String;
		
		private var _index:Number;
		
		public function toString():String
		{
			return string; 
		}
		
		public function get itemName():String
		{
			return name;
		}
		
		public function get itemValue():String
		{
			return value;
		}
		
		public function get index():Number
		{
			return _index;
		}
		
		public function set index(value:Number):void
		{
			_index = value;
		}
	}
}
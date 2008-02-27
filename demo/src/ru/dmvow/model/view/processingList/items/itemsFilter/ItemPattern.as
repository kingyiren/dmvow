package ru.dmvow.model.view.processingList.items.itemsFilter
{
	public class ItemPattern
	{
		[Bindable]
		public var itemName:String;
		
		private var _mustHave:Boolean = true;
		
		public function toString():String
		{
			return (mustHave ? "+" : "-" ) + itemName;
		}
		
		[Bindable]
		public function set mustHave(value:Boolean):void
		{
			_mustHave = value;
		} 
		
		public function get mustHave():Boolean
		{
			return _mustHave;
		} 
	}
}
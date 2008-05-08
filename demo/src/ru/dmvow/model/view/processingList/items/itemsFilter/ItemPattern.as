package ru.dmvow.model.view.processingList.items.itemsFilter
{
	public class ItemPattern
	{
		// This is an assoc array like: 
		// [
		//	'item1' -> ['valueOfItem1-1', 'valueOfItem1-2', 'valueOfItem1-3'], 
		//	'item2' -> ['valueOfItem2-1', 'valueOfItem2-2']
		// ]
		public static var ANY_STRING:String = "Any";
		public static var itemValues:Array;
		
		[Bindable]
		public var itemName:String;
		[Bindable]
		public var itemValue:String;
		[Bindable]
		public var mustHave:Boolean = true;
		
		public function toString():String
		{
			return (mustHave ? "+" : "-" ) + itemName + " ~ " + (itemValue ? itemValue : ANY_STRING);
		}
		
		public function get availableValues():Array
		{
			var result:Array = null;
			
			if (itemName && itemValues)
				result = itemValues[itemName] as Array;
			
			return result; 
		} 
	}
}
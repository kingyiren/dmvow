package ru.dmvow.model.view.processingList.items.itemsFilter
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.view.processingList.items.ProcessingListItem;
	
	public class ItemsFilterItem extends ProcessingListItem
	{
		// These collections contain strings
		[Bindable]
		public var leftSide:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var rightSide:ArrayCollection = new ArrayCollection();
		
		public function ItemsFilterItem()
		{
			super();
			
			status = NEVER_PROCESSED;
		}
		
		override public function get name():String
		{
			return "Rule pattern: " + leftSide.source.join(", ") + " -> " + rightSide.source.join(", ");
		}
		
		override public function get status():String
		{
			return _status;
		}
		
		override public function get editable():Boolean
		{
			return true;
		}
		
	}
}
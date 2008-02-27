package ru.dmvow.view.sidePanels.filtersList.itemsFilter
{
	import flash.events.Event;

	public class EditItemsFilterEvent extends Event
	{
		public static const SAVE:String = "save";
		public static const CANCEL:String = "cancel";
		
		public function EditItemsFilterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
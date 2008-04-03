package ru.dmvow.view.sidePanels.filtersList.itemsFilter
{
	import flash.events.Event;

	public class EditFilterEvent extends Event
	{
		public static const SAVE:String = "save";
		public static const CANCEL:String = "cancel";
		
		public function EditFilterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
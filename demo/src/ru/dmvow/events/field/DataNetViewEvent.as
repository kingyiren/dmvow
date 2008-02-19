package ru.dmvow.events.field
{
	import flash.events.Event;

	public class DataNetViewEvent extends Event
	{
		public static const ACTIVATE:String = "activate";
		public static const DEACTIVATE:String = "deactivate";
		
		public function DataNetViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
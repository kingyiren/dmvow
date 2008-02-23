package ru.dmvow.events.sidePanels
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SidePanelsEvent extends CairngormEvent
	{
		public static const INITIALIZE:String = "side_panels_event_initialize";
		public static const REMOVE_MODEL:String = "side_panels_event_remove_model";
		public static const ADD_MODEL:String = "side_panels_event_add_model";
		public static const ADD_INTERESTING_MEASURE:String = "side_panels_event_add_interesting_measure";
		
		public function SidePanelsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
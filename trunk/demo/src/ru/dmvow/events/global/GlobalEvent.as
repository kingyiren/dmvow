package ru.dmvow.events.global
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GlobalEvent extends CairngormEvent
	{
		public static const INITIALIZE:String = "global_event_initialize";
		
		public function GlobalEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
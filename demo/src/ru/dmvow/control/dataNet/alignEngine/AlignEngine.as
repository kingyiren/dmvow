package ru.dmvow.control.dataNet.alignEngine
{
	import flash.events.Event;
	
	import ru.dmvow.events.field.DataNetViewEvent;
	import ru.dmvow.view.field.dataNet.DataNetView;
	
	public class AlignEngine
	{
		public static const DEFAULT_ALIGN:String = "default_align";
		protected static const TIMER_DELAY:Number = 1000/24;
		protected static var dataNetView:DataNetView;
		protected static var defaultAlgorythm:DefaultAlgorythm = new DefaultAlgorythm();
		
		public static function align(target:DataNetView, type:String = DEFAULT_ALIGN):void
		{
			dataNetView = target;
			dataNetView.addEventListener(DataNetViewEvent.DEACTIVATE, onDataNetViewDeactivate);
			
			defaultAlgorythm.apply(dataNetView);
		}
		
		protected static function onDataNetViewDeactivate(event:Event):void
		{
			dataNetView = null;
		}
	}
}
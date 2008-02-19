package ru.dmvow.commands.global
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import ru.dmvow.events.sidePanels.SidePanelsEvent;

	public class GlobalInitializeCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{
			var loadedModelsEvent:SidePanelsEvent = 
				new SidePanelsEvent(SidePanelsEvent.INITIALIZE);
			loadedModelsEvent.dispatch();
		}
	}
}
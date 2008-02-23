package ru.dmvow.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import ru.dmvow.commands.global.GlobalInitializeCommand;
	import ru.dmvow.commands.sidePanels.AddInterestingMeasureSaveCommand;
	import ru.dmvow.commands.sidePanels.SidePanelsAddModelCommand;
	import ru.dmvow.commands.sidePanels.SidePanelsInitializeCommand;
	import ru.dmvow.commands.sidePanels.SidePanelsRemoveModelCommand;
	import ru.dmvow.events.global.GlobalEvent;
	import ru.dmvow.events.sidePanels.SidePanelsEvent;

	public class DMVoWController extends FrontController
	{
		public function DMVoWController()
		{
			initialiseCommands();
        }
     
        public function initialiseCommands() : void
        {
			addCommand(GlobalEvent.INITIALIZE, GlobalInitializeCommand);
			addCommand(SidePanelsEvent.INITIALIZE, SidePanelsInitializeCommand);
			addCommand(SidePanelsEvent.ADD_MODEL, SidePanelsAddModelCommand);
			addCommand(SidePanelsEvent.REMOVE_MODEL, SidePanelsRemoveModelCommand);
			addCommand(SidePanelsEvent.ADD_INTERESTING_MEASURE, AddInterestingMeasureSaveCommand);
        }
	}
}
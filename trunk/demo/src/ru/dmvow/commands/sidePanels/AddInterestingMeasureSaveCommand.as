package ru.dmvow.commands.sidePanels
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;

	public class AddInterestingMeasureSaveCommand implements ICommand
	{
		public function AddInterestingMeasureSaveCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			DMVoW.instance.model.interestingMeasures.addItem(event.data);
		}
	}
}
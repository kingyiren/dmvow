package ru.dmvow.commands.sidePanels
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import ru.dmvow.model.DataModel;

	public class SidePanelsAddModelCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{
			DMVoW.instance.model.models.addItem(DataModel(event.data));
		}
	}
}
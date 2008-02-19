package ru.dmvow.commands.sidePanels
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SidePanelsRemoveModelCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{
			DMVoW.instance.model.models.removeItemAt(Number(event.data));
		}
	}
}
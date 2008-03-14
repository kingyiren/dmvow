package ru.dmvow.view.sidePanels.loadedModels
{
import flash.events.Event;

public class FileSelectorEvent extends Event
{
	public static const BROWSE:String = "browse";
	public static const LOCAL_PATH_LOAD:String = "localPathLoad";
	
	public function FileSelectorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
}
}
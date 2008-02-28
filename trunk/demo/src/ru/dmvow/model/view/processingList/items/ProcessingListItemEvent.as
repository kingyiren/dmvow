package ru.dmvow.model.view.processingList.items
{
import flash.events.Event;

public class ProcessingListItemEvent extends Event
{
	// Change of the internal structure that may discard the previous processing results
	public static const DESCRIPTION_CHANGE:String = "processingListItemDescriptionChange";
	
	public function ProcessingListItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
}
}
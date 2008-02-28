package ru.dmvow.view.sidePanels.filtersList
{
import flash.events.Event;

import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class FiltersListItemEvent extends Event
{
	public static const EDIT:String = "filtersListItemEdit";
	public static const REMOVE:String = "filtersListItemRemove";
	public static const SHOW:String = "filtersListItemShow";
	
	public var item:ProcessingListItem;
	
	public function FiltersListItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
}
}
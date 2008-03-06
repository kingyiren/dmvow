package ru.dmvow.model.view.processingList
{
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.ProcessingListItemEvent;

public class ProcessingList extends ArrayCollection
{
	[Bindable]
	public var working:Boolean = false;
	[Bindable]
	public var progress:Number = 0;
	[Bindable]
	public var selectedItem:ProcessingListItem;
	
	public function ProcessingList(source:Array=null)
	{
		super(source);
	}
	
	override public function addItemAt(item:Object, index:int):void
	{
		super.addItemAt(item, index);
		
		var pItem:ProcessingListItem = ProcessingListItem(item);
		pItem.addEventListener(ProcessingListItemEvent.DESCRIPTION_CHANGE, onDescriptionChange, false, 0, true);
	}
	
	override public function removeItemAt(index:int):Object
	{
		var item:Object = super.removeItemAt(index);
		
		var pItem:ProcessingListItem = ProcessingListItem(item);
		pItem.removeEventListener(ProcessingListItemEvent.DESCRIPTION_CHANGE, onDescriptionChange);
		
		return item;
	}
	
	private function onDescriptionChange(event:ProcessingListItemEvent):void
	{
		var index:Number = this.getItemIndex(event.target);
		var changeEvent:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, false, null, index, index);
		dispatchEvent(changeEvent); 
	}
}
}
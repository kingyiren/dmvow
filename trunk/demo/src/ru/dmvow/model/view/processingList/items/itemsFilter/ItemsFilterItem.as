package ru.dmvow.model.view.processingList.items.itemsFilter
{
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class ItemsFilterItem extends ProcessingListItem
{
	// These collections contain strings
	[Bindable]
	public var leftSide:ArrayCollection = new ArrayCollection();
	[Bindable]
	public var rightSide:ArrayCollection = new ArrayCollection();
	
	public function ItemsFilterItem()
	{
		super();
		
		status = NEVER_PROCESSED;
		
		leftSide.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionsChange, false, 0, true);
		rightSide.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionsChange, false, 0, true);
		
		onCollectionsChange(null);
	}
	
	override public function get status():String
	{
		return _status;
	}
	
	override public function get editable():Boolean
	{
		return true;
	}
	
	override public function get removable():Boolean
	{
		return true;
	}
	
	override protected function getCurrentDescriptionText():String
	{
		// The source description never changes
		return _name;
	}
	
	private function onCollectionsChange(event:Event):void
	{
		name = "Rule pattern: " + leftSide.source.join(", ") + " -> " + rightSide.source.join(", ");
		
		updateDescription();
	}
}
}
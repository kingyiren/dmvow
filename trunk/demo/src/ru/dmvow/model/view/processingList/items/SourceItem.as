package ru.dmvow.model.view.processingList.items
{
public class SourceItem extends ProcessingListItem
{
	public function SourceItem()
	{
		super();
		
		name = "Source data";
	}
	
	override protected function getCurrentDescriptionText():String
	{
		// The source description never changes
		return "source";
	}
}
}
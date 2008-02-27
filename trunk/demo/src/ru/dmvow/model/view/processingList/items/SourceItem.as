package ru.dmvow.model.view.processingList.items
{
	public class SourceItem extends ProcessingListItem
	{
		public function SourceItem()
		{
			super();
		}
		
		override public function get name():String
		{
			return "Source data";
		}
		
		override public function get status():String
		{
			return EMPTY;
		}
	}
}
package ru.dmvow.model.view.processingList.history
{
public class ProcessingData
{
	// Here we store the HistoryItem objects
	// The description of the list item, that
	// holds this ProcessingData object is stored
	// separatly.
	public var items:Array = new Array();
	
	public function equalTo(history:ProcessingData):Boolean
	{
		var result:Boolean = true;
		
		if (items.length == history.items.length)
		{
			for (var i:Number = 0; i < items.length; i++)
			{
				if (!ProcessingItemDescription(items[i]).equalTo(ProcessingItemDescription(history.items[i])))
				{
					result = false;
					break;
				} 
			}
		}
		else
		{
			result = false;
		}
		
		return result;
	}
	
	public function clone():ProcessingData
	{
		var result:ProcessingData = new ProcessingData();
		for (var i:Number = 0; i < items.length; i++)
			result.items.push(ProcessingItemDescription(items[i]).clone());
			
		return result;
	}
}
}
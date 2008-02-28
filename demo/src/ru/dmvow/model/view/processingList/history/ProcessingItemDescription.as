package ru.dmvow.model.view.processingList.history
{
public class ProcessingItemDescription
{
	// This string describes the processing list item settings
	// Any change of this string means that we need to reprocess
	// the data to get the valid result.
	public var description:String;
	
	public function clone():ProcessingItemDescription
	{
		var result:ProcessingItemDescription = new ProcessingItemDescription();
		result.description = description;
		return result;
	}
	
	public function equalTo(value:ProcessingItemDescription):Boolean
	{
		return (value.description == description);
	}
}
}
package ru.dmvow.model.view
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.view.processingList.ProcessingList;
	
	public class DMVoWModel
	{
		[Bindable]
		[ArrayElementType("ru.dmvow.model.DataModel")] 
		public var models:ArrayCollection;
		[Bindable]
		public var selectedModel:DataModel;
		[Bindable]
		public var interestingMeasures:ArrayCollection = new ArrayCollection();
	}
}
package ru.dmvow.model.view.interestingMeasures
{
	import mx.collections.ArrayCollection;
	
	public class InterestingMeasure
	{
		[Bindable]
		public var simpleMeasures:ArrayCollection = new ArrayCollection();
		public var name:String;
		
		public function InterestingMeasure()
		{
		}
		
		public function toString():String
		{
			if (name)
				return name;
			else
				return simpleMeasures.source.join("-");
		}
	}
}
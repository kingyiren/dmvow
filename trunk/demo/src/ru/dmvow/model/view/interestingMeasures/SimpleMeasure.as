package ru.dmvow.model.view.interestingMeasures
{
	[RemoteClass]
	public class SimpleMeasure
	{
		public static const SUPPORT:String = "support";
		public static const CONFIDENCE:String = "confidence";
		public static const LIFT:String = "lift";
		public static const LEVERAGE:String = "leverage";
		public static const COVERAGE:String = "coverage";
		
		public var type:String;
		
		public function SimpleMeasure(type:String = null)
		{
			this.type = type;
		}
		
		public function toString():String
		{
			return type;
		}
	}
}
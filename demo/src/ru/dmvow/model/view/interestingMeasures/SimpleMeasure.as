package ru.dmvow.model.view.interestingMeasures
{
	public class SimpleMeasure
	{
		public static const SUPPORT:String = "Support";
		public static const CONFIDENCE:String = "Confidence";
		public static const LIFT:String = "Lift";
		public static const LEVERAGE:String = "Leverage";
		public static const COVERAGE:String = "Coverage";
		
		[Bindable]
		public var type:String;
		/**
		 * If true, we are more interested in objects, that have
		 * the highest value of this measure. If false, then we
		 * are interested in lowest values.
		 */
		[Bindable]
		public var isUp:Boolean = true;
		public var _enabled:Boolean = false;
		
		public function SimpleMeasure(type:String = null, isUp:Boolean = true)
		{
			this.type = type;
			this.isUp = isUp;
		}
		
		public function toString():String
		{
			return (isUp ? "↑" : "↓") + type;
		}
		
		public function get description():String
		{
			var result:String;
			
			if (type == SUPPORT)
			{
				result = "Support(X) = P(X). It's values are in range [0, 1].";
			}
			else if (type == CONFIDENCE)
			{
				result = "Confidence(X → Y) = P(X and Y)/P(X). It's values are in range [0, 1].";
			}
			else if (type == LIFT)
			{
				result = "Lift(X → Y) = P(X and Y)/[P(X) * P(Y)]. It's values are in range [0, +inf].";
			}
			else if (type == LEVERAGE)
			{
				result = "Leverage(X → Y) = P(X and Y) -([P(X) * P(Y)). It's values are in range [0, 1).";
			}
			else if (type == COVERAGE)
			{
				result = "Coverage(X → Y) = P(X and Y)/P(Y). It's values are in range [0, 1].";
			}
			
			return result;
		}
		
		[Bindable]
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
	}
}
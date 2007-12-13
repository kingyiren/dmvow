package ru.dmvow.model.pmml.models
{
	import ru.dmvow.model.pmml.common.Extendable;
	import ru.dmvow.model.pmml.models.common.LocalTransformations;
	import ru.dmvow.model.pmml.models.common.MiningSchema;
	import ru.dmvow.model.pmml.models.common.ModelStats;
	
	public class MiningModel extends Extendable
	{
		public var name:String;
		/**
		 * Value from MINING_FUNCTION.
		 */
		public var functionName:String;
		public var algorithmName:String;
		
		public var miningSchema:MiningSchema;
		/**
		 * Can be null.
		 */
		public var modelStats:ModelStats;
		/**
		 * Can be null.
		 */
		public var localTransformations:LocalTransformations;
		
	}
}
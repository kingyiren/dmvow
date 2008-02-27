package ru.dmvow.model.pmml
{
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.common.IData;

	public class PMMLMiningModel extends DataModel
	{
		public var pmmlData:PMML; 
		
		public function PMMLMiningModel()
		{
			source = DataModel.FROM_PMML;
		} 
		
		override public function set data(value:IData):void
		{
			if (value && !(value is PMML))
				throw new Error("Can handle only PMML data here.");
			
			pmmlData = value as PMML;
		}
		
		override public function get data():IData
		{
			return pmmlData;
		}
	}
}
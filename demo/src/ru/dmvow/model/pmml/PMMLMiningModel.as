package ru.dmvow.model.pmml
{
	import ru.dmvow.model.DataModel;

	public class PMMLMiningModel extends DataModel
	{
		public function PMMLMiningModel()
		{
			source = DataModel.FROM_PMML;
		} 
		
		public var data:PMML;
	}
}
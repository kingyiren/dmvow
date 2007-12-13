package ru.dmvow.control.boundary
{
	import ru.dmvow.model.pmml.models.MiningModel;
	
	public class MiningModelParser
	{
		public function parseMiningModel(xml:XML, toModel:MiningModel):void
		{
			toModel.functionName = xml.@functionName;
		}
	}
}
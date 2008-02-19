package ru.dmvow.control.boundary.pmmlParser
{
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationModel;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationRule;
	import ru.dmvow.model.pmml.models.associationModel.PMMLItem;
	import ru.dmvow.model.pmml.models.associationModel.PMMLItemset;
	
	public class AssociationModelParser extends MiningModelParser
	{
		public function parseAssociationModel(xml:XML, model:PMMLAssociationModel = null):PMMLAssociationModel
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:PMMLAssociationModel = (model? model: new PMMLAssociationModel());
			
			parseMiningModel(xml, result);
			result.numberOfTransactions = int(xml.@numberOfTransactions);
			result.numberOfItems = int(xml.@numberOfItems);
			result.minimumSupport = Number(xml.@minimumSupport);
			result.minimumConfidence = Number(xml.@minimumConfidence);
			result.numberOfItemsets = int(xml.@numberOfItemsets);
			result.numberOfRules = int(xml.@numberOfRules);
			
			var node:XML;
			for each (node in xml.Item)
			{
				result.items.addItem(parseItem(node, result));
			}
			
			for each (node in xml.Itemset)
			{
				result.itemsets.addItem(parseItemset(node, result));
			}
			
			for each (node in xml.AssociationRule)
			{
				result.associationRules.addItem(parseAssociationRule(node, result));
			}
			
			return result;
		}
		
		protected function parseItem(xml:XML, model:PMMLAssociationModel):PMMLItem
		{
			var result:PMMLItem = new PMMLItem();
			
			result.id = xml.@id;
			result.value = xml.@value;
			if (xml.attribute("mappedValue").length() > 0)
				result.mappedValue = xml.@mappedValue;
			if (xml.attribute("weight").length() > 0)
				result.weight = xml.@weight;
			
			return result;
		}
		
		protected function parseItemset(xml:XML, model:PMMLAssociationModel):PMMLItemset
		{
			var result:PMMLItemset = new PMMLItemset();
			
			result.id = xml.@id;
			if (xml.attribute("support").length() > 0)
				result.support = Number(xml.@support);
			if (xml.attribute("numberOfItems").length() > 0)
				result.numberOfItems = uint(xml.@numberOfItems);
			
			for each (var node:XML in xml.ItemRef)
			{
				result.items.addItem(model.getItemById(node.@itemRef));
			}
			
			return result;
		}
		
		protected function parseAssociationRule(xml:XML, model:PMMLAssociationModel):PMMLAssociationRule
		{
			var result:PMMLAssociationRule = new PMMLAssociationRule();
			
			result.antecedent = model.getItemsetById(xml.@antecedent);
			result.consequent = model.getItemsetById(xml.@consequent);
			result.support = Number(xml.@support);
			result.confidence = Number(xml.@confidence);
			if (xml.attribute("lift").length() > 0)
				result.lift = Number(xml.@lift);
			if (xml.attribute("id").length() > 0)
				result.id = xml.@id;
			
			return result;
		}
	}
}
package ru.dmvow.control.boundary
{
	import ru.dmvow.model.pmml.models.associationModel.AssociationModel;
	import ru.dmvow.model.pmml.models.associationModel.AssociationRule;
	import ru.dmvow.model.pmml.models.associationModel.Item;
	import ru.dmvow.model.pmml.models.associationModel.Itemset;
	
	public class AssociationModelParser extends MiningModelParser
	{
		public function parseAssociationModel(xml:XML):AssociationModel
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:AssociationModel = new AssociationModel();
			
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
				result.items.push(parseItem(node));
			}
			
			for each (node in xml.Itemset)
			{
				result.itemsets.push(parseItemset(node, result));
			}
			
			for each (node in xml.AssociationRule)
			{
				result.associationRules.push(parseAssociationRule(node, result));
			}
			
			return result;
		}
		
		protected function parseItem(xml:XML):Item
		{
			var result:Item = new Item();
			
			result.id = xml.@id;
			result.value = xml.@value;
			if (xml.attribute("mappedValue").length() > 0)
				result.mappedValue = xml.@mappedValue;
			if (xml.attribute("weight").length() > 0)
				result.weight = xml.@weight;
			
			return result;
		}
		
		protected function parseItemset(xml:XML, model:AssociationModel):Itemset
		{
			var result:Itemset = new Itemset();
			
			result.id = xml.@id;
			if (xml.attribute("support").length() > 0)
				result.support = Number(xml.@support);
			if (xml.attribute("numberOfItems").length() > 0)
				result.numberOfItems = uint(xml.@numberOfItems);
			
			for each (var node:XML in xml.ItemRef)
			{
				result.items.push(model.getItemById(node.@itemRef));
			}
			
			return result;
		}
		
		protected function parseAssociationRule(xml:XML, model:AssociationModel):AssociationRule
		{
			var result:AssociationRule = new AssociationRule();
			
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
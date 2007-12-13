package ru.dmvow.control.boundary
{
	import ru.dmvow.model.custom.models.assotiationModel.CustomItem;
	import ru.dmvow.model.pmml.models.associationModel.Item;
	
	public class CustomAssociationModelParser extends AssociationModelParser
	{
		override protected function parseItem(xml:XML):Item
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:CustomItem = new CustomItem();
			
			result.id = xml.@id;
			result.value = xml.@value;
			if (xml.attribute("mappedValue").length() > 0)
				result.mappedValue = xml.@mappedValue;
			if (xml.attribute("weight").length() > 0)
				result.weight = xml.@weight;
			result.className = xml.Extension.@value;
			
			return result;
		}
	}
}
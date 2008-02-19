package ru.dmvow.control.boundary.pmmlParser
{
	import ru.dmvow.model.custom.models.assotiationModel.CustomAssociationModel;
	import ru.dmvow.model.custom.models.assotiationModel.CustomItem;
	import ru.dmvow.model.custom.models.assotiationModel.ItemClass;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationModel;
	import ru.dmvow.model.pmml.models.associationModel.PMMLItem;
	
	public class CustomAssociationModelParser extends AssociationModelParser
	{
		override public function parseAssociationModel(xml:XML, model:PMMLAssociationModel = null):PMMLAssociationModel
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:CustomAssociationModel = (model ? model as CustomAssociationModel : new CustomAssociationModel());
			
			var node:XML;
			for each (node in xml.Extension.(@name == "ItemClass"))
			{
				result.itemClasses.addItem(parseItemClass(node));
			}
			
			super.parseAssociationModel(xml, result);
			
			return result;
		}
		
		override protected function parseItem(xml:XML, model:PMMLAssociationModel):PMMLItem
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:CustomItem = new CustomItem();
			
			result.id = xml.@id;
			result.value = xml.@value;
			if (xml.attribute("mappedValue").length() > 0)
				result.mappedValue = xml.@mappedValue;
			if (xml.attribute("weight").length() > 0)
				result.weight = xml.@weight;
			result.itemClass = (model as CustomAssociationModel).
				getItemClassById(xml.Extension.(@name == "classId").@value);
			
			return result;
		}
		
		protected function parseItemClass(xml:XML):ItemClass
		{
			var result:ItemClass = new ItemClass();
			
			result.id = xml.ItemClassId;
			result.className = xml.ItemClassName;
			
			return result;
		}
	}
}
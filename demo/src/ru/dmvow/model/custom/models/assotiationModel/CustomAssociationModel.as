package ru.dmvow.model.custom.models.assotiationModel
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationModel;

	public class CustomAssociationModel extends PMMLAssociationModel
	{
		[Bindable]
		public var itemClasses:ArrayCollection = new ArrayCollection();
		
		public function CustomAssociationModel()
		{
			super();
		}
		
		public function getItemClassById(id:String):ItemClass
		{
			for (var i:Number = 0; i < itemClasses.length; i++)
			{
				var itemClass:ItemClass = (itemClasses[i] as ItemClass);
				if (itemClass.id == id)
					return itemClass;
			}
			
			return null;
		}
		
	}
}
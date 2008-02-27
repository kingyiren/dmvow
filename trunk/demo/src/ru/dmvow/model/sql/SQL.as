package ru.dmvow.model.sql
{
	import ru.dmvow.model.common.IClone;
	import ru.dmvow.model.common.IData;
	import ru.dmvow.model.common.IDataModel;
	import ru.dmvow.model.sql.associationModel.SQLAssociationModel;
	
	public class SQL implements IClone, IData
	{
		/** MODEL_CATALOG */
		[Bindable]
		public var catalog:String;
		[Bindable]
		public var model:SQLAssociationModel;
		
		public function clone():Object
		{
			var result:SQL = new SQL();
			result.catalog = catalog;
			result.model = model.clone();
			
			return result;
		}
		
		public function get dataName():String
		{
			return catalog;
		}
		
		public function get dataModel():IDataModel
		{
			return model;
		}
	}
}
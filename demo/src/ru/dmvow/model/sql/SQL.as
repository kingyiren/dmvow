package ru.dmvow.model.sql
{
	import ru.dmvow.model.common.IData;
	import ru.dmvow.model.common.IDataModel;
	import ru.dmvow.model.sql.associationModel.SQLAssociationModel;
	
	public class SQL implements IData
	{
		/** MODEL_CATALOG */
		[Bindable]
		public var catalog:String;
		[Bindable]
		public var model:SQLAssociationModel;
		
		public function clone():IData
		{
			var result:SQL = new SQL();
			
			result.catalog = catalog;
			result.model = model.clone() as SQLAssociationModel;
			
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
package ru.dmvow.model.sql
{
	import ru.dmvow.model.sql.associationModel.SQLAssociationModel;
	
	public class SQL
	{
		/** MODEL_CATALOG */
		[Bindable]
		public var catalog:String;
		[Bindable]
		public var model:SQLAssociationModel;
	}
}
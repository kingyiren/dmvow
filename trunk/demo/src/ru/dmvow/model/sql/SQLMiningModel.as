package ru.dmvow.model.sql
{
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.common.IData;

	public class SQLMiningModel extends DataModel
	{
		public var sqlData:SQL; 
		
		public function SQLMiningModel()
		{
			source = DataModel.FROM_SQL;
		}
		
		override public function set data(value:IData):void
		{
			if (value && !(value is SQL))
				throw new Error("Can handle only SQL data here.");
			
			sqlData = value as SQL;
		}
		
		override public function get data():IData
		{
			return sqlData;
		}
	}
}
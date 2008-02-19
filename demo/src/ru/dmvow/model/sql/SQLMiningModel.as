package ru.dmvow.model.sql
{
	import ru.dmvow.model.DataModel;

	public class SQLMiningModel extends DataModel
	{
		public function SQLMiningModel()
		{
			source = DataModel.FROM_SQL;
		}
		
		public var data:SQL;
	}
}
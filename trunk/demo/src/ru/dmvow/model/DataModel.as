package ru.dmvow.model
{
import ru.dmvow.model.common.IData;
import ru.dmvow.model.supportTree.SupportTree;
import ru.dmvow.model.view.processingList.ProcessingList;

public class DataModel
{
	public static const FROM_PMML:String = "from_pmml";
	public static const FROM_SQL:String = "from_sql";
	public var name:String = "(Имя не задано)";
	public var source:String = "(Источник неизвестен)";
	[Bindable]
	public var processingList:ProcessingList;
	public var supportTree:SupportTree;
	
	public function set data(value:IData):void
	{
	}
	
	public function get data():IData
	{
		return null;
	}
}
}
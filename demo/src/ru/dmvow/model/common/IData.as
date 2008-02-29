package ru.dmvow.model.common
{
	public interface IData
	{
		function clone():IData;
		function get dataName():String;
		function get dataModel():IDataModel;
	}
}
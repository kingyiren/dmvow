package ru.dmvow.model.common
{
	import mx.collections.ArrayCollection;
	
	public interface IDataModel
	{
		function clone():IDataModel;
		function get modelItems():ArrayCollection;
		function get modelItemsets():ArrayCollection;
		function get modelRules():ArrayCollection;
	}
}
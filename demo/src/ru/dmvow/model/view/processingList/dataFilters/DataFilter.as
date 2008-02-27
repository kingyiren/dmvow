package ru.dmvow.model.view.processingList.dataFilters
{
	public class DataFilter
	{
		public function DataFilter()
		{
			super();
		}
		
		public function equalTo(filter:DataFilter):Boolean
		{
			return true;
		}
		
		public function clone():DataFilter
		{
			return new DataFilter();
		}
	}
}
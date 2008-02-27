package ru.dmvow.control
{
	import flash.events.EventDispatcher;
	
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.view.processingList.ProcessingList;
	import ru.dmvow.model.view.processingList.items.SourceItem;

	public class FiltersListController extends EventDispatcher
	{
		private var _model:DataModel;
		private var _processingList:ProcessingList;
		
		public function FiltersListController()
		{
		}
		
		public function set model(value:DataModel):void
		{
			_model = value;
			
			handleModel();
		}
		
		public function get model():DataModel
		{
			return _model;
		}
		
		private function handleModel():void
		{
			if (_model)
			{
				if (!_model.processingList)
				{
					_model.processingList = new ProcessingList();
					var sourceItem:SourceItem = new SourceItem();
					sourceItem.isCurrent = true;
					sourceItem.data = _model.data;
					_model.processingList.addItem(sourceItem);
				}
			}
		}
	}
}
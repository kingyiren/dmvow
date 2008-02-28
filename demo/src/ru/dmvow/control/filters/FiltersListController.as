package ru.dmvow.control.filters
{
	import flash.events.EventDispatcher;
	
	import mx.events.CollectionEvent;
	
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.view.processingList.ProcessingList;
	import ru.dmvow.model.view.processingList.history.ProcessingData;
	import ru.dmvow.model.view.processingList.history.ProcessingItemDescription;
	import ru.dmvow.model.view.processingList.items.ProcessingListItem;
	import ru.dmvow.model.view.processingList.items.SourceItem;

	public class FiltersListController extends EventDispatcher
	{
		private var _model:DataModel;
		private var _processingList:ProcessingList;
		private var working:Boolean = false;
		
		public function FiltersListController()
		{
		}
		
		public function set model(value:DataModel):void
		{
			clearModel();
			
			_model = value;
			
			initFromModel();
		}
		
		public function get model():DataModel
		{
			return _model;
		}
		
		private function clearModel():void
		{
			if (_model)
			{
				_model.processingList.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onProcessingListChange);
			}
		}
		
		private function initFromModel():void
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
				
				_model.processingList.addEventListener(CollectionEvent.COLLECTION_CHANGE, onProcessingListChange, false, 0, true);
			}
		}
		
		private function getProcessingData(index:Number):ProcessingData
		{
			var result:ProcessingData = new ProcessingData();
			
			for (var i:Number = 0; i < index; i++)
			{
				var clonedDescription:ProcessingItemDescription = ProcessingListItem(_model.processingList.getItemAt(i)).description.clone();
				result.items.push(clonedDescription);
			}
			
			return result;
		}
		
		private function onProcessingListChange(event:CollectionEvent):void
		{
			if (working)
				return;
			
			working = true;
			
			var updateStartIndex:Number = 0;
			if (event != null)
			{
				if (event.location >= 0 && event.location == event.oldLocation)
				{
					// Out event - item has changed by itself
					// Update ProcessingList's of all items after this one
					updateStartIndex = event.location + 1;
				}
				else
				{
					// Standart event dispatching
					if (event.oldLocation == -1 && event.location == -1)
					{
						throw new Error("Can't understand this message");
					}
					else if (event.oldLocation == -1)
					{
						// Something added
						updateStartIndex = event.location;
					}
					else if (event.location == -1)
					{
						// Something removed
						updateStartIndex = event.oldLocation;
					}
					else if (event.location >= 0 && event.location >= 0)
					{
						// Something moved
						updateStartIndex = Math.min(event.location, event.oldLocation);
					}
				}
			}
			
			for (var i:Number = updateStartIndex; i < _model.processingList.length; i++)
			{
				ProcessingListItem(_model.processingList.getItemAt(i)).processingData = getProcessingData(i);
			}
			
			working = false;
		}
	}
}
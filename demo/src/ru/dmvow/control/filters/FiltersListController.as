package ru.dmvow.control.filters
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

import mx.events.CollectionEvent;

import ru.dmvow.control.filters.workers.AbstractWorker;
import ru.dmvow.control.filters.workers.ClusteringWorker;
import ru.dmvow.control.filters.workers.InterestingMeasureFilterWorker;
import ru.dmvow.control.filters.workers.ItemsFilterWorker;
import ru.dmvow.model.DataModel;
import ru.dmvow.model.common.IData;
import ru.dmvow.model.view.DMVoWModel;
import ru.dmvow.model.view.processingList.ProcessingList;
import ru.dmvow.model.view.processingList.history.ProcessingData;
import ru.dmvow.model.view.processingList.history.ProcessingItemDescription;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.SourceItem;
import ru.dmvow.model.view.processingList.items.clusterFilter.ClusterFilterItem;
import ru.dmvow.model.view.processingList.items.interestingMeasureFilter.InterestingMeasureFilterItem;
import ru.dmvow.model.view.processingList.items.itemsFilter.ItemsFilterItem;
import ru.dmvow.view.sidePanels.filtersList.FiltersList;
import ru.dmvow.view.sidePanels.filtersList.FiltersListItemEvent;

public class FiltersListController extends EventDispatcher
{
	private var _model:DataModel;
	private var _dmvowModel:DMVoWModel;
	private var _processingList:ProcessingList;
	private var _filtersList:FiltersList;
	private var _currentFilterWorker:AbstractWorker;
	private var working:Boolean = false;
	// Contains WorkersListItems
	private var startingData:IData;
	private var workersList:Array = new Array();
	private var workersListIndex:Number = 0;
	
	public function FiltersListController()
	{
	}
	
	public function set filtersList(value:FiltersList):void
	{
		if (_filtersList)
		{
			_filtersList.removeEventListener(FiltersListItemEvent.SHOW, onItemShow);
		}
		
		_filtersList = value;
		
		if (_filtersList)
		{
			_filtersList.addEventListener(FiltersListItemEvent.SHOW, onItemShow, false, 0, true);
		}
	}
	
	public function get filtersList():FiltersList
	{
		return _filtersList;
	}
	
	[Bindable]
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
			
	[Bindable]
	public function set dmvowModel(value:DMVoWModel):void
	{
		_dmvowModel = value;
	}
	
	public function get dmvowModel():DMVoWModel
	{
		return _dmvowModel;
	}
	
	private function getWorkerFactoryMethod(item:ProcessingListItem):AbstractWorker
	{
		var result:AbstractWorker;
		if (item is ItemsFilterItem)
			result = new ItemsFilterWorker();
		else if (item is InterestingMeasureFilterItem)
			result = new InterestingMeasureFilterWorker();
		else if (item is ClusterFilterItem)
			result = new ClusteringWorker(filtersList.dmvowModel.selectedModel);
		else
			throw new Error("Can't find appropriate worker.");
			
		return result;
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
				sourceItem.data = _model.data;
				_model.processingList.addItem(sourceItem);
				
				showItem(sourceItem);
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
	
	private function setProgress(value:Number):void
	{
		model.processingList.progress = value;
	}
	
	private function startNextWorker():void
	{
		workersListIndex++;
		
		if (workersListIndex < workersList.length)
		{
			var item:WorkersListItem = (workersList[workersListIndex] as WorkersListItem);
			var data:IData = (workersListIndex == 0 ? startingData : (workersList[workersListIndex - 1] as WorkersListItem).processingListItem.data);
			item.worker.start(data, item.processingListItem, dmvowModel);
		}
		else
		{
			_model.processingList.working = false;
			
			showItem((workersList[workersList.length - 1] as WorkersListItem).processingListItem);
		}
	}
	
	private function showItem(item:ProcessingListItem):void
	{
		if (_model.processingList.selectedItem)
			_model.processingList.selectedItem.isCurrent = false;
			
		_model.processingList.selectedItem = item;
		
		if (_model.processingList.selectedItem)
			_model.processingList.selectedItem.isCurrent = true;
	}
	
	private function onProcessingListChange(event:CollectionEvent):void
	{
		if (!(event.target is ProcessingList) && !(event.target is ProcessingListItem))
			return;
		
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
					working = false;
					return;
					// throw new Error("Can't understand this message");
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
	
	private function onItemShow(event:FiltersListItemEvent):void
	{
		// If this item is ready to be shown - let's show it.
		if (event.item.status == ProcessingListItem.VALID || event.item.status == ProcessingListItem.EMPTY)
		{
			showItem(event.item);
		}
		// No, we need to process the data before we can show something
		else
		{
			workersListIndex = -1;
			_model.processingList.working = true;
			startingData = null;
			workersList = new Array();
			setProgress(0);
			
			// Fill the workers list
			for (var i:Number = 0; i < _model.processingList.length; i++)
			{
				var processingListItem:ProcessingListItem = ProcessingListItem(_model.processingList.getItemAt(i));
				if (processingListItem.status == ProcessingListItem.NEVER_PROCESSED ||
					processingListItem.status == ProcessingListItem.NOT_VALID)
				{
					if (!startingData)
					{
						startingData = (_model.processingList.getItemAt(i-1) as ProcessingListItem).data.clone();
					}
					
					var workersListItem:WorkersListItem = new WorkersListItem();
					workersListItem.processingListItem = processingListItem;
					workersListItem.worker = getWorkerFactoryMethod(processingListItem);
					workersListItem.worker.addEventListener(ProgressEvent.PROGRESS, onWorkerProgress, false, 0, true);
					workersListItem.worker.addEventListener(Event.COMPLETE, onWorkerComplete, false, 0, true);
					workersList.push(workersListItem);
				}
			}
			// Start the first worker
			
			startNextWorker();
		}
	}
	
	private function onWorkerProgress(event:ProgressEvent):void
	{
		var progress:Number = (event.bytesLoaded / event.bytesTotal) * (workersListIndex / workersList.length);
		
		setProgress(progress);
	}
	
	private function onWorkerComplete(event:Event):void
	{
		var item:WorkersListItem = workersList[workersListIndex];
		item.processingListItem.processingHistory = item.processingListItem.processingData.clone();
		item.processingListItem.historyDescription = item.processingListItem.description.clone(); 
		
		startNextWorker();
	}
}
}
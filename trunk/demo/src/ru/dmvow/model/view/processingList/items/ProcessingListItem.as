package ru.dmvow.model.view.processingList.items
{
import flash.events.EventDispatcher;

import ru.dmvow.model.common.IData;
import ru.dmvow.model.view.processingList.history.ProcessingData;
import ru.dmvow.model.view.processingList.history.ProcessingItemDescription;

[Event(name="processingListItemDescriptionChange", type="ru.dmvow.model.view.processingList.items.ProcessingListItemEvent")]
public class ProcessingListItem extends EventDispatcher
{
	/*[Embed(source="/assets/icons/processing.swf", symbol="NeverProcessed")]
	protected var neverProcessed:Class;
	[Embed(source="/assets/icons/processing.swf", symbol="Empty")]
	protected var empty:Class;
	[Embed(source="/assets/icons/processing.swf", symbol="InProcess")]
	protected var inProcess:Class;
	[Embed(source="/assets/icons/processing.swf", symbol="Valid")]
	protected var valid:Class;
	[Embed(source="/assets/icons/processing.swf", symbol="NotValid")]
	protected var notValid:Class;*/
	
	public static const NEVER_PROCESSED:String = "neverProcessed";
	public static const EMPTY:String = "empty";
	public static const IN_PROCESS:String = "inProcess";
	public static const VALID:String = "valid";
	public static const NOT_VALID:String = "notValid"; 
	
	// PMML or SQL object.
	[Bindable]
	public var data:IData;
	protected var _status:String = EMPTY;
	protected var _isCurrent:Boolean = false;
	protected var _name:String;
	protected var _processingData:ProcessingData;
	protected var _processingHistory:ProcessingData;
	protected var _description:ProcessingItemDescription;
	protected var _historyDescription:ProcessingItemDescription;
	protected var _inProcess:Boolean = false;
	
	public function ProcessingListItem()
	{
		super();
		
		updateDescription();
	}
	
	//[Bindable(event="processingDataChange")]
	public function set processingData(value:ProcessingData):void
	{
		_processingData = value;
		checkStatus();
	}
	
	public function get processingData():ProcessingData
	{
		return _processingData;
	}
	
	public function set description(value:ProcessingItemDescription):void
	{
		if (_description && value && value.equalTo(_description))
			return;
		
		_description = value;
		checkStatus();
		
		var newEvent:ProcessingListItemEvent = new ProcessingListItemEvent(ProcessingListItemEvent.DESCRIPTION_CHANGE);
		dispatchEvent(newEvent);
	}
	
	public function get description():ProcessingItemDescription
	{
		return _description;
	}
	
	//[Bindable(event="processingHistoryChange")]
	public function set processingHistory(value:ProcessingData):void
	{
		_processingHistory = value;
		checkStatus();
	}
	
	public function get processingHistory():ProcessingData
	{
		return _processingHistory;
	}
	
	public function set historyDescription(value:ProcessingItemDescription):void
	{
		_historyDescription = value;
		checkStatus();
	}
	
	public function get historyDescription():ProcessingItemDescription
	{
		return _historyDescription;
	}
	
	public function set inProcess(value:Boolean):void
	{
		_inProcess = value;
		checkStatus();
	}
	
	public function get inProcess():Boolean
	{
		return _inProcess;
	}
	
	/**
	 * Name for displaying in list.
	 */
	[Bindable]
	public function set name(value:String):void
	{
		_name = value;
	}
	
	public function get name():String
	{
		return _name;
	}
	
	[Bindable]
	public function set isCurrent(value:Boolean):void
	{
		_isCurrent = value;
	}
	
	public function get isCurrent():Boolean
	{
		return _isCurrent;
	}
	
	/**
	 * Status of this item.
	 */
	[Bindable]
	public function set status(value:String):void
	{
		if (_status == value)
			return;
		
		_status = value;
		
		if (_status == VALID)
		{
 			if (!processingHistory.equalTo(processingData))
				processingHistory = processingData.clone();
		}
	}
	
	public function get status():String
	{
		return _status;
	}
	
	/**
	 * Regulates if this processing list item has
	 * "Edit" button.
	 */
	public function get editable():Boolean
	{
		return false;
	}
	
	/**
	 * Regulates if this item can be removed from
	 * processing list.
	 */
	public function get removable():Boolean
	{
		return false;
	}
	
	/**
	 * Regultes if this processing list item can
	 * be moved from one place in list to another.
	 */
	public function get movable():Boolean
	{
		return false;
	}
	
	protected function checkStatus():void
	{
		if (_processingData &&
			_description)
		{
			if (_processingHistory &&
				_historyDescription)
			{
				if (_processingData.equalTo(_processingHistory) &&
					_description.equalTo(historyDescription))
				{
					status = VALID;
				}
				else
				{
					if (_inProcess)
						status = NOT_VALID;
					else
						status = IN_PROCESS;
				}
			}
			else
			{
				status = NEVER_PROCESSED;
			}
		}
		else
		{
			status = EMPTY;
		}
	}
	
	protected function updateDescription():void
	{
		var description:ProcessingItemDescription = new ProcessingItemDescription();
		description.description = getCurrentDescriptionText();
		this.description = description;
	}
	
	protected function getCurrentDescriptionText():String
	{
		throw new Error("Method has to be overriden.");
		
		return null;
	}
}
}
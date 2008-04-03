package ru.dmvow.model.view.processingList.items.interestingMeasureFilter
{
import ru.dmvow.model.view.interestingMeasures.InterestingMeasure;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class InterestingMeasureFilterItem extends ProcessingListItem
{
	private var _percentage:Number = 20;
	private var _interestingMeasure:InterestingMeasure;
	
	public function InterestingMeasureFilterItem()
	{
		super();
		
		status = NEVER_PROCESSED;
		
		update();
	}
	
	[Bindable]
	public function get interestingMeasure():InterestingMeasure
	{
		return _interestingMeasure;
	}
	
	public function set interestingMeasure(value:InterestingMeasure):void
	{
		_interestingMeasure = value;
		
		update();
	}
	
	[Bindable]
	public function get percentage():Number
	{
		return _percentage;
	}
	
	public function set percentage(value:Number):void
	{
		_percentage = value;
		
		update();
	}
	
	override public function get status():String
	{
		return _status;
	}
	
	override public function get editable():Boolean
	{
		return true;
	}
	
	override public function get removable():Boolean
	{
		return true;
	}
	
	override protected function getCurrentDescriptionText():String
	{
		return _name;
	}
	
	private function update():void
	{
		name = "Int. measure: " + percentage + " " + (_interestingMeasure ? _interestingMeasure.toString(): "");
		
		updateDescription();
	}
}
}
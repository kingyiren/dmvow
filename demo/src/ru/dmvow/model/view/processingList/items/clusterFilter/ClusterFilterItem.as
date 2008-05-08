package ru.dmvow.model.view.processingList.items.clusterFilter
{
import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class ClusterFilterItem extends ProcessingListItem
{
	public static const SENSE_MEASURE:String = "Sense measure";
	public static const ITEMS_MEASURE:String = "Items measure";
	
	private var _measure:String = SENSE_MEASURE;
	
	public function ClusterFilterItem()
	{
		super();
		
		status = NEVER_PROCESSED;
		
		update();
	}
	
	[Bindable]
	public function get measure():String
	{
		return _measure;
	}
	
	public function set measure(value:String):void
	{
		_measure = value;
		
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
		name = "Clustering using " + measure;
		
		updateDescription();
	}
}
}
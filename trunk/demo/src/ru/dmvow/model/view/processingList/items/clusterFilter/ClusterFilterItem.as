package ru.dmvow.model.view.processingList.items.clusterFilter
{
import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class ClusterFilterItem extends ProcessingListItem
{
	public function ClusterFilterItem()
	{
		super();
		
		status = NEVER_PROCESSED;
		
		update();
	}
	
	override public function get status():String
	{
		return _status;
	}
	
	override public function get editable():Boolean
	{
		return false;
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
		name = "Clustering " + (data ? "(" + data.dataModel.modelRules.length + ")" : "");
		
		updateDescription();
	}
}
}
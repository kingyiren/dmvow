package ru.dmvow.control.filters.workers
{
import ru.dmvow.model.common.IData;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;

/**
 * Here we need to:
 * 1. Clear the association rules from unwanted rules
 * 2. Clear the itemsets from those who are not used in rules
 * 3. Clear the items from those who are not used in itemsets
 */
public class ItemsFilterWorker extends AbstractWorker
{
	public function ItemsFilterWorker()
	{
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem):void
	{
		
	}
}
}
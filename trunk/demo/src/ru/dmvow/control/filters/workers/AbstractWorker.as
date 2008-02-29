package ru.dmvow.control.filters.workers
{
	import ru.dmvow.control.common.AsyncObject;
	import ru.dmvow.model.common.IData;
	import ru.dmvow.model.view.processingList.items.ProcessingListItem;

	public class AbstractWorker extends AsyncObject
	{
		public function AbstractWorker()
		{
		}
		
		public function start(previousStepData:IData, processingListItem:ProcessingListItem):void
		{
		}
	}
}
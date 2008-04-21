package ru.dmvow.control.filters.workers
{
import ru.dmvow.control.common.AsyncObject;
import ru.dmvow.model.common.IData;
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;
import ru.dmvow.model.view.DMVoWModel;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;

public class AbstractWorker extends AsyncObject
{
	protected var previousStepData:IData;
	protected var iData:IData;
	
	public function AbstractWorker()
	{
	}
	
	public function start(previousStepData:IData, processingListItem:ProcessingListItem, dmvowModel:DMVoWModel = null):void
	{
	}
	
	protected function cleanItemsets():void
	{
		// Go through all the rules and remove used itemsets from temp set.
		var tempSet:Array = iData.dataModel.modelItemsets.source.concat();
		var rulesArr:Array = iData.dataModel.modelRules.source;
		var index:Number;
		var rule:IRule;
		for (var i:Number = 0; i < rulesArr.length; i++)
		{
			rule = rulesArr[i];
			index = tempSet.indexOf(rule.ruleAntecedent);
			if (index >= 0)
				tempSet.splice(index, 1);
			index = tempSet.indexOf(rule.ruleConsequent);
			if (index >= 0)
				tempSet.splice(index, 1);
		}
		
		var modelItemsets:Array = iData.dataModel.modelItemsets.source;
		// Then remove itemsets from temp set from the itemsets.
		for (i = 0; i < tempSet.length; i++)
		{
			index = modelItemsets.indexOf(tempSet[i]);
			if (index >= 0)
				modelItemsets.splice(index, 1);
		}
	} 
	
	protected function cleanItems():void
	{
		// Go through all the itemsets and remove used items from temp set.
		var tempSet:Array = iData.dataModel.modelItems.source.concat();
		var itemsetsArr:Array = iData.dataModel.modelItemsets.source;
		var index:Number;
		var itemset:IItemset;
		for (var i:Number = 0; i < itemsetsArr.length; i++)
		{
			itemset = itemsetsArr[i];
			for (var j:Number = 0; j < itemset.itemsetItems.length; j++)
			{
				index = tempSet.indexOf(itemset.itemsetItems.getItemAt(j));
				if (index >= 0)
					tempSet.splice(index, 1);
			}
		}
		
		var modelItems:Array = iData.dataModel.modelItems.source;
		// Then remove itemsets from temp set from the itemsets.
		for (i = 0; i < tempSet.length; i++)
		{
			index = modelItems.indexOf(tempSet[i]);
			if (index >= 0)
				modelItems.splice(index, 1);
		}
	}
}
}
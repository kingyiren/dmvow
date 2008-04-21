package ru.dmvow.control.filters.workers
{
import ru.dmvow.model.common.IData;
import ru.dmvow.model.common.IItem;
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;
import ru.dmvow.model.view.DMVoWModel;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.itemsFilter.ItemPattern;
import ru.dmvow.model.view.processingList.items.itemsFilter.ItemsFilterItem;

/**
 * This is a worker, that makes the real actions to filter the model
 * based on the user-defined ItemsFilterItem object. 
 * 
 * Here we need to:
 * 1. Clear the association rules from unwanted rules
 * 2. Clear the itemsets from those who are not used in rules
 * 3. Clear the items from those who are not used in itemsets
 */
public class ItemsFilterWorker extends AbstractWorker
{
	private static const RULES:String = "rules";
	private static const RULES_REMOVE:String = "rulesRemove";
	private static const ITEMSETS:String = "itemsets";
	private static const ITEMSETS_REMOVE:String = "itemsetsRemove";
	private static const ITEMS:String = "items";
	private static const ITEMS_REMOVE:String = "itemsRemove";
	private var filterItem:ItemsFilterItem;
	private var currentTarget:String;
	private var rulesLength:Number;
	private var rulesToDelete:Array = new Array();
	
	public function ItemsFilterWorker()
	{
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem, dmvowModel:DMVoWModel = null):void
	{
		this.previousStepData = previousStepData;
		this.filterItem = processingListItem as ItemsFilterItem;
		
		startProcess();
	}
	
	override protected function commonProcessActions():void
	{
		// Actions in the beginning of the process
		// Have to set "maxCounter" here
		rulesLength = previousStepData.dataModel.modelRules.length;
		
		// For rules we will collect indexes to delete through "rulesLength"
		// iterations and then delete them in "rulesLength + 1" iteration.
		// The same thing with itemsets and items. 
		maxCounter = rulesLength + 1 + 1 + 1;
		
		// Starting with processing rules.
		currentTarget = RULES; 
		
		iData = previousStepData.clone();
	}  
	
	override protected function reportComplete():void
	{
		cleanItemsets();
		
		cleanItems();
		
		filterItem.data = iData;
		
		super.reportComplete();
	}
	
	override protected function processIteration():void
	{
		var localCounter:Number;
		var i:Number;
		// Actions in the beginning of the process
		// User "counter" to get current index.
		if (currentTarget == RULES)
		{
			if (counter == rulesLength - 1)
				currentTarget = RULES_REMOVE;
			
			if (rulesLength == 0)
				return;
			
			// Work on rules
			if (haveToDeleteRule(iData.dataModel.modelRules.source[counter]))
				rulesToDelete.push(counter);
		}
		else if (currentTarget == RULES_REMOVE)
		{
			for (i = rulesToDelete.length - 1; i >= 0; i--)
			{
				iData.dataModel.modelRules.source.splice(rulesToDelete[i], 1);
			}
		}
	} 
	
	/**
	 * Check if the rule satisfies the constraints from itemsFilterItem.
	 * If yes, keep the rule. Else - delete.  
	 */
	private function haveToDeleteRule(rule:IRule):Boolean
	{
		var result:Boolean = false;
		var pattern:ItemPattern;
		
		for (var i:Number = 0; i < filterItem.leftSide.length; i++)
		{
			pattern = filterItem.leftSide.getItemAt(i) as ItemPattern;
			if (!itemsetSatisfiesPattern(rule.ruleAntecedent, pattern))
			{
				result = true;
				break;
			}
		}
		
		if (!result)
		{
			for (i = 0; i < filterItem.rightSide.length; i++)
			{
				pattern = filterItem.rightSide.getItemAt(i) as ItemPattern;
				if (!itemsetSatisfiesPattern(rule.ruleConsequent, pattern))
				{
					result = true;
					break;
				}
			}
		}
		
		return result;
	} 
	
	private function itemsetSatisfiesPattern(itemset:IItemset, pattern:ItemPattern):Boolean
	{
		var result:Boolean = false;
		var hasItem:Boolean = false;
		
		for (var i:Number = 0; i < itemset.itemsetItems.length; i++)
		{
			if (pattern.itemName == (itemset.itemsetItems.source[i] as IItem).itemName)
			{
				hasItem = true;
				break;
			}
		}
		
		if (hasItem == pattern.mustHave)
			result = true;
		
		return result;
	}
}
}
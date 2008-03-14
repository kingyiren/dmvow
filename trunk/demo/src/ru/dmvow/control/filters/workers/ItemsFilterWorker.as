package ru.dmvow.control.filters.workers
{
import ru.dmvow.model.common.IData;
import ru.dmvow.model.common.IItem;
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.itemsFilter.ItemPattern;
import ru.dmvow.model.view.processingList.items.itemsFilter.ItemsFilterItem;

/**
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
	private var previousStepData:IData;
	private var iData:IData;
	private var itemsFilterItem:ItemsFilterItem;
	private var currentTarget:String;
	private var rulesLength:Number;
	private var rulesToDelete:Array = new Array();
	
	public function ItemsFilterWorker()
	{
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem):void
	{
		this.previousStepData = previousStepData;
		this.itemsFilterItem = processingListItem as ItemsFilterItem;
		
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
		itemsFilterItem.data = iData;
		
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
			
			currentTarget = ITEMSETS_REMOVE;
		}
		else if (currentTarget == ITEMSETS_REMOVE)
		{
			cleanItemsets();
			currentTarget = ITEMS_REMOVE;
		}
		else if (currentTarget == ITEMS_REMOVE)
		{
			cleanItems();
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
		
		for (var i:Number = 0; i < itemsFilterItem.leftSide.length; i++)
		{
			pattern = itemsFilterItem.leftSide.getItemAt(i) as ItemPattern;
			if (!itemsetSatisfiesPattern(rule.ruleAntecedent, pattern))
			{
				result = true;
				break;
			}
		}
		
		if (!result)
		{
			for (i = 0; i < itemsFilterItem.rightSide.length; i++)
			{
				pattern = itemsFilterItem.rightSide.getItemAt(i) as ItemPattern;
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
	
	private function cleanItemsets():void
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
	
	private function cleanItems():void
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
		
	/*override protected function get iterationsPerFrame():Number
	{
		return ITERATIONS_PER_FRAME;
	}*/
}
}
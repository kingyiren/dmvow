package ru.dmvow.control.filters.workers
{
import flash.utils.Dictionary;

import ru.dmvow.model.common.IRule;
import ru.dmvow.model.view.processingList.items.clusterFilter.ClusterFilterItem;
	
public class ClusteringWorker extends AbstractWorker
{
	private var filterItem:ClusterFilterItem;
	private var distCache:Dictionary = new Dictionary(false);
	
	public function ClusteringWorker()
	{
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem):void
	{
		this.previousStepData = previousStepData;
		this.filterItem = processingListItem as ClusterFilterItem;
		
		startProcess();
	}
	
	override protected function commonProcessActions():void
	{
		iData = previousStepData.clone();
		
		maxCounter = 1;
		
		paused = true;
	}
	
	override protected function processIteration():void
	{
		// None.
	}  
	
	override protected function reportComplete():void
	{
		cleanItemsets();
		
		cleanItems();
		
		filterItem.data = iData;
		
		super.reportComplete();
	}
	
	/**
	 * Calculates and caches the distance between the rules.
	 */
	private function rulesDistance(rule1:IRule, rule2:IRule):Number
	{
		if (distCache[rule1])
			if (distCache[rule1][rule2])
				return Number(distCache[rule1][rule2]); 
		
		// If we are here, cache didn't work.
		var temp:Number = ruleConcatenationSupport(rule1:IRule, rule2:IRule);
		var result:Number = 1 - temp/(rule1.ruleSupport + rule2.ruleSupport - temp);
		
		// Let's cache result
		if (!distCache[rule1])
			distCache[rule1] = new Dictionary();
		distCache[rule1][rule2] = result;
		if (!distCache[rule2])
			distCache[rule2] = new Dictionary();
		distCache[rule2][rule1] = result;
			
		return result;
	}
	
	private function ruleConcatenationSupport(rule1:IRule, rule2:IRule):Number
	{
		// Here we need to try to find rule or itemset, that consists of the
		// same items as the concatenation of rule1 and rule2.
		//
		// If we will find it, we can give the concatenation support. Esle
		// we will say it's 0.
		
		return 0;
	}
}
}
package ru.dmvow.control.filters.workers
{
import ru.dmvow.model.common.IData;
import ru.dmvow.model.common.IRule;
import ru.dmvow.model.view.interestingMeasures.SimpleMeasure;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.interestingMeasureFilter.InterestingMeasureFilterItem;
	
/**
 * Worker that makes the real filtering based on the user-defined
 * InterestingMeasureFilterItem object.
 */
public class InterestingMeasureFilterWorker extends AbstractWorker
{
	private var filterItem:InterestingMeasureFilterItem;
	private var sorting:Array;
	
	public function InterestingMeasureFilterWorker()
	{
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem):void
	{
		this.previousStepData = previousStepData;
		this.filterItem = processingListItem as InterestingMeasureFilterItem;
		
		startProcess();
	}
	
	override protected function commonProcessActions():void
	{
		iData = previousStepData.clone();
		
		maxCounter = iData.dataModel.modelRules.length;
		
		sorting = new Array();
	}
	
	override protected function processIteration():void
	{
		var rule:IRule = iData.dataModel.modelRules.getItemAt(counter) as IRule;
		var sortObj:InterestingMeasureSortObj = new InterestingMeasureSortObj();
		sortObj.rule = rule;
		sortObj.score = getRuleScore(rule);
		sorting.push(sortObj);
		
		if (counter == maxCounter - 1)
		{
			sorting = sorting.sortOn("score", Array.NUMERIC);
			
			// leave only the last A percents of rules:
			var cutLength:Number = Math.ceil(sorting.length * filterItem.percentage / 100);
			var sourceArray:Array = new Array();
			var delay:Number = sorting.length - cutLength; 
			for (var i:Number = cutLength - 1; i >= 0; i--)
				sourceArray.push((sorting[delay + i] as InterestingMeasureSortObj).rule);
			
			iData.dataModel.modelRules.source = sourceArray;
		}
	}  
	
	override protected function reportComplete():void
	{
		cleanItemsets();
		
		cleanItems();
		
		filterItem.data = iData;
		
		super.reportComplete();
	}
	
	private function getRuleScore(rule:IRule):Number
	{
		var result:Number = 0;
		var simpleMeasures:Array = filterItem.interestingMeasure.simpleMeasures.source;
		var simpleMeasure:SimpleMeasure;
		
		for (var i:Number = 0; i < simpleMeasures.length; i++)
		{
			simpleMeasure = SimpleMeasure(simpleMeasures[i]);
			result += getMeasureScore(rule, simpleMeasure);
		}
		
		return result;
	}
	
	private function getMeasureScore(rule:IRule, simpleMeasure:SimpleMeasure):Number
	{
		var result:Number;
		if (simpleMeasure.type == SimpleMeasure.SUPPORT)
			result = rule.ruleSupport;
		else if (simpleMeasure.type == SimpleMeasure.CONFIDENCE)
			result = rule.ruleConfidence;
		else if (simpleMeasure.type == SimpleMeasure.COVERAGE)
			result = rule.ruleCoverage;
		else if (simpleMeasure.type == SimpleMeasure.LEVERAGE)
			result = rule.ruleLeverage;
		else if (simpleMeasure.type == SimpleMeasure.LIFT)
			result = (rule.ruleLift <= 1 ? rule.ruleLift/2 : 1 - 0.5/rule.ruleLift);
		else 
			throw new Error("Unknown type.");
		
		if (!simpleMeasure.isUp)
			result = -result;
		
		return result;
	}
}
}

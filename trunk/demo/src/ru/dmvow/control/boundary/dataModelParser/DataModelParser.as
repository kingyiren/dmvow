package ru.dmvow.control.boundary.dataModelParser
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	import ru.dmvow.control.boundary.pmmlParser.PMMLParser;
	import ru.dmvow.control.boundary.sqlParser.SQLParser;
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.common.IRule;
	import ru.dmvow.model.pmml.PMMLMiningModel;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationModel;
	import ru.dmvow.model.sql.SQLMiningModel;
	import ru.dmvow.model.sql.associationModel.SQLAssociationModel;

	[Event(name="complete", type="flash.events.Event")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	public class DataModelParser extends EventDispatcher
	{
		public var result:DataModel;
		protected var pmmlParser:PMMLParser;
		protected var sqlParser:SQLParser;
		
		public function DataModelParser()
		{
			pmmlParser = new PMMLParser();
			pmmlParser.addEventListener(Event.COMPLETE, onPMMLParserComplete);
			pmmlParser.addEventListener(ProgressEvent.PROGRESS, onParserProgress);
			pmmlParser.addEventListener(ErrorEvent.ERROR, onParserError);
			
			sqlParser = new SQLParser();
			sqlParser.addEventListener(Event.COMPLETE, onSQLParserComplete);
			sqlParser.addEventListener(ProgressEvent.PROGRESS, onParserProgress);
			sqlParser.addEventListener(ErrorEvent.ERROR, onParserError);
		}
		
		/**
		 * If the passed rule doesn't have all the simple measures counted
		 * (default uncounted value is -1), we will count and set them. 
		 */ 
		public static function countRuleMeasures(rule:IRule):void
		{
			// Lift(X → Y) = P(X and Y)/[P(X) * P(Y)]. It's values are in range [0, +inf].
			// Lift(rule) = Confidence(rule)/Support(consequent);
			if (rule.ruleLift == -1)
				rule.ruleLift = rule.ruleConfidence / rule.ruleConsequent.itemsetSupport;
				
			// Leverage(X → Y) = P(X and Y) -([P(X) * P(Y)). It's values are in range [0, 1).
			// Leverage(rule) = Support(rule) -  Support(antecedent) * Support(consequent);
			if (rule.ruleLeverage == -1)
				rule.ruleLeverage =	rule.ruleSupport - 
					rule.ruleAntecedent.itemsetSupport * rule.ruleConsequent.itemsetSupport;
					
			// Coverage(X → Y) = P(X and Y)/P(Y). It's values are in range [0, 1].
			// Coverage(rule) = Support(rule) / Support(consequent);
			if (rule.ruleCoverage == -1)
				rule.ruleCoverage = rule.ruleSupport / rule.ruleConsequent.itemsetSupport;
		}
		
		public function parse(data:String):void
		{
			if (pmmlParser.simpleInputDataCheck(data))
			{
				pmmlParser.parseFromString(data);
			}
			else if (sqlParser.simpleInputDataCheck(data))
			{
				sqlParser.parseFromString(data);
			}
			else
			{
				onParserError(null);
			}
		}
		
		protected function onPMMLParserComplete(event:Event):void
		{
			var pmmlMiningModel:PMMLMiningModel = new PMMLMiningModel();
			pmmlMiningModel.data = pmmlParser.result;
			pmmlMiningModel.name = (pmmlMiningModel.pmmlData.models[0] as PMMLAssociationModel).name; 
			result = pmmlMiningModel; 
			
			var event:Event = new Event(Event.COMPLETE);
			dispatchEvent(event);
		}
		
		protected function onSQLParserComplete(event:Event):void
		{
			var sqlMiningModel:SQLMiningModel = new SQLMiningModel();
			sqlMiningModel.data = sqlParser.result;
			sqlMiningModel.name = (sqlMiningModel.sqlData.model as SQLAssociationModel).name; 
			result = sqlMiningModel;
			
			var newEvent:Event = new Event(Event.COMPLETE);
			dispatchEvent(newEvent);	
		}
		
		protected function onParserError(event:Event):void
		{
			var newEvent:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
			dispatchEvent(newEvent);
		}
		
		protected function onParserProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
	}
}
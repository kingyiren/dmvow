package ru.dmvow.control.dataNet.builders
{
	import ru.dmvow.model.common.IDataModel;
	import ru.dmvow.model.common.IRule;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationRule;
	import ru.dmvow.model.view.dataNet.DataNet;
	import ru.dmvow.model.view.dataNet.NetLink;
	import ru.dmvow.model.view.dataNet.NetNode;
	
	public class PMMLDataNetBuilder extends DataNetBuilder
	{
		protected static const ITEMS:String = "items";
		protected static const RULES:String = "rules";
		protected var parseType:String;
		protected var fromModel:IDataModel;
		
		public function createItemsNet(fromModel:IDataModel):void
		{
			this.fromModel = fromModel;
			parseType = ITEMS;
			startProcess();
		}
		
		public function createRulesNet(fromModel:IDataModel):void
		{
			this.fromModel = fromModel;
			parseType = RULES;
			startProcess();
		}
		
		override protected function commonProcessActions():void
		{
			if (parseType == ITEMS)
				itemsCommonProcessActions();
			else if (parseType == RULES)
				rulesCommonProcessActions();
			else
				throw new Error("Unknown parseType: " + parseType);
		}
		
		override protected function processIteration():void
		{
			if (parseType == ITEMS)
				itemsProcessIteration();
			else if (parseType == RULES)
				rulesProcessIteration();
			else
				throw new Error("Unknown parseType: " + parseType);
		}
		
		protected function itemsCommonProcessActions():void
		{
			var i:Number;
			var j:Number;
			var k:Number;
			var node:NetNode;
			result = new DataNet();
			for (i = 0; i < fromModel.modelItems.length; i++)
			{
				node = new NetNode();
				node.data = fromModel.modelItems[i];
				result.nodes.push(node);
			}
			
			maxCounter = fromModel.modelRules.length;
		}
		
		protected function itemsProcessIteration():void
		{
			var j:Number;
			var k:Number;
			var rule:IRule = fromModel.modelRules[counter];
			var aNode:NetNode;
			var cNode:NetNode;
			var link:NetLink;
			 
			for (j = 0; j < rule.ruleAntecedent.itemsetItems.length; j++)
			{
				aNode = getNetNodeByData(rule.ruleAntecedent.itemsetItems[j]); 
				for (k = 0; k < rule.ruleConsequent.itemsetItems.length; k++)
				{
					cNode = getNetNodeByData(rule.ruleConsequent.itemsetItems[k]);
					link = getNetLink(aNode, cNode);
					link.causedBy.push(rule);
				}
			}
		}
		
		protected function rulesCommonProcessActions():void
		{
			var i:Number;
			var j:Number;
			var k:Number;
			var node:NetNode;
			result = new DataNet();
			for (i = 0; i < fromModel.modelItemsets.length; i++)
			{
				node = new NetNode();
				node.data = fromModel.modelItemsets[i];
				result.nodes.push(node);
			}
			
			maxCounter = fromModel.modelRules.length;
		}
		
		protected function rulesProcessIteration():void
		{
			var j:Number;
			var k:Number;
			var rule:IRule = fromModel.modelRules[counter];
			var aNode:NetNode;
			var cNode:NetNode;
			var link:NetLink;
			 
			aNode = getNetNodeByData(rule.ruleAntecedent);
			cNode = getNetNodeByData(rule.ruleConsequent); 
			link = getNetLink(aNode, cNode);
			link.causedBy.push(rule);
		}
	}
}
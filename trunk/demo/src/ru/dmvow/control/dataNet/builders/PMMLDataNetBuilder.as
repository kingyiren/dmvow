package ru.dmvow.control.dataNet.builders
{
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationModel;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationRule;
	import ru.dmvow.model.view.dataNet.DataNet;
	import ru.dmvow.model.view.dataNet.NetLink;
	import ru.dmvow.model.view.dataNet.NetNode;
	
	public class PMMLDataNetBuilder extends DataNetBuilder
	{
		protected static const ITEMS:String = "items";
		protected static const RULES:String = "rules";
		protected var parseType:String;
		protected var fromModel:PMMLAssociationModel;
		
		public function createItemsNet(fromModel:PMMLAssociationModel):void
		{
			this.fromModel = fromModel;
			parseType = ITEMS;
			startProcess();
		}
		
		public function createRulesNet(fromModel:PMMLAssociationModel):void
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
			for (i = 0; i < fromModel.items.length; i++)
			{
				node = new NetNode();
				node.data = fromModel.items[i];
				result.nodes.push(node);
			}
			
			maxCounter = fromModel.associationRules.length;
		}
		
		protected function itemsProcessIteration():void
		{
			var j:Number;
			var k:Number;
			var rule:PMMLAssociationRule = fromModel.associationRules[counter];
			var aNode:NetNode;
			var cNode:NetNode;
			var link:NetLink;
			 
			for (j = 0; j < rule.antecedent.items.length; j++)
			{
				aNode = getNetNodeByData(rule.antecedent.items[j]); 
				for (k = 0; k < rule.consequent.items.length; k++)
				{
					cNode = getNetNodeByData(rule.consequent.items[k]);
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
			for (i = 0; i < fromModel.itemsets.length; i++)
			{
				node = new NetNode();
				node.data = fromModel.itemsets[i];
				result.nodes.push(node);
			}
			
			maxCounter = fromModel.associationRules.length;
		}
		
		protected function rulesProcessIteration():void
		{
			var j:Number;
			var k:Number;
			var rule:PMMLAssociationRule = fromModel.associationRules[counter];
			var aNode:NetNode;
			var cNode:NetNode;
			var link:NetLink;
			 
			aNode = getNetNodeByData(rule.antecedent);
			cNode = getNetNodeByData(rule.consequent); 
			link = getNetLink(aNode, cNode);
			link.causedBy.push(rule);
		}
	}
}
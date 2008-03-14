package ru.dmvow.control.boundary.sqlParser
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ru.dmvow.control.common.AsyncObject;
	import ru.dmvow.model.sql.SQL;
	import ru.dmvow.model.sql.associationModel.SQLAssociationModel;
	import ru.dmvow.model.sql.associationModel.SQLAssociationRule;
	import ru.dmvow.model.sql.associationModel.SQLItem;
	import ru.dmvow.model.sql.associationModel.SQLItemset;
	
	public class SQLParser extends AsyncObject
	{
		protected const MODEL_CATALOG_INDEX:Number = 0;
		protected const MODEL_NAME_INDEX:Number = 2;
		protected const NODE_UNIQUE_NAME_INDEX:Number = 5;
		protected const NODE_DESCRIPTION_INDEX:Number = 11;
		protected const NODE_RULE_INDEX:Number = 12;
		protected const NODE_PROBABILITY_INDEX:Number = 14;
		protected const NODE_SUPPORT_INDEX:Number = 17;
		protected const LINE_SEPARATOR:String = "\r\n";
		protected const TAB_SEPARATOR:String = "\t";
		
		protected var currentData:String;
		protected var rows:Array;
		public var result:SQL; 
		
		public function SQLParser()
		{
		}
		
		public function simpleInputDataCheck(data:String):Boolean
		{
			return data.indexOf("<PMML") < 0;
		}
		
		public function parseFromString(data:String):void
		{
			currentData = data;
			
			startProcess();
		} 
		
		override protected function commonProcessActions():void
		{
			var i:Number;
			var j:Number;
			var k:Number;
			
			rows = currentData.split(LINE_SEPARATOR);
			rows.shift();
			
			for (i = 0; i < rows.length; i++)
			{
				rows[i] = rows[i].split(TAB_SEPARATOR);
			}
			
			result = new SQL();
			result.catalog = rows[0][MODEL_CATALOG_INDEX];
			result.model = new SQLAssociationModel();
			result.model.name = rows[0][MODEL_NAME_INDEX];
			
			var props:Array = rows[0][NODE_DESCRIPTION_INDEX].split(";");
			// Removing the first useless item
			props.shift(); 
			for (i = 0; i < props.length; i++)
			{
				props[i] = Number(props[i].split("=")[1]);
			}
			result.model.itemsetCount = props[0];
			result.model.ruleCount = props[1];
			result.model.minSupport = props[2];
			result.model.maxSupport = props[3];
			result.model.minItemsetSize = props[4];
			result.model.maxItemsetSize = props[5];
			result.model.minProbability = props[6];
			result.model.maxProbability = props[7];
			result.model.minLift = props[8];
			result.model.maxLift = props[9];
			
			// Removing the first useless item
			rows.shift();
			maxCounter = rows.length;
		}
		
		override protected function processIteration():void
		{
			var arr:Array = rows[counter];
			
			// If this row is not rule - then it's itemset
			if (arr[NODE_RULE_INDEX] == "")
				parseItemsetRow(arr);
			else
				parseRuleRow(arr);
		}
		
		protected function parseItem(string:String):SQLItem
		{
			var item:SQLItem = result.model.getItemByString(string);
			if (!item)
			{
				var splited:Array;
				
				if (string.indexOf("Duration >=") >= 0)
				{
					trace("aaa");
				}
				
				if (string.indexOf(" > ") > 0)
					splited = string.split(" > ");
				else if (string.indexOf(" >= ") > 0)
					splited = string.split(" >= ");
				else if (string.indexOf(" < ") > 0)
					splited = string.split(" < ");
				else if (string.indexOf(" <= ") > 0)
					splited = string.split(" <= ");
				else if (string.indexOf(" = ") > 0)
					splited = string.split(" = ");
				
				item = new SQLItem();
				item.name = splited[0];
				item.value = splited[1]; 
				item.string = string;
				
				result.model.items.addItem(item);
			}
			
			return item;
		}
		
		protected function parseItemsetRow(arr:Array):SQLItemset
		{
			var description:String = arr[NODE_DESCRIPTION_INDEX];
			var itemset:SQLItemset = result.model.getItemsetByString(description);
			if (!itemset)
			{
				var splited:Array = description.split(", ");
				itemset = new SQLItemset();
				itemset.uniqueName = arr[NODE_UNIQUE_NAME_INDEX];
				itemset.support = Number(arr[NODE_SUPPORT_INDEX]) / result.model.maxSupport;
				itemset.string = description;
				
				for (var i:Number = 0; i < splited.length; i++)
				{
					itemset.items.addItem(parseItem(splited[i]));
				}
				
				result.model.itemsets.addItem(itemset);
			}
			
			return itemset;
		}
		
		protected function parseRuleRow(arr:Array):void
		{
			var rule:SQLAssociationRule = new SQLAssociationRule();
			var xml:XML;
			try
			{
				var xmlStr:String = arr[NODE_RULE_INDEX];
				var xmlSplit:Array = xmlStr.split(" rule=\"");
				xml = new XML(xmlSplit[0] + "/>");
				var splited:Array = xmlSplit[1].split("\"/>")[0].split(" -> ");
				
				rule.antecedent = result.model.getItemsetByString(splited[0]);
				rule.consequent = result.model.getItemsetByString(splited[1]);
				rule.support = Number(xml.@support) / result.model.maxSupport;
				rule.confidence = Number(xml.@confidence);
				
				result.model.associationRules.addItem(rule);
			}
			catch (error: *)
			{
				trace("Error: " + error.toString());
			}
		}
	}
}
package ru.dmvow.model.sql.associationModel
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.common.IDataModel;
	
	public class SQLAssociationModel implements IDataModel
	{
		/** MODEL_NAME */
		[Bindable]
		public var name:String;
		/**
		 * These properties are parsed from NODE_DESCRIPTION
		 */
		[Bindable]
		public var itemsetCount:Number;
		[Bindable]
		public var ruleCount:Number;
		[Bindable]
		public var minSupport:Number;
		[Bindable]
		public var maxSupport:Number;
		[Bindable]
		public var minItemsetSize:Number;
		[Bindable]
		public var maxItemsetSize:Number;
		[Bindable]
		public var minProbability:Number;
		[Bindable]
		public var maxProbability:Number;
		[Bindable]
		public var minLift:Number;
		[Bindable]
		public var maxLift:Number;
		/**
		 * Array of SQLItem objects. Can be empty.
		 */
		[Bindable]
		public var items:ArrayCollection = new ArrayCollection();
		/**
		 * Array of SQLItemset objects. Can be empty.
		 */
		[Bindable]
		public var itemsets:ArrayCollection = new ArrayCollection();
		/**
		 * Array of SQLAssociationRule objects. Can be empty.
		 */
		[Bindable]
		public var associationRules:ArrayCollection = new ArrayCollection();
		
		public function getItemByString(string:String):SQLItem
		{
			for (var i:Number = 0; i < items.length; i++)
			{
				var item:SQLItem = (items[i] as SQLItem);
				if (item.string == string)
					return item;
			}
			
			return null;
		}
		
		public function getItemsetByString(string:String):SQLItemset
		{
			for (var i:Number = 0; i < itemsets.length; i++)
			{
				var itemset:SQLItemset = (itemsets[i] as SQLItemset);
				if (itemset.string == string)
					return itemset;
			}
			
			return null;
		}
		
		public function clone():SQLAssociationModel
		{
			var result:SQLAssociationModel = new SQLAssociationModel();
			
			// TODO
			//result.name =
			
			return result; 
		}
		
		public function get modelItems():ArrayCollection
		{
			return items;
		}
		
		/*public function getAssociationRuleById(id:String):SQLAssociationRule
		{
			for (var i:Number = 0; i < associationRules.length; i++)
			{
				var rule:SQLAssociationRule = (associationRules[i] as SQLAssociationRule);
				if (rule.id == id)
					return rule;
			}
			
			return null;
		}*/
	}
}
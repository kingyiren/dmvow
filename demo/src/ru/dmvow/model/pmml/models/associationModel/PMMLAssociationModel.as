package ru.dmvow.model.pmml.models.associationModel
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.pmml.models.MiningModel;
	
	/**
	 * <p>The XSD Schema for this node:</p>
	 * 
	 * <p>
	 * <code>
	 * <xs:element name="AssociationModel">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element ref="MiningSchema"/>
	 *             <xs:element ref="ModelStats" minOccurs="0"/>
	 *             <xs:element ref="LocalTransformations" minOccurs="0" />
	 *             <xs:element minOccurs="0" maxOccurs="unbounded" ref="Item" />
	 *             <xs:choice minOccurs="0" maxOccurs="unbounded">
	 *                 <xs:element ref="Itemset" />
	 *                 <xs:element ref="AssociationRule" />
	 *             </xs:choice>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="modelName" type="xs:string" />
	 *         <xs:attribute name="functionName" type="MINING-FUNCTION" use="required" />
	 *         <xs:attribute name="algorithmName" type="xs:string" />
	 *         <xs:attribute name="numberOfTransactions" type="INT-NUMBER" use="required" />
	 *         <xs:attribute name="maxNumberOfItemsPerTA" type="INT-NUMBER" />
	 *         <xs:attribute name="avgNumberOfItemsPerTA" type="REAL-NUMBER" />
	 *         <xs:attribute name="minimumSupport" type="PROB-NUMBER" use="required" />
	 *         <xs:attribute name="minimumConfidence" type="PROB-NUMBER" use="required" />
	 *         <xs:attribute name="lengthLimit" type="INT-NUMBER" />
	 *         <xs:attribute name="numberOfItems" type="INT-NUMBER" use="required" />
	 *         <xs:attribute name="numberOfItemsets" type="INT-NUMBER" use="required" />
	 *         <xs:attribute name="numberOfRules" type="INT-NUMBER" use="required" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 * 
	 * <p>Example of the XML:</p>
	 * 
	 * <p>
	 * <code>
	 * <?xml version="1.0" ?>
	 * <PMML version="3.2" xmlns="http://www.dmg.org/PMML-3_2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	 *     <Header copyright="www.dmg.org" description="example model for association rules"/>
	 *     <DataDictionary numberOfFields="2" >
	 *         <DataField name="transaction" optype="categorical" dataType="string" />
	 *         <DataField name="item" optype="categorical" dataType="string" />
	 *     </DataDictionary>
	 *     <AssociationModel
	 *          functionName="associationRules"
	 *          numberOfTransactions="4" numberOfItems="3"
	 *          minimumSupport="0.6"     minimumConfidence="0.5"
	 *          numberOfItemsets="3"     numberOfRules="2">
	 *     <MiningSchema>
	 *         <MiningField name="transaction" usageType="group" />
	 *         <MiningField name="item" usageType="predicted"/>
	 *     </MiningSchema>
	 * 
	 *     <!-- We have three items in our input data -->
	 *     <Item id="1" value="Cracker" />
	 *     <Item id="2" value="Coke" />
	 *     <Item id="3" value="Water" />
	 * 
	 *     <!-- and two frequent itemsets with a single item -->
	 *     <Itemset id="1" support="1.0" numberOfItems="1">
	 *         <ItemRef itemRef="1" />
	 *     </Itemset>
	 *     <Itemset id="2" support="1.0" numberOfItems="1">
	 *         <ItemRef itemRef="3" />
	 *     </Itemset>
	 * 
	 *     <!-- and one frequent itemset with two items. -->
	 *     <Itemset id="3" support="1.0" numberOfItems="2">
	 *         <ItemRef itemRef="1" />
	 *         <ItemRef itemRef="3" />
	 *     </Itemset>
	 * 
	 *     <!-- Two rules satisfy the requirements -->
	 *     <AssociationRule support="1.0" confidence="1.0" antecedent="1" consequent="2" />
	 *     <AssociationRule support="1.0" confidence="1.0" antecedent="2" consequent="1" />
	 * 
	 *   </AssociationModel>
	 * </PMML>
	 * </code>
	 * </p>
	 */
	public class PMMLAssociationModel extends MiningModel
	{
		/** Required. */
		[Bindable]
		public var numberOfTransactions:int;
		/** Optional. */
		[Bindable]
		public var maxNumberOfItemsPerTA:int;
		/** Optional. */
		[Bindable]
		public var avgNumberOfItemsPerTA:int;
		/** Required. */
		[Bindable]
		public var minimumSupport:Number;
		/** Required. */
		[Bindable]
		public var minimumConfidence:Number;
		/** Optional. */
		[Bindable]
		public var lengthLimit:int;
		/** Required. */
		[Bindable]
		public var numberOfItems:int;
		/** Required. */
		[Bindable]
		public var numberOfItemsets:int;
		/** Required. */
		[Bindable]
		public var numberOfRules:int;
		
		/**
		 * Array of PMMLItem objects. Can be empty.
		 */
		[Bindable]
		public var items:ArrayCollection = new ArrayCollection();
		/**
		 * Array of PMMLItemSet objects. Can be empty.
		 */
		[Bindable]
		public var itemsets:ArrayCollection = new ArrayCollection();
		/**
		 * Array of PMMLAssociationRule objects. Can be empty.
		 */
		[Bindable]
		public var associationRules:ArrayCollection = new ArrayCollection();
		
		public function getItemById(id:String):PMMLItem
		{
			for (var i:Number = 0; i < items.length; i++)
			{
				var item:PMMLItem = (items[i] as PMMLItem);
				if (item.id == id)
					return item;
			}
			
			return null;
		}
		
		public function getItemsetById(id:String):PMMLItemset
		{
			for (var i:Number = 0; i < itemsets.length; i++)
			{
				var itemset:PMMLItemset = (itemsets[i] as PMMLItemset);
				if (itemset.id == id)
					return itemset;
			}
			
			return null;
		}
		
		public function getAssociationRuleById(id:String):PMMLAssociationRule
		{
			for (var i:Number = 0; i < associationRules.length; i++)
			{
				var rule:PMMLAssociationRule = (associationRules[i] as PMMLAssociationRule);
				if (rule.id == id)
					return rule;
			}
			
			return null;
		}
	}
}
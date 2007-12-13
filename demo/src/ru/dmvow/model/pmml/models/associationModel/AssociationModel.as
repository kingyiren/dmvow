package ru.dmvow.model.pmml.models.associationModel
{
	import ru.dmvow.model.pmml.models.MiningModel;
	import ru.dmvow.model.pmml.models.common.LocalTransformations;
	import ru.dmvow.model.pmml.models.common.MiningSchema;
	import ru.dmvow.model.pmml.models.common.ModelStats;
	
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
	public class AssociationModel extends MiningModel
	{
		/** Required. */
		public var numberOfTransactions:int;
		/** Optional. */
		public var maxNumberOfItemsPerTA:int;
		/** Optional. */
		public var avgNumberOfItemsPerTA:int;
		/** Required. */
		public var minimumSupport:Number;
		/** Required. */
		public var minimumConfidence:Number;
		public var lengthLimit:int;
		/** Required. */
		public var numberOfItems:int;
		/** Required. */
		public var numberOfItemsets:int;
		/** Required. */
		public var numberOfRules:int;
		
		/**
		 * Array of Item objects. Can be empty.
		 */
		public var items:Array = new Array();
		/**
		 * Array of ItemSet objects. Can be empty.
		 */
		public var itemSets:Array = new Array();
		/**
		 * Array of AssociationRule objects. Can be empty.
		 */
		public var associationRules:Array = new Array();
	}
}
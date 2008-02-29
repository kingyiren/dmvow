package ru.dmvow.model.pmml.models.associationModel
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.common.IItemset;
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="Itemset">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element minOccurs="0" maxOccurs="unbounded" ref="ItemRef" />
	 *         </xs:sequence>
	 *         <xs:attribute name="id" type="xs:string" use="required" />
	 *         <xs:attribute name="support" type="PROB-NUMBER" />
	 *         <xs:attribute name="numberOfItems" type="xs:nonNegativeInteger" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class PMMLItemset extends Extendable implements IItemset
	{
		/**
		 * Array of PMMLItem objects. Can be empty. We parse ItemRef objects
		 * directly to the PMMLItem objects to simplify the navigation. 
		 */
		public var items:ArrayCollection = new ArrayCollection();
		/**
		 * Required.
		 */
		public var id:String;
		/**
		 * Optional.
		 */
		public var support:Number;
		/**
		 * Optional.
		 */
		public var numberOfItems:uint;
		
		public function toString():String
		{
			return items.toString();
		}
		
		public function get itemsetItems():ArrayCollection
		{
			return items;
		}
	}
}
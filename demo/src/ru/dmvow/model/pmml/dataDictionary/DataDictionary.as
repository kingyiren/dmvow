package ru.dmvow.model.pmml.dataDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="DataDictionary">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element ref="DataField" maxOccurs="unbounded"  />
	 *             <xs:element ref="Taxonomy" minOccurs="0" maxOccurs="unbounded"  />
	 *         </xs:sequence>
	 *         <xs:attribute name="numberOfFields" type="xs:nonNegativeInteger" />
	 *     </xs:complexType>
     * </xs:element>
	 * </code>
	 * </p>
	 * 
	 * <p>XML node sample:</p>
	 * 
	 * <p>
	 * <code>
	 * <DataDictionary numberOfFields="2" >
	 *     <DataField name="transaction" optype="categorical" dataType="string" />
	 *     <DataField name="item" optype="categorical" dataType="string" />
	 * </DataDictionary>
	 * </code>
	 * </p>
	 */
	public class DataDictionary extends Extendable
	{
		public var numberOfFields:uint;
		/**
		 * Array of DataField objects. Must be not empty.
		 */
		public var dataFields:Array = new Array();
		/**
		 * Array of Taxonomy objects.
		 */
		public var taxonomies:Array = new Array();
	}
}
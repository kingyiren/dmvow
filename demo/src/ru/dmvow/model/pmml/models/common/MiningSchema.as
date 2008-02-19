package ru.dmvow.model.pmml.models.common
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="MiningSchema">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element maxOccurs="unbounded" ref="MiningField" />
	 *         </xs:sequence>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class MiningSchema extends Extendable
	{
		/**
		 * Array of MiningField objects. Must be not empty.
		 */
		public var miningFields:ArrayCollection = new ArrayCollection();
	}
}
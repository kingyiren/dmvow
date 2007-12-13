package ru.dmvow.model.pmml.models.associationModel
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="Item">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="id" type="xs:string" use="required" />
	 *         <xs:attribute name="value" type="xs:string" use="required" />
	 *         <xs:attribute name="mappedValue" type="xs:string" />
	 *         <xs:attribute name="weight" type="REAL-NUMBER" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class Item extends Extendable
	{
		/**
		 * Required.
		 */
		public var id:String;
		/**
		 * Required.
		 */
		public var value:String;
		/**
		 * Optional.
		 */
		public var mappedValue:String;
		/**
		 * Optional.
		 */
		public var weight:Number;
	}
}
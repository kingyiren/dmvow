package ru.dmvow.model.pmml.models.associationModel
{
	import ru.dmvow.model.pmml.common.Extendable;

	/**
	 * <p>
	 * <code>
	 * <xs:element name="ItemRef">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="itemRef" type="xs:string" use="required" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class ItemRef extends Extendable
	{
		/**
		 * Required. Id of the Item object.
		 */
		public var itemRef:String;
	}
}
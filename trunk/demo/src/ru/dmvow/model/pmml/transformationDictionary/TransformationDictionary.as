package ru.dmvow.model.pmml.transformationDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="TransformationDictionary">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element ref="DefineFunction"  minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element ref="DerivedField" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class TransformationDictionary extends Extendable
	{
		/**
		 * Array of DefineFunction objects.
		 */
		public var defineFunctions:Array = new Array();
		/**
		 * Array of DerivedField objects.
		 */
		public var derivedFields:Array = new Array();
	}
}
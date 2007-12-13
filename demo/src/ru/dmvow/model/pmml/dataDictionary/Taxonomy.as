package ru.dmvow.model.pmml.dataDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="Taxonomy">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded" />
	 *             <xs:element ref="ChildParent" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="name" type="xs:string" use="required"/>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class Taxonomy extends Extendable
	{
		public var name:String;
		/**
		 * Array of ChildParent objects. Must be not empty.
		 */
		public var childParents:Array = new Array();
	}
}
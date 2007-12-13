package ru.dmvow.model.pmml.transformationDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="DefineFunction">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded" />
	 *             <xs:element ref="ParameterField" minOccurs="1" maxOccurs="unbounded" />
	 *             <xs:group ref="EXPRESSION" />
	 *         </xs:sequence>
	 *         <xs:attribute name="name" type="xs:string" use="required"/>
	 *         <xs:attribute name="optype" type="OPTYPE" use="required"/>
	 *         <xs:attribute name="dataType" type="DATATYPE" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class DefineFunction extends Extendable
	{
		public var name:String;
		/**
		 * Value from OPTYPE.
		 */
		public var optype:String;
		/**
		 * Value from DATATYPE.
		 */
		public var dataType:String;
		/**
		 * Array of ParameterField objects. Must be not empty.
		 */
		public var parameterFields:Array = new Array();
		
	}
}
package ru.dmvow.model.pmml.transformationDictionary
{
	/**
	 * <p>
	 * <code>
	 * <xs:element name="ParameterField">
	 *     <xs:complexType>
	 *         <xs:attribute name="name" type="xs:string" use="required" />
	 *         <xs:attribute name="optype" type="OPTYPE" />
	 *         <xs:attribute name="dataType" type="DATATYPE" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class ParameterField
	{
		public var name:String;
		/**
		 * Value from OPTYPE.
		 */
		public var optype:String;
		/**
		 * Value from DATATYPE.
		 */
		public var datatype:String;
	}
}
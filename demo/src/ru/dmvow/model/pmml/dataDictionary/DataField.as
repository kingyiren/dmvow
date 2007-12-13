package ru.dmvow.model.pmml.dataDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="DataField">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:choice>
	 *                 <xs:element ref="Interval" minOccurs="0" maxOccurs="unbounded" />
	 *                 <xs:element ref="Value"    minOccurs="0" maxOccurs="unbounded" />
	 *             </xs:choice>
	 *         </xs:sequence>
	 *         <xs:attribute name="name" type="FIELD-NAME" use="required" />
	 *         <xs:attribute name="displayName" type="xs:string" />
	 *         <xs:attribute name="optype" type="OPTYPE" use="required" />
	 *         <xs:attribute name="dataType" type="DATATYPE" use="required" />
	 *         <xs:attribute name="taxonomy" type="xs:string" />
	 *         <xs:attribute name="isCyclic" default="0">
	 *             <xs:simpleType>
	 *                 <xs:restriction base="xs:string">
	 *                     <xs:enumeration value="0" />
	 *                     <xs:enumeration value="1" />
	 *                 </xs:restriction>
	 *             </xs:simpleType>
	 *         </xs:attribute>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class DataField extends Extendable
	{
		public var name:String;
		public var displayName:String;
		/**
		 * Value from OPTYPE.
		 */
		public var optype:String;
		/**
		 * Value from DATATYPE.
		 */
		public var dataType:String;
		public var taxonomy:String;
		public var isCyclic:String = "0";
		/**
		 * Choise between Array of Interval and Array of Value.
		 */
		public var choise:Array;
	}
}
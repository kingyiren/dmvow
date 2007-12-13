package ru.dmvow.model.pmml.dataDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="ChildParent">
	 *     <xs:complexType>
	 *          <xs:sequence>
	 *              <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded" />
	 *              <xs:choice>
	 *                  <xs:element ref="TableLocator"/>
	 *                  <xs:element ref="InlineTable"/>
	 *              </xs:choice>
	 *          </xs:sequence>
	 *          <xs:attribute name="childField" type="xs:string" use="required"/>
	 *          <xs:attribute name="parentField" type="xs:string" use="required"/>
	 *          <xs:attribute name="parentLevelField" type="xs:string" use="optional"/>
	 *          <xs:attribute name="isRecursive" use="optional" default="no">
	 *              <xs:simpleType>
	 *                  <xs:restriction base="xs:string">
	 *                      <xs:enumeration value="no"/>
	 *                      <xs:enumeration value="yes"/>
	 *                  </xs:restriction>
	 *              </xs:simpleType>
	 *          </xs:attribute>
	 *      </xs:complexType>
	 *  </xs:element>
	 * </code>
	 * </p>
	 */
	public class ChildParent extends Extendable
	{
		public var childField:String;
		public var parentField:String;
		public var parentLevelField:String;
		/**
		 * Valid values are "yes" or "no".
		 * 
		 * @default "no"
		 */
		public var isRecursive:String = "no";
		/**
		 * Choise between TableLocator and InlineTable.
		 */
		public var choise:Object;
	}
}
package ru.dmvow.model.pmml.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:element name="Extension">
	 *     <xs:complexType>
	 *         <xs:complexContent mixed="true">
	 *             <xs:restriction base="xs:anyType">
	 *                 <xs:sequence>
	 *                     <xs:any processContents="skip" minOccurs="0" maxOccurs="unbounded"/>
	 *                 </xs:sequence>
	 *                 <xs:attribute name="extender" type="xs:string" use="optional"/>
	 *                 <xs:attribute name="name" type="xs:string" use="optional"/>
	 *                 <xs:attribute name="value" type="xs:string" use="optional"/>
	 *             </xs:restriction>
	 *         </xs:complexContent>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class Extension
	{
		/** Optional. */
		public var extender:String;
		/** Optional. */
		public var name:String;
		/** Optional. */
		public var value:String;
	}
}
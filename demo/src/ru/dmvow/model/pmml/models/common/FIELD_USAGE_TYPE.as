package ru.dmvow.model.pmml.models.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="FIELD-USAGE-TYPE">
	 *     <xs:restriction base="xs:string">
	 *         <xs:enumeration value="active" />
	 *         <xs:enumeration value="predicted" />
	 *         <xs:enumeration value="supplementary" />
	 *         <xs:enumeration value="group" />
	 *         <xs:enumeration value="order" />
	 *     </xs:restriction>
	 * </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class FIELD_USAGE_TYPE
	{
		public static const ACTIVE:String = "active";
		public static const PREDICTED:String = "predicted";
		public static const SUPPLEMENTARY:String = "supplementary";
		public static const GROUP:String = "group";
		public static const ORDER:String = "order";
	}
}
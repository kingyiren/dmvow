package ru.dmvow.model.pmml.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="OPTYPE">
	 *    <xs:restriction base="xs:string">
	 *            <xs:enumeration value="categorical"/>
	 *            <xs:enumeration value="ordinal"/>
	 *            <xs:enumeration value="continuous"/>
	 *        </xs:restriction>
	 *    </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class OPTYPE
	{
		public static const CATEGORICAL:String = "categorical";
		public static const ORDINAL:String = "ordinal";
		public static const CONTINUOUS:String = "continuous";
	}
}
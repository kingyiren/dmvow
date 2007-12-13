package ru.dmvow.model.pmml.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="MINING-FUNCTION">
	 *     <xs:restriction base="xs:string">
	 *         <xs:enumeration value="associationRules"/>
	 *         <xs:enumeration value="sequences"/>
	 *         <xs:enumeration value="classification"/>
	 *         <xs:enumeration value="regression"/>
	 *         <xs:enumeration value="clustering"/>
	 *     </xs:restriction>
	 * </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class MINING_FUNCTION
	{
		public static const ASSOCIATION_RULES:String = "association_rules";
		public static const SEQUENCES:String = "sequences";
		public static const CLASSIFICATION:String = "classification";
		public static const REGRESSION:String = "regression";
		public static const CLUSTERING:String = "clustering";
	}
}
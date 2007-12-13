package ru.dmvow.model.pmml.models.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="OUTLIER-TREATMENT-METHOD">
	 *     <xs:restriction base="xs:string">
	 *         <xs:enumeration value="asIs" />
	 *         <xs:enumeration value="asMissingValues" />
	 *         <xs:enumeration value="asExtremeValues" />
	 *     </xs:restriction>
	 * </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class OUTLIER_TREATMENT_METHOD
	{
		public static const AS_IS:String = "asIs";
		public static const AS_MISSING_VALUES:String = "as_missing_values";
		public static const AS_EXTREME_VALUES:String = "as_extreme_values";
	}
}
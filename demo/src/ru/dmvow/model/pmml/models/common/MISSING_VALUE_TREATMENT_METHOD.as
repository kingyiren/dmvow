package ru.dmvow.model.pmml.models.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="MISSING-VALUE-TREATMENT-METHOD">
	 *     <xs:restriction base="xs:string">
	 *         <xs:enumeration value="asIs" />
	 *         <xs:enumeration value="asMean" />
	 *         <xs:enumeration value="asMode" />
	 *         <xs:enumeration value="asMedian" />
	 *         <xs:enumeration value="asValue" />
	 *     </xs:restriction>
	 * </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class MISSING_VALUE_TREATMENT_METHOD
	{
		public static const AS_IS:String = "asIs";
		public static const AS_MEAN:String = "asMean";
		public static const AS_MODE:String = "asMode";
		public static const AS_MEDIAN:String = "asMedian";
		public static const AS_VALUE:String = "asValue";
	}
}
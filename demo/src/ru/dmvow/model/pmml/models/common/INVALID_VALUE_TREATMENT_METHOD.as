package ru.dmvow.model.pmml.models.common
{
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="INVALID-VALUE-TREATMENT-METHOD">
	 *     <xs:restriction base="xs:string">
	 *         <xs:enumeration value="returnInvalid" />
	 *         <xs:enumeration value="asIs" />
	 *         <xs:enumeration value="asMissing" />
	 *     </xs:restriction>
	 * </xs:simpleType>
	 * </code>
	 * </p>
	 */
	public class INVALID_VALUE_TREATMENT_METHOD
	{
		public static const RETURN_INVALID:String = "returnInvalid";
		public static const AS_IS:String = "asIs";
		public static const AS_MISSING:String = "asMissing";
	}
}
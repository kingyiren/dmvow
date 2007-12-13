package ru.dmvow.model.pmml.common
{
	import mx.core.UIComponent;
	
	/**
	 * <p>
	 * <code>
	 * <xs:simpleType name="DATATYPE">
     *     <xs:restriction base="xs:string">
     *         <xs:enumeration value="string" />
     *         <xs:enumeration value="integer" />
     *         <xs:enumeration value="float" />
     *         <xs:enumeration value="double" />
     *         <xs:enumeration value="date"/>
     *         <xs:enumeration value="time" />
     *         <xs:enumeration value="dateTime" />
     *         <xs:enumeration value="dateDaysSince[0]" />
     *         <xs:enumeration value="dateDaysSince[1960]" />
     *         <xs:enumeration value="dateDaysSince[1970]" />
     *         <xs:enumeration value="dateDaysSince[1980]" />
     *         <xs:enumeration value="timeSeconds" />
     *         <xs:enumeration value="dateTimeSecondsSince[0]" />
     *         <xs:enumeration value="dateTimeSecondsSince[1960]" />
     *         <xs:enumeration value="dateTimeSecondsSince[1970]" />
     *         <xs:enumeration value="dateTimeSecondsSince[1980]" />
     *     </xs:restriction>
     * </xs:simpleType>
     * </code>
     * </p>
	 */
	public class DATATYPE
	{
		public static const STRING:String = "string";
		public static const INTEGER:String = "integer";
		public static const FLOAT:String = "float";
		public static const DOUBLE:String = "double";
		public static const DATE:String = "date";
		public static const TIME:String = "time";
		public static const DATE_TIME:String = "dateTime";
		public static const DATE_DAYS_SINCE_0:String = "dateDaysSince[0]";
		public static const DATE_DAYS_SINCE_1960:String = "dateDaysSince[1960]";
		public static const DATE_DAYS_SINCE_1970:String = "dateDaysSince[1970]";
		public static const DATE_DAYS_SINCE_1980:String = "dateDaysSince[1980]";
		public static const TIME_SECONDS:String = "timeSeconds";
		public static const DATE_TIME_SECONDS_SINCE_0:String = "dateTimeSecondsSince[0]";
		public static const DATE_TIME_SECONDS_SINCE_1960:String = "dateTimeSecondsSince[1960]";
		public static const DATE_TIME_SECONDS_SINCE_1970:String = "dateTimeSecondsSince[1970]";
		public static const DATE_TIME_SECONDS_SINCE_1980:String = "dateTimeSecondsSince[1980]";
	}
}
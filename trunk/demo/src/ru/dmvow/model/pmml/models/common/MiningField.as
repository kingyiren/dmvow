package ru.dmvow.model.pmml.models.common
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <xs:element name="MiningField">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="name" type="FIELD-NAME" use="required" />
	 *         <xs:attribute name="usageType" type="FIELD-USAGE-TYPE" default="active" />
	 *         <xs:attribute name="optype" type="OPTYPE" />
	 *         <xs:attribute name="importance" type="PROB-NUMBER" />
	 *         <xs:attribute name="outliers" type="OUTLIER-TREATMENT-METHOD" default="asIs" />
	 *         <xs:attribute name="lowValue" type="NUMBER" />
	 *         <xs:attribute name="highValue" type="NUMBER" />
	 *         <xs:attribute name="missingValueReplacement" type="xs:string" />
	 *         <xs:attribute name="missingValueTreatment" type="MISSING-VALUE-TREATMENT-METHOD" />
	 *         <xs:attribute name="invalidValueTreatment" type="INVALID-VALUE-TREATMENT-METHOD" default="returnInvalid" />
	 *     </xs:complexType>
	 * </xs:element>
	 */
	public class MiningField extends Extendable
	{
		public var name:String;
		/**
		 * Value from FIELD_USAGE_TYPE.
		 */
		public var usageType:String;
		/**
		 * Value from OPTYPE.
		 */
		public var optype:String;
		public var importance:Number;
		/**
		 * Value from OUTLIER_TREATMENT_METHOD.
		 */
		public var outliers:String;
		public var lowValue:Number;
		public var highValue:Number;
		public var missingValueReplacement:String;
		/**
		 * Value from MISSING_VALUE_TREATMENT_METHOD.
		 */
		public var missingValueTreatment:String;
		/**
		 * Value from INVALID_VALUE_TREATMENT_METHOD.
		 */
		public var invalidValueTreatment:String;
	}
}
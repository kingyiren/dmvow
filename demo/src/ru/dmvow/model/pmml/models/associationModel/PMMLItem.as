package ru.dmvow.model.pmml.models.associationModel
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="Item">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="id" type="xs:string" use="required" />
	 *         <xs:attribute name="value" type="xs:string" use="required" />
	 *         <xs:attribute name="mappedValue" type="xs:string" />
	 *         <xs:attribute name="weight" type="REAL-NUMBER" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class PMMLItem extends Extendable
	{
		/**
		 * Required.
		 */
		[Bindable]
		public var id:String;
		/**
		 * Required.
		 */
		[Bindable]
		public var value:String;
		/**
		 * Optional.
		 */
		[Bindable]
		public var mappedValue:String;
		/**
		 * Optional.
		 */
		[Bindable]
		public var weight:Number;
		
		public function toString():String
		{
			if (mappedValue)
				return value + " = " + mappedValue;
			else
				return value;
		}
	}
}
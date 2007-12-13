package ru.dmvow.model.pmml.dataDictionary
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="InlineTable">
	 *      <xs:complexType>
	 *          <xs:sequence>
	 *              <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded" />
	 *              <xs:element ref="row" minOccurs="0" maxOccurs="unbounded"/>
	 *          </xs:sequence>
	 *      </xs:complexType>
	 *  </xs:element>
	 * </code>
	 * </p>
	 */
	public class InlineTable extends Extendable
	{
		/**
		 * Array of objects of any type.
		 */
		public var rows:Array = new Array();
	}
}
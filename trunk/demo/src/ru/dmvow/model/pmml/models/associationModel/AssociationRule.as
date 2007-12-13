package ru.dmvow.model.pmml.models.associationModel
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="AssociationRule">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="antecedent" type="xs:string" use="required" />
	 *         <xs:attribute name="consequent" type="xs:string" use="required" />
	 *         <xs:attribute name="support" type="PROB-NUMBER" use="required" />
	 *         <xs:attribute name="confidence" type="PROB-NUMBER" use="required" />
	 *         <xs:attribute name="lift" type="xs:float" use="optional" />
	 *         <xs:attribute name="id" type="xs:string" use="optional" />
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class AssociationRule extends Extendable
	{
		/** Required. Some Itemset object. */
		public var antecedent:Itemset;
		/** Required. Some Itemset object. */
		public var consequent:Itemset;
		/** Required. In [0, 1]. */
		public var support:Number;
		/** Required. In [0, 1]. */
		public var confidence:Number;
		/** Optional. In [0, 1]. */
		public var lift:Number;
		/** Optional. */
		public var id:String;
	}
}
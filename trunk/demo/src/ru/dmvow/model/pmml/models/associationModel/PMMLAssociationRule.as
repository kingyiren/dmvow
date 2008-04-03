package ru.dmvow.model.pmml.models.associationModel
{
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;
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
public class PMMLAssociationRule extends Extendable implements IRule
{
	/** Required. Some PMMLItemset object. */
	public var antecedent:PMMLItemset;
	/** Required. Some PMMLItemset object. */
	public var consequent:PMMLItemset;
	/** Required. In [0, 1]. */
	public var support:Number = -1;
	/** Required. In [0, 1]. */
	public var confidence:Number = -1;
	/** Optional. In [0, 1]. */
	public var lift:Number = -1;
	public var leverage:Number = -1;
	public var coverage:Number = -1;
	/** Optional. */
	public var id:String;
	
	public function toString():String
	{
		return antecedent.toString() + "\n->\n" + consequent.toString();
	}

	public function get ruleAntecedent():IItemset
	{
		return antecedent;
	}
	
	public function get ruleConsequent():IItemset
	{
		return consequent;
	}
	
	public function get ruleConfidence():Number
	{
		return confidence;
	}
	
	public function get ruleSupport():Number
	{
		return support;
	}
	
	public function get ruleCoverage():Number
	{
		return coverage;
	}
	
	public function set ruleCoverage(value:Number):void
	{
		coverage = value;
	}
	
	public function get ruleLeverage():Number
	{
		return leverage;
	}
	
	public function set ruleLeverage(value:Number):void
	{
		leverage = value;
	}
	
	public function get ruleLift():Number
	{
		return lift;
	}
	
	public function set ruleLift(value:Number):void
	{
		lift = value;
	}
}
}
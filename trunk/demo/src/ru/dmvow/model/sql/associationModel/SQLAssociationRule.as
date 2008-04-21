package ru.dmvow.model.sql.associationModel
{
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;

public class SQLAssociationRule implements IRule
{
	public var uniqueName:String;
	/** Required. Some SQLItemset object. */
	public var antecedent:SQLItemset;
	/** Required. Some SQLItemset object. */
	public var consequent:SQLItemset;
	public var support:Number = -1;
	public var confidence:Number = -1;
	public var leverage:Number = -1;
	public var coverage:Number = -1;
	public var lift:Number = -1;
	
	public function toString():String
	{
		return antecedent.toString() + "\n->\n" + consequent.toString() + 
			"\n(supp: " + support.toFixed(3) + ", conf: " + confidence.toFixed(3) + ")";
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
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
	public var support:Number;
	public var confidence:Number;
	
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
}
}
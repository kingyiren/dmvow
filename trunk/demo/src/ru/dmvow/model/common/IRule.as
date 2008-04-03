package ru.dmvow.model.common
{
public interface IRule
{
	function get ruleAntecedent():IItemset;
	function get ruleConsequent():IItemset;
	function get ruleConfidence():Number;
	function get ruleSupport():Number;
	function get ruleCoverage():Number;
	function set ruleCoverage(value:Number):void;
	function get ruleLeverage():Number;
	function set ruleLeverage(value:Number):void;
	function get ruleLift():Number;
	function set ruleLift(value:Number):void;
}
}
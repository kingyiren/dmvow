package ru.dmvow.model.common
{
public interface IRule
{
	function get ruleAntecedent():IItemset;
	function get ruleConsequent():IItemset;
}
}
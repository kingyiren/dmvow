package ru.dmvow.model.view.clustering
{
import ru.dmvow.model.common.IRule;

public class Cluster
{
	public var clusterChildren:Array = new Array();
	public var rulesChildren:Array = new Array();
	[Bindable]
	public var height:Number = 0;
	[Bindable]
	public var level:Number = 0;
	[Bindable]
	public var avgSupport:Number = 0;
	[Bindable]
	public var avgConfidence:Number = 0;
	[Bindable]
	public var avgLift:Number = 0;
	[Bindable]
	public var mostFrequentAntecedentItems:Array = new Array();
	[Bindable]
	public var mostFrequentConsequentItems:Array = new Array();
	
	public function Cluster(rule:IRule = null)
	{
		if (rule)
		{
			clusterChildren.push(rule);
			rulesChildren.push(rule);
		}
	}
	
	public function addChild(cluster:Cluster):void
	{
		clusterChildren.push(cluster);
		rulesChildren = rulesChildren.concat(cluster.rulesChildren);
	}
	
	public function hasChild(cluster:Cluster):Boolean
	{
		return (clusterChildren.indexOf(cluster) >= 0);
	}
	
	public function ruleAt(index:Number):IRule
	{
		return IRule(rulesChildren[index]);
	}
	
	public function get size():Number
	{
		return rulesChildren.length;
	}
	
	public function get simple():Boolean
	{
		return (clusterChildren.length == 1);
	}
}
}
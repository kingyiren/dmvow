package ru.dmvow.control.filters.workers
{
import flash.utils.Dictionary;

import ru.dmvow.model.DataModel;
import ru.dmvow.model.common.IData;
import ru.dmvow.model.common.IItem;
import ru.dmvow.model.common.IItemset;
import ru.dmvow.model.common.IRule;
import ru.dmvow.model.supportTree.SupportTree;
import ru.dmvow.model.view.DMVoWModel;
import ru.dmvow.model.view.clustering.Cluster;
import ru.dmvow.model.view.processingList.items.ProcessingListItem;
import ru.dmvow.model.view.processingList.items.clusterFilter.ClusterFilterItem;
	
public class ClusteringWorker extends AbstractWorker
{
	private static var _lastInstance:ClusteringWorker;
	private var dmvowModel:DMVoWModel;
	private var dataModel:DataModel;
	private var filterItem:ClusterFilterItem;
	private var distCache:Dictionary = new Dictionary(false);
	private var topCluster:Cluster;
	
	public function ClusteringWorker(dataModel:DataModel)
	{
		_lastInstance = this;
		
		this.dataModel = dataModel;
		
		super();
	}
	
	override public function start(previousStepData:IData, processingListItem:ProcessingListItem, dmvowModel:DMVoWModel = null):void
	{
		this.dmvowModel = dmvowModel;
		this.previousStepData = previousStepData;
		this.filterItem = processingListItem as ClusterFilterItem;
		
		startProcess();
	}
	
	public static function get lastInstance():ClusteringWorker
	{
		return _lastInstance;
	}
	
	override protected function commonProcessActions():void
	{
		iData = previousStepData.clone();

		maxCounter = 1;
		
		// Do all the work here
		checkSupportTree();
		
		buildClusterTree();
	}
	
	override protected function processIteration():void
	{
		// Pause the process to wait for user's cluster choise.
		paused = true;
		
		dmvowModel.cluster = topCluster;
		dmvowModel.currentState = DMVoWModel.CLUSTER_STATE;
	}  
	
	override protected function reportComplete():void
	{
		cleanItemsets();
		
		cleanItems();
		
		filterItem.data = iData;
		
		super.reportComplete();
	}
	
	/**
	 * If the support tree for this Data Model is not built yet,
	 * this method builds it. Syncronous.
	 */	
	private function checkSupportTree():void
	{
		if (!dataModel.supportTree)
		{
			var tree:SupportTree = new SupportTree();
			var i:Number;
			
			// Add indexes to all items. If the items are indexed,
			// we can search the tree in a simple way.
			var items:Array = dataModel.data.dataModel.modelItems.source;
			for (i = 0; i < items.length; i++)
			{
				var item:IItem = IItem(items[i]);
				item.index = i;
			}
			
			// Add all itemsets
			var itemsets:Array = dataModel.data.dataModel.modelItemsets.source;
			for (i = 0; i < itemsets.length; i++)
			{
				var itemset:IItemset = IItemset(itemsets[i]);
				tree.updateSupportTreeWith(itemset.itemsetItems.source, itemset.itemsetSupport);
			} 
			
			// Add all rules
			var rules:Array = dataModel.data.dataModel.modelRules.source;
			for (i = 0; i < rules.length; i++)
			{
				var rule:IRule = IRule(rules[i]);
				// Let's join left and right sides of the rule,
				// clean duplicates and pass to the updateSupportTreeWith method
				var dict:Dictionary = new Dictionary(true);
				var antecedent:Array = rule.ruleAntecedent.itemsetItems.source;
				var consequent:Array = rule.ruleConsequent.itemsetItems.source;
				for (var j:Number = 0; j < antecedent.length; j++)
					dict[antecedent[j]] = antecedent[j];
				for (j = 0; j < consequent.length; j++)
					dict[consequent[j]] = consequent[j];
				var resulting:Array = new Array();
				for each (var p:IItem in dict)
					resulting.push(p);
					
				tree.updateSupportTreeWith(resulting, rule.ruleSupport);
			}
			
			dataModel.supportTree = tree;
		}
	}
	
	/**
	 * Builds the cluster tree. Syncronous.
	 * 
	 * 0. Добавить на текущий уровень все правила как кластеры из одного правила.
	 * 1. Выделить кластеры на текущем уровне.
	 *    1.0. Имеем множество объектов текущего уровня
	 *    1.1. Объединить каждый объект с наиболее близким к нему, получим кластеры следующего уровня.
	 *       1.1.1. Имеем массив кластеров следующего уровня (1, изначально пустой), временный (2) и 
	 *              постоянный (3) массив кластеров текущего уровня (изначально полный).
	 *       1.1.2. Извлекаем очередной элемент (а) из массива 2, ищем наиболее близкий к нему элемент 
	 *              из массива 3 (б) (формула расстояния м\у кластерами). Далее ищем в массиве 1 кластер, 
	 *              который содержал бы в себе элемент (а).
	 *       1.1.3. Если такой кластер есть, то добавляем наш элемент в найденый кластер.
	 *       1.1.3. Иначе ищем такой кластер, который уже содержит элемент (б).
	 *       1.1.4. Иначе, создадим новый кластер и добавим туда оба элемента.
	 *    1.2. Сохраним новый уровень как текущий, вычислим высоту для найденный кластеров (формула вычисления высоты кластера).
	 *    1.3. Запишем полученные кластеры в множество объектов текущего уровня.
	 * 2. Если на текущем уровне более одного объекта, снова.
	 */	
	private function buildClusterTree():void
	{
		var nextLevelClusters:Array = new Array();
		var currLevelClustersLeft:Array;
		var currLevelClusters:Array = new Array();
		var currLevel:Number = 0;
		
		// 0
		var tCluster1:Cluster;
		var tCluster2:Cluster;
		var i:Number;
		var j:Number;
		var rules:Array = dataModel.data.dataModel.modelRules.source;
		var rule:IRule;
		for (i = 0; i < rules.length; i++)
		{
			rule = IRule(rules[i]);
			tCluster1 = new Cluster(rule);
			currLevelClusters.push(tCluster1); 
		}
		
		do
		{
			currLevelClustersLeft = currLevelClusters.concat();
			while (currLevelClustersLeft.length > 0)
			{
				tCluster1 = currLevelClustersLeft.pop();
				
				// найти наиболее близкий из 3го массива
				var minDist:Number = Number.MAX_VALUE;
				var minCluster:Cluster = null;
				for (i = 0; i < currLevelClusters.length; i++)
				{
					tCluster2 = Cluster(currLevelClusters[i]);
					if (tCluster1 == tCluster2)
						continue;
						
					var dist:Number = clustersDistance(tCluster1, tCluster2);
					if (dist < minDist)
					{
						minDist = dist;
						minCluster = tCluster2;
					}
				}
				
				// проверим, может какой-то кластер уже содержит найденый элемент
				var found:Boolean = false;
				var parentCluster:Cluster;
				var tCluster3:Cluster;
				for (i = 0; i < nextLevelClusters.length; i++)
				{
					tCluster3 = nextLevelClusters[i];
					if (tCluster3.hasChild(minCluster))
					{
						found = true;
						parentCluster = tCluster3;
						break;
					}
					else if (tCluster3.hasChild(tCluster1))
					{
						found = true;
						parentCluster = tCluster3;
						break;
					}
				}
				
				if (found)
				{
					if (!parentCluster.hasChild(tCluster1))
						parentCluster.addChild(tCluster1);
					else if (!parentCluster.hasChild(minCluster))
						parentCluster.addChild(minCluster);
				}
				else
				{
					parentCluster = new Cluster();
					parentCluster.addChild(tCluster1);
					parentCluster.addChild(minCluster);
					nextLevelClusters.push(parentCluster);
				}
			}
			
			// Вычислим для новых кластеров 
			// высоты и сохраним как текущий уровень
			for (i = 0; i < nextLevelClusters.length; i++)
			{
				tCluster1 = Cluster(nextLevelClusters[i]);
				tCluster1.height = clusterHeight(tCluster1);
				tCluster1.level = currLevel;
				var someRule:IRule = tCluster1.rulesChildren[tCluster1.rulesChildren.length - 1];
				tCluster1.avgSupport = someRule.ruleSupport;
				tCluster1.avgConfidence = someRule.ruleConfidence;
				tCluster1.avgLift = someRule.ruleLift;
				tCluster1.mostFrequentAntecedentItems.push(someRule.ruleAntecedent.itemsetItems.getItemAt(0));
				tCluster1.mostFrequentConsequentItems.push(someRule.ruleConsequent.itemsetItems.getItemAt(0));
			}
			
			currLevel++;
			currLevelClusters = nextLevelClusters;
			nextLevelClusters = new Array();
		}
		while (currLevelClusters.length > 1)
		
		topCluster = Cluster(currLevelClusters[0]);
	}
	
	private function clustersDistance(cluster1:Cluster, cluster2:Cluster):Number
	{
		var result:Number = 0;
		
		if (cluster1.simple && cluster2.simple)
		{
			result = rulesDistance(cluster1.ruleAt(0), cluster2.ruleAt(0));
		}
		else
		{
			// d(a,b) = C(a,b) - 0.5 * (A(a) + A(b)).
			//
			// Where:
	        // C(a,b) = 1/(n(a) * n(b)) * S, 
	        // A(a) = 1/(n(a)^2) * S, 
	        // A(b) = 1/(n(b)^2) * S, 
	        // S = Summ(i)[Summ(j)[d(i,j)]]
	        // n(a) is the size of cluster a
	        var na:Number = cluster1.size;
	        var nb:Number = cluster2.size;
			var S:Number = 0;
			for (var i:Number = 0; i < na; i++)
				for (var j:Number = 0; j < nb; j++)
					S += rulesDistance(cluster1.ruleAt(i), cluster2.ruleAt(j));
			
			var Aa:Number = 1 / Math.pow(na, 2) * S;
			var Ab:Number = 1 / Math.pow(nb, 2) * S;
			var Cab:Number = 1 / (na * nb) * S;
			result = Cab - 0.5 * (Aa + Ab);
		}
		
		return result;
	}
	
	private function clusterHeight(cluster:Cluster):Number
	{
		var na:Number = cluster.rulesChildren.length;
		var result:Number = 0;
		for (var i:Number = 0; i < na; i++)
			for (var j:Number = 0; j < na; j++)
				result += rulesDistance(cluster.rulesChildren[i], cluster.rulesChildren[j]);
		
		result *= 2 / (na * (na - 1));
		
		return result;
	}
	
	/**
	 * Calculates and caches the distance between two rules.
	 */
	private function rulesDistance(rule1:IRule, rule2:IRule):Number
	{
		if (distCache[rule1])
			if (distCache[rule1][rule2])
				return Number(distCache[rule1][rule2]); 
		
		// If we are here, cache didn't work.
		var temp:Number = ruleConcatenationSupport(rule1, rule2);
		var result:Number = 1 - temp/(rule1.ruleSupport + rule2.ruleSupport - temp);
		
		if (result < 0 || result > 1)
			trace(ruleConcatenationSupport(rule1, rule2));
		
		// Let's cache result
		if (!distCache[rule1])
			distCache[rule1] = new Dictionary();
		distCache[rule1][rule2] = result;
		if (!distCache[rule2])
			distCache[rule2] = new Dictionary();
		distCache[rule2][rule1] = result;
			
		return result;
	}
	
	/**
	 * Here we need to try to find rule or itemset, that consists of the
	 * same items as the concatenation of rule1 and rule2.
	 */
	private function ruleConcatenationSupport(rule1:IRule, rule2:IRule):Number
	{
		// Let's join left and right sides of the rule,
		// clean duplicates and pass to the updateSupportTreeWith method
		var dict:Dictionary = new Dictionary(true);
		var antecedent1:Array = rule1.ruleAntecedent.itemsetItems.source;
		var consequent1:Array = rule1.ruleConsequent.itemsetItems.source;
		var antecedent2:Array = rule2.ruleAntecedent.itemsetItems.source;
		var consequent2:Array = rule2.ruleConsequent.itemsetItems.source;
		for (var j:Number = 0; j < antecedent1.length; j++)
			dict[antecedent1[j]] = antecedent1[j];
		for (j = 0; j < consequent1.length; j++)
			dict[consequent1[j]] = consequent1[j];
		for (j = 0; j < antecedent2.length; j++)
			dict[antecedent2[j]] = antecedent2[j];
		for (j = 0; j < consequent2.length; j++)
			dict[consequent2[j]] = consequent2[j]
		var resulting:Array = new Array();
		for each (var p:IItem in dict)
			resulting.push(p);
				
		var prediction:Number = dataModel.supportTree.getSupportTreeValue(resulting);
		if (prediction == 0)
			prediction = rule1.ruleSupport * rule2.ruleSupport;
			
		return prediction;
	}
}
}
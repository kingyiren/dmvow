package ru.dmvow.model.view
{
import mx.collections.ArrayCollection;

import ru.dmvow.model.DataModel;
import ru.dmvow.model.view.clustering.Cluster;

public class DMVoWModel
{
	public static const COMMON_STATE:String = "commonState";
	public static const CLUSTER_STATE:String = "clusterState";
	
	[Bindable]
	public var currentState:String = COMMON_STATE;
	[Bindable]
	[ArrayElementType("ru.dmvow.model.DataModel")] 
	public var models:ArrayCollection;
	[Bindable]
	public var selectedModel:DataModel;
	[Bindable]
	public var interestingMeasures:ArrayCollection = new ArrayCollection();
	
	/**
	 * The root of the cluster tree that must be shown at the moment.
	 */
	[Bindable]
	public var cluster:Cluster;
}
}
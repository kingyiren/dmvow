package ru.dmvow.view.cluster
{
import mx.core.UIComponent;

public class ClusterLink extends UIComponent
{
	public var parentCluster:SingleClusterView;
	public var childClusters:Array = new Array(); 
	public var inPlace:Boolean = false;
	
	public function ClusterLink()
	{
		super();
	}
	
	public function draw():void
	{
		if (!inPlace)
		{
			for each (var child:SingleClusterView in childClusters)
			{
				if (!child.inPlace)
					child.draw();
			}
			
			if (!parentCluster.inPlace)
				parentCluster.draw();
			
			graphics.clear();
			graphics.lineStyle(2, 0x888888, 1, true);
			
			var startX:Number = parentCluster.x + SingleClusterView.WIDTH/2;
			var startY:Number = parentCluster.y + SingleClusterView.HEIGHT;
			for (var i:Number = 0; i < childClusters.length; i++)
			{
				child = SingleClusterView(childClusters[i]);
				graphics.moveTo(startX, startY);
				graphics.lineTo(
					child.x + SingleClusterView.WIDTH/2,
					child.y);
			}
			inPlace = true;
		}
	}
	
	public function show():void
	{
		if (visible == true)
			return;
		
		visible = true;
		
		for each (var p:SingleClusterView in childClusters)
			p.show();
	}
	
	public function hide():void
	{
		if (visible == false)
			return;
			
		visible = false;
		
		for each (var p:SingleClusterView in childClusters)
			p.hide();
	}
}
}
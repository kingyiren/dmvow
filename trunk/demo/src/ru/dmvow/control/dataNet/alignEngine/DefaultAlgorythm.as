package ru.dmvow.control.dataNet.alignEngine
{
	import org.cove.ape.Group;
	import org.cove.ape.Vector;
	
	import ru.dmvow.view.field.dataNet.DataNetView;
	import ru.dmvow.view.field.dataNet.renderers.CommonNodeRenderer;
	
	public class DefaultAlgorythm extends AlignAlgorythm
	{
		public override function apply(dataNetView:DataNetView):void
		{
			if (dataNetView.groups.length == 0)
				return;
			
			// TODO: apply to any count of groups, now only for 1
			var group:Group = dataNetView.groups[0];
			var nodes:Array = group.particles;
			var node:CommonNodeRenderer;
			var nodeRadius:Number = CommonNodeRenderer.DEFAULT_WIDTH / 2 + 20;
			var circleRadius:Number = nodeRadius * 1.5;
			var currAngle:Number;
			var currCirclePosition:Number;
			var currCircleMaxPosition:Number;
			
			nodes = nodes.sort(arraySort);
			for (var i:Number = 0; i < nodes.length; )
			{
				currAngle = getAngleByRadius(circleRadius, nodeRadius);
				currCircleMaxPosition = Math.floor(360/currAngle);
				currAngle = 360/currCircleMaxPosition;
				for (currCirclePosition = 0; currCirclePosition < currCircleMaxPosition; currCirclePosition++)
				{
					if (i == nodes.length)
						break;
					node = nodes[i];
					i++;
					
					var realAngle:Number = - (currAngle * currCirclePosition) + 90;
					var pointX:Number = Math.cos(realAngle * Math.PI/180) * circleRadius;
					var pointY:Number = Math.sin(realAngle * Math.PI/180) * circleRadius;
					node.position = new Vector(pointX, pointY);
				}
				circleRadius += nodeRadius * 1.5;
			}
			
			var placeWidth:Number = dataNetView.width;
			var placeHeight:Number = dataNetView.height;
			dataNetView.container.x = placeWidth/2 - dataNetView.container.width/2;
			dataNetView.container.y = placeHeight/2 - dataNetView.container.height/2;
			var scale:Number = Math.min(1, placeWidth/dataNetView.container.width, placeWidth/dataNetView.container.height);
			dataNetView.container.scaleX = scale;
			dataNetView.container.scaleY = scale; 
		}
		
		public function arraySort(a:CommonNodeRenderer, b:CommonNodeRenderer):Number
		{
			var numALinks:Number = a.netNode.links.length;
			var numBLinks:Number = b.netNode.links.length;
			if (numALinks > numBLinks)
				return -1;
			else if (numALinks == numBLinks)
				return 0;
			else 
				return 1;
		}
		
		protected function getAngleByRadius(radius:Number, delta:Number):Number
		{
			return Math.acos(1 - Math.pow(delta, 2)/Math.pow(radius, 2)/2) * 180 / Math.PI;
		} 
	}
}
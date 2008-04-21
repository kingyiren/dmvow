package ru.dmvow.control.dataNet.builders
{
	import org.cove.ape.Group;
	
	import ru.dmvow.control.common.AsyncObject;
	import ru.dmvow.model.common.IRule;
	import ru.dmvow.model.view.dataNet.DataNet;
	import ru.dmvow.model.view.dataNet.NetLink;
	import ru.dmvow.model.view.dataNet.NetNode;
	import ru.dmvow.view.field.dataNet.renderers.CommonLinkRenderer;
	import ru.dmvow.view.field.dataNet.renderers.CommonNodeRenderer;

	public class DataNetViewBuilder extends AsyncObject
	{
		/** Array of Group objects for APEEngine */
		public var result:Array;
		protected var group:Group;
		protected var dataNet:DataNet;
		
		public function DataNetViewBuilder()
		{
			super();
		}
		
		public function build(dataNet:DataNet):void
		{
			this.dataNet = dataNet;
			startProcess();
		}
		
		override protected function commonProcessActions():void
		{
			result = new Array();
			group = new Group(true);
			result.push(group);
			
			var nodeRenderer:CommonNodeRenderer;
			for (var i:Number = 0; i < dataNet.nodes.length; i++)
			{
				nodeRenderer = new CommonNodeRenderer(dataNet.nodes[i]);
				group.addParticle(nodeRenderer);
			}
			
			maxCounter = dataNet.nodes.length;
		}
		
		override protected function processIteration():void
		{
			var currNode:NetNode = dataNet.nodes[counter];
			var linkRenderer:CommonLinkRenderer;
			var currLink:NetLink;
			var currLinkWeight:Number;
			var rule:IRule;
			for (var i:Number = 0; i < currNode.links.length; i++)
			{
				currLink = currNode.links[i];
				currLinkWeight = 2;
				for (var j:Number = 0; j < currLink.causedBy.length; j++)
				{
					rule = currLink.causedBy[j];
					currLinkWeight += rule.ruleSupport * 40;
				}
				currLinkWeight = Math.round(currLinkWeight);
				linkRenderer = new CommonLinkRenderer(
					group.particles[counter], 
					group.particles[getIndex(currLink.dest)],
					currLink.causedBy,
					currLinkWeight);
				group.addConstraint(linkRenderer); 
			}
		}
		
		protected function getIndex(target:NetNode):Number
		{
			for (var i:Number = 0; i < dataNet.nodes.length; i++)
			{
				if (dataNet.nodes[i] == target)
					return i;
			}
			
			return -1;
		}
	}
}
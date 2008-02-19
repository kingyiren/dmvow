package ru.dmvow.control.dataNet.builders
{
	import ru.dmvow.control.common.AsyncObject;
	import ru.dmvow.model.view.dataNet.DataNet;
	import ru.dmvow.model.view.dataNet.NetLink;
	import ru.dmvow.model.view.dataNet.NetNode;

	public class DataNetBuilder extends AsyncObject
	{
		public var result:DataNet; 
		
		public function DataNetBuilder()
		{
			super();
		}
		
		protected function getNetNodeByData(data:Object):NetNode
		{
			for each (var p:NetNode in result.nodes)
			{
				if (p.data == data)
					return p;
			}
			
			return null;
		}
		
		protected function getNetLink(source:NetNode, dest:NetNode):NetLink
		{
			var link:NetLink;
			for each (link in source.links)
			{
				if (link.dest == dest)
					return link;
			}
			
			link = new NetLink();
			link.source = source;
			link.dest = dest;
			source.links.push(link);
			
			return link;
		}
	}
}
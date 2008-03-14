package ru.dmvow.control.dataNet.builders
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import ru.dmvow.model.DataModel;
	import ru.dmvow.model.common.IData;
	import ru.dmvow.model.pmml.PMMLMiningModel;
	import ru.dmvow.model.sql.SQLMiningModel;
	import ru.dmvow.model.view.dataNet.DataNet;
	import ru.dmvow.model.view.dataNet.PreBuildDataNet;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="error", type="flash.events.ErrorEvent")]
	public class DataNetBuilders extends EventDispatcher
	{
		protected var pmmlBuilder:PMMLDataNetBuilder;
		protected var sqlBuilder:SQLDataNetBuilder;
		protected var targetBuilder:DataNetBuilder;
		public var result:DataNet;
		
		public function DataNetBuilders()
		{
			pmmlBuilder = new PMMLDataNetBuilder();
			pmmlBuilder.addEventListener(Event.COMPLETE, onBuilderComplete);
			pmmlBuilder.addEventListener(ErrorEvent.ERROR, onBuilderError);
			
			sqlBuilder = new SQLDataNetBuilder();
			sqlBuilder.addEventListener(Event.COMPLETE, onBuilderComplete);
			sqlBuilder.addEventListener(ErrorEvent.ERROR, onBuilderError);
		}
		
		/**
		 * Returns Array of PreParseDataNet objects
		 */
		public function getAvailableDataNets(data:IData):Array
		{
			var result:Array = new Array();
			var item:PreBuildDataNet; 
			//if (data.source == DataModel.FROM_PMML)
			//{
				item = new PreBuildDataNet();
				item.data = data;
				item.viewType = PreBuildDataNet.RULES_VIEW;
				result.push(item);
			
				item = new PreBuildDataNet();
				item.data = data;
				item.viewType = PreBuildDataNet.ITEMS_VIEW;
				result.push(item);
			/*}
			else if (data.source == DataModel.FROM_SQL)
			{
				item = new PreBuildDataNet();
				item.data = data;
				item.viewType = PreBuildDataNet.ITEMS_VIEW;
				result.push(item);
				
				item = new PreBuildDataNet();
				item.data = data;
				item.viewType = PreBuildDataNet.RULES_VIEW;
				result.push(item);
			}*/
			
			return result;
		}
		
		public function build(preParseDataNet:PreBuildDataNet):void
		{
			var result:DataNet;
			//if (preParseDataNet.data.source == DataModel.FROM_PMML)
			//{
				targetBuilder = pmmlBuilder;
				if (preParseDataNet.viewType == PreBuildDataNet.ITEMS_VIEW)
				{
					pmmlBuilder.createItemsNet(
						(preParseDataNet.data).dataModel);
				}
				else if (preParseDataNet.viewType == PreBuildDataNet.RULES_VIEW)
				{
					pmmlBuilder.createRulesNet(
						(preParseDataNet.data).dataModel);
				}
				else
				{
					reportError();
				}
			/*}
			else if (preParseDataNet.data.source == DataModel.FROM_SQL)
			{
				targetBuilder = sqlBuilder;
				if (preParseDataNet.viewType == PreBuildDataNet.ITEMS_VIEW)
				{
					sqlBuilder.createItemsNet(
						(preParseDataNet.data as SQLMiningModel).sqlData.model);
				}
				else if (preParseDataNet.viewType == PreBuildDataNet.RULES_VIEW)
				{
					sqlBuilder.createRulesNet(
						(preParseDataNet.data as SQLMiningModel).sqlData.model);
				}
				else  
				{
					reportError();
				}
			}
			else
			{
				reportError();
			}*/
		}
		
		protected function onBuilderComplete(event:Event):void
		{
			result = targetBuilder.result;
			
			reportComplete();
		}
		
		protected function onBuilderError(event:ErrorEvent):void
		{
			result = null;
			
			reportError();
		}
		
		protected function reportComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function reportError():void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
	}
}
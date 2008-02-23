package ru.dmvow.commands.sidePanels
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.pmml.SamplePMMLMiningModel;
	import ru.dmvow.model.sql.SampleSQLMiningModel;
	import ru.dmvow.model.view.interestingMeasures.InterestingMeasure;
	import ru.dmvow.model.view.interestingMeasures.SimpleMeasure;

	public class SidePanelsInitializeCommand implements ICommand
	{
		protected var samplePMML:SamplePMMLMiningModel;
		protected var sampleSQL:SampleSQLMiningModel;
		
		public function execute(event:CairngormEvent):void
		{
			// Add predefined interesting measures to model
			var simpleMeasure:SimpleMeasure;
			var item:InterestingMeasure;
			
			item = new InterestingMeasure();
			simpleMeasure = new SimpleMeasure(SimpleMeasure.SUPPORT);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.CONFIDENCE);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.LIFT);
			item.simpleMeasures.addItem(simpleMeasure);
			DMVoW.instance.model.interestingMeasures.addItem(item);
			
			item = new InterestingMeasure();
			simpleMeasure = new SimpleMeasure(SimpleMeasure.LEVERAGE);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.CONFIDENCE);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.COVERAGE);
			item.simpleMeasures.addItem(simpleMeasure);
			DMVoW.instance.model.interestingMeasures.addItem(item);
			
			item = new InterestingMeasure();
			simpleMeasure = new SimpleMeasure(SimpleMeasure.LIFT);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.LEVERAGE);
			item.simpleMeasures.addItem(simpleMeasure);
			simpleMeasure = new SimpleMeasure(SimpleMeasure.CONFIDENCE);
			item.simpleMeasures.addItem(simpleMeasure);
			DMVoW.instance.model.interestingMeasures.addItem(item);
			
			samplePMML = new SamplePMMLMiningModel();
			sampleSQL = new SampleSQLMiningModel();
			
			if (samplePMML.ready)
				initialize();
			else
				samplePMML.addEventListener(Event.COMPLETE, onSampleComplete);
			
			if (sampleSQL.ready)
				initialize();
			else
				sampleSQL.addEventListener(Event.COMPLETE, onSampleComplete);
		}
		
		protected function initialize():void
		{
			if (samplePMML.ready && sampleSQL.ready)
			{ 
				var models:ArrayCollection = new ArrayCollection();
				models.addItem(samplePMML.data);
				models.addItem(sampleSQL.data);
				DMVoW.instance.model.models = models;
			} 
		}
		
		protected function onSampleComplete(event:Event):void
		{
			initialize();
		}
	}
}
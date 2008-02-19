package ru.dmvow.control.boundary.pmmlParser
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import ru.dmvow.control.common.AsyncObject;
	import ru.dmvow.model.ModelError;
	import ru.dmvow.model.pmml.PMML;
	import ru.dmvow.model.pmml.common.Timestamp;
	import ru.dmvow.model.pmml.dataDictionary.DataDictionary;
	import ru.dmvow.model.pmml.dataDictionary.DataField;
	import ru.dmvow.model.pmml.header.Annotation;
	import ru.dmvow.model.pmml.header.Application;
	import ru.dmvow.model.pmml.header.Header;
	import ru.dmvow.model.pmml.miningBuildTask.MiningBuildTask;
	import ru.dmvow.model.pmml.transformationDictionary.TransformationDictionary;
	
	public class PMMLParser extends AsyncObject
	{
		public var result:PMML;
		protected var currentData:XML;
		protected var assotiationModelParser:AssociationModelParser;
		
		public function PMMLParser(associationModelParser:AssociationModelParser = null)
		{
			if (!associationModelParser)
				associationModelParser = new CustomAssociationModelParser();
				
			this.assotiationModelParser = associationModelParser;
		}
		
		public function simpleInputDataCheck(data:String):Boolean
		{
			return data.indexOf("<PMML") >= 0;
		}
		
		public function parseFromString(data:String):void
		{
			var xml:XML;
			try
			{
				currentData = new XML(data);
				
				startProcess();
			}
			catch (error: *)
			{
				trace("Error: " + error.toString());
				reportError();
			}
		}
		
		public function parseFromXML(xml:XML):void
		{
			currentData = xml;
			
			startProcess();
		}
		
		override protected function commonProcessActions():void
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			// For now the parse process is not really async
			maxCounter = 0;
			
			result = new PMML();
			try
			{
				// Check the simplest xml correctness
				if (currentData.localName() != "PMML")
					throw new ModelError(ModelError.FORMAT_ERROR);
				
				result.version = currentData.@version;
				
				result.header = parseHeader(currentData.Header[0]);
				if (currentData.MiningBuildTask.length() > 0)
					result.miningBuildTask = parseMiningBuildTask(currentData.MiningBuildTask[0]);
				result.dataDictionary = parseDataDictionary(currentData.DataDictionary[0]);
				if (currentData.TransformationDictionary.length() > 0)
					result.transformationDictionary = parseTransformationDictionary(currentData.TransformationDictionary[0]);
				
				for each (var node:XML in currentData.AssociationModel)
				{
					result.models.addItem(assotiationModelParser.parseAssociationModel(node));
				}
			}
			catch (error: *)
			{
				trace("Error: " + error.toString());
				reportError();
			}
		}
		
		protected function parseHeader(xml:XML):Header
		{
			var result:Header = new Header();
			
			result.copyright = xml.@copyright;
			result.description = xml.@description;
			
			if (xml.application.length() > 0)
				result.application = parseApplication(xml.application[0]);
			for each (var node:XML in xml.annotation)
			{
				result.annotations.addItem(parseAnnotation(node));
			}
			if (xml.timestamp.length() > 0)
				result.timestamp = parseTimestamp(xml.timestamp[0]);
			
			return result;
		}
		
		protected function parseApplication(xml:XML):Application
		{
			return null;
		}
		
		protected function parseAnnotation(xml:XML):Annotation
		{
			return null;
		}
		
		protected function parseTimestamp(xml:XML):Timestamp
		{
			return null;
		}
		
		protected function parseMiningBuildTask(xml:XML):MiningBuildTask
		{
			return null;
		}
		
		protected function parseDataDictionary(xml:XML):DataDictionary
		{
			var result:DataDictionary = new DataDictionary();
			
			result.numberOfFields = uint(xml.@numberOfFields);
			for each (var node:XML in xml.DataField)
			{
				result.dataFields.addItem(parseDataField(node));
			}
			
			return result;
		}
		
		protected function parseDataField(xml:XML):DataField
		{
			var result:DataField = new DataField();
			
			result.name = xml.@name;
			result.optype = xml.@optype;
			result.dataType = xml.@dataType;
			
			return result;
		}
		
		protected function parseTransformationDictionary(xml:XML):TransformationDictionary
		{
			return null;
		}
	}
}
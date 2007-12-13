package ru.dmvow.control.boundary
{
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
	
	public class PMMLParser
	{
		protected var assotiationModelParser:AssociationModelParser;
		
		public function PMMLParser(assotiationModelParser:AssociationModelParser = null)
		{
			if (!assotiationModelParser)
				assotiationModelParser = new AssociationModelParser();
				
			this.assotiationModelParser = assotiationModelParser;
		}
		
		public function parse(xml:XML):PMML
		{
			default xml namespace = "http://www.dmg.org/PMML-3_2";
			
			var result:PMML = new PMML();
			
			// Check the simplest xml correctness
			if (xml.localName() != "PMML")
				throw new ModelError(ModelError.FORMAT_ERROR);
			
			result.version = xml.@version;
			
			result.header = parseHeader(xml.Header[0]);
			if (xml.MiningBuildTask.length() > 0)
				result.miningBuildTask = parseMiningBuildTask(xml.MiningBuildTask[0]);
			result.dataDictionary = parseDataDictionary(xml.DataDictionary[0]);
			if (xml.TransformationDictionary.length() > 0)
				result.transformationDictionary = parseTransformationDictionary(xml.TransformationDictionary[0]);
			
			for each (var node:XML in xml.AssociationModel)
			{
				result.models.push(assotiationModelParser.parseAssociationModel(node));
			}
			
			return result;
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
				result.annotations.push(parseAnnotation(node));
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
				result.dataFields.push(parseDataField(node));
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
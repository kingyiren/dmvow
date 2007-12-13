package ru.dmvow.model.pmml
{
	import ru.dmvow.model.pmml.dataDictionary.DataDictionary;
	import ru.dmvow.model.pmml.header.Header;
	import ru.dmvow.model.pmml.miningBuildTask.MiningBuildTask;
	import ru.dmvow.model.pmml.transformationDictionary.TransformationDictionary;
	
	/**
	 * <p>
	 * <code>
	 * <xs:element name="PMML">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Header"/>
	 *             <xs:element ref="MiningBuildTask" minOccurs="0"/>
	 *             <xs:element ref="DataDictionary"/>
	 *             <xs:element ref="TransformationDictionary" minOccurs="0"/>
	 *             <xs:sequence minOccurs="0" maxOccurs="unbounded">
	 *                 <xs:choice>
	 *                     <xs:element ref="AssociationModel"/>
	 *                     <xs:element ref="ClusteringModel"/>
	 *                     <xs:element ref="GeneralRegressionModel"/>
	 *                     <xs:element ref="MiningModel"/>
	 *                     <xs:element ref="NaiveBayesModel"/>
	 *                     <xs:element ref="NeuralNetwork"/>
	 *                     <xs:element ref="RegressionModel"/>
	 *                     <xs:element ref="RuleSetModel"/>
	 *                     <xs:element ref="SequenceModel"/>
	 *                     <xs:element ref="SupportVectorMachineModel"/>
	 *                     <xs:element ref="TextModel"/>
	 *                     <xs:element ref="TreeModel"/>
	 *                 </xs:choice>
	 *             </xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="version" type="xs:string" use="required"/>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 */
	public class PMML
	{
		public var version:String;
		public var header:Header;
		public var mimingBuildTask:MiningBuildTask;
		public var dataDictionary:DataDictionary;
		public var transformationDictionary:TransformationDictionary;
		/**
		 * Array of MiningModel objects - models.
		 */
		public var models:Array = new Array();
	}
}
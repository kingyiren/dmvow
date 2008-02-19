package ru.dmvow.model.sql.associationModel
{
	public class SQLAssociationRule
	{
		public var uniqueName:String;
		/** Required. Some SQLItemset object. */
		public var antecedent:SQLItemset;
		/** Required. Some SQLItemset object. */
		public var consequent:SQLItemset;
		public var support:Number;
		public var confidence:Number;
		
		public function toString():String
		{
			return antecedent.toString() + "\n->\n" + consequent.toString();
		}
	}
}
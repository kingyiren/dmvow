package ru.dmvow.model.sql.associationModel
{
	import mx.collections.ArrayCollection;
	
	public class SQLItemset
	{
		/**
		 * Array of SQLItem objects. Can not be empty. 
		 */
		public var items:ArrayCollection = new ArrayCollection();
		public var uniqueName:String;
		public var support:Number;
		
		/** Source string */
		public var string:String;
		
		public function toString():String
		{
			return items.toString();
		}
	}
}
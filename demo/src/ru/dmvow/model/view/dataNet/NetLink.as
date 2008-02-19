package ru.dmvow.model.view.dataNet
{
	public class NetLink
	{
		public var source:NetNode;
		public var dest:NetNode;
		/** 
		 * Array of objects, that caused the link. 
		 * It is supposed to contain association rules.
		 * This data can be used while visualizing link.
		 */
		public var causedBy:Array = new Array();
	}
}
package ru.dmvow.model.view.processingList.items
{
	import flash.events.EventDispatcher;
	
	import ru.dmvow.model.common.IData;
	
	public class ProcessingListItem extends EventDispatcher
	{
		/*[Embed(source="/assets/icons/processing.swf", symbol="NeverProcessed")]
		protected var neverProcessed:Class;
		[Embed(source="/assets/icons/processing.swf", symbol="Empty")]
		protected var empty:Class;
		[Embed(source="/assets/icons/processing.swf", symbol="InProcess")]
		protected var inProcess:Class;
		[Embed(source="/assets/icons/processing.swf", symbol="Valid")]
		protected var valid:Class;
		[Embed(source="/assets/icons/processing.swf", symbol="NotValid")]
		protected var notValid:Class;*/
		
		public static const NEVER_PROCESSED:String = "neverProcessed";
		public static const EMPTY:String = "empty";
		public static const IN_PROCESS:String = "inProcess";
		public static const VALID:String = "valid";
		public static const NOT_VALID:String = "notValid"; 
		
		// PMML or SQL object.
		public var data:IData;
		protected var _status:String;
		protected var _isCurrent:Boolean;
		
		public function ProcessingListItem()
		{
			super();
		}
		
		/**
		 * Name for displaying in list.
		 */
		public function get name():String
		{
			throw new Error("Error.");
			
			return null;
		}
		
		[Bindable]
		public function set isCurrent(value:Boolean):void
		{
			_isCurrent = value;
		}
		
		public function get isCurrent():Boolean
		{
			return _isCurrent;
		}
		
		/**
		 * Status of this item.
		 */
		[Bindable]
		public function set status(value:String):void
		{
			_status = value;
		}
		
		public function get status():String
		{
			return EMPTY;
		}
		
		/**
		 * Regulates if this processing list item has
		 * "Edit" button.
		 */
		public function get editable():Boolean
		{
			return false;
		}
		
		/**
		 * Regulates if this item can be removed from
		 * processing list.
		 */
		public function get removable():Boolean
		{
			return false;
		}
		
		/**
		 * Regultes if this processing list item can
		 * be moved from one place in list to another.
		 */
		public function get movable():Boolean
		{
			return false;
		}
	}
}
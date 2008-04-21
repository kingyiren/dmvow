package ru.dmvow.view.cluster
{
	import mx.core.UIComponent;

	/**
	 * Simple grahic that looks like ====-- (horizontal bar).
	 */
	public class MiniHBar extends UIComponent
	{
		private var _value:Number = 0;
		private var _color:uint = 0x000000;
		private var _bgColor:uint = 0xAAAAAA;
		
		public function MiniHBar()
		{
			super();
		}
		
		[Bindable]
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			
			invalidateProperties();
		}
		
		[Bindable]
		public function get bgColor():uint
		{
			return _bgColor;
		}
		
		public function set bgColor(value:uint):void
		{
			_bgColor = value;
			
			invalidateProperties();
		}
		
		/**
		 * From 0 to 1.
		 */
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(val:Number):void
		{
			if (isNaN(val))
				val = 0;
			else if (val < 0)
				val = 0
			else if (val > 1)
				val = 1;
			
			_value = val;
			
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			graphics.clear();
			graphics.lineStyle(0, 0, 0);
			
			graphics.beginFill(_bgColor, 1);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			
			graphics.beginFill(_color, 1);
			graphics.drawRect(0, 0, width * _value, height);
			graphics.endFill();
		}
	}
}
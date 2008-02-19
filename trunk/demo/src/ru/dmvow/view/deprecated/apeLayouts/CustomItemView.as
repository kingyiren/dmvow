package ru.dmvow.view.apeLayouts
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	import org.cove.ape.RectangleParticle;
	import org.cove.ape.Vector;
	
	import ru.dmvow.model.custom.models.assotiationModel.CustomItem;
	
	public class CustomItemView extends RectangleParticle
	{
		protected var textField:TextField;
		protected var timer:Timer;
		
		public function CustomItemView(
			customItem:CustomItem,
			x:Number, 
			y:Number, 
			width:Number, 
			height:Number, 
			rotation:Number = 0, 
			fixed:Boolean = false,
			mass:Number = 100, 
			elasticity:Number = 0.01,
			friction:Number = 0) 
		{
			super(x, y, width, height, rotation, fixed, mass, elasticity, friction);
			
			textField = new TextField();
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = customItem.value + "::" + customItem.itemClass.className;
			textField.x = (- textField.width)/2;
			textField.y = (- textField.height)/2;
			
			setFill(0xDDDDDD, 0.8);
			setLine(0, 0xAAAAAA, 1);
			
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			sprite.addEventListener(Event.ADDED_TO_STAGE, onSpriteAddedToStage);
			
			timer = new Timer(1000/24);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public override function init():void {
			cleanup();
			if (displayObject != null) {
				initDisplay();
			} else {
			
				var w:Number = extents[0] * 2 - 6;
				var h:Number = extents[1] * 2 - 6;
				
				sprite.graphics.clear();
				sprite.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
				sprite.graphics.beginFill(fillColor, fillAlpha);
				sprite.graphics.drawRect(-w/2, -h/2, w, h);
				sprite.graphics.endFill();
			}
			paint();
		}
		
		public override function paint():void {
			super.paint();
			
			if (!textField.parent)
				sprite.addChild(textField);
		}
		
		// events
		
		protected function onSpriteAddedToStage(event:Event):void
		{
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseDown(event:Event):void
		{
			trace("onMouseDown");
			timer.start();
		}
		
		protected function onMouseUp(event:Event):void
		{
			trace("onMouseUp");
			timer.stop();
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			position = new Vector(position.x + sprite.mouseX/2, position.y + sprite.mouseY/2);
		}
	}
}
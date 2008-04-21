package ru.dmvow.view.field.dataNet.renderers
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.cove.ape.RectangleParticle;
	import org.cove.ape.Vector;
	
	import ru.dmvow.model.view.dataNet.NetNode;

	public class CommonNodeRenderer extends RectangleParticle
	{
		public static const DEFAULT_WIDTH:Number = 140;
		public static const DEFAULT_HEIGHT:Number = 30;
		public static const DEFAULT_MASS:Number = 1;
		public static const DEFAULT_ELASTICITY:Number = 0.3;
		public static const DEFAULT_FRICTION:Number = 0;
		
		public var netNode:NetNode;
		protected var textField:TextField;
		protected var timer:Timer;
		protected var initialized:Boolean = false;
		
		public function CommonNodeRenderer(
			netNode:NetNode,
			x:Number = 0, 
			y:Number = 0, 
			width:Number = DEFAULT_WIDTH, 
			height:Number = DEFAULT_HEIGHT,
			mass:Number = DEFAULT_MASS,
			elasticity:Number = DEFAULT_ELASTICITY,
			friction:Number = DEFAULT_FRICTION
			)
		{
			super(x, y, DEFAULT_WIDTH, DEFAULT_HEIGHT, 0, false, mass, elasticity, friction);
			
			this.netNode = netNode;
		}
		
		protected function initialize():void
		{
			if (initialized) 
				return
			else
				initialized = true;
			
			textField = new TextField();
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = netNode.toString();
			//textField.embedFonts = true;
			
			//var textFormat:TextFormat = new TextFormat("mainFont");
			//textField.setTextFormat(textFormat);
			
			textField.x = (- textField.width)/2;
			textField.y = (- textField.height)/2;
			width = textField.width + 10;
			height = textField.height + 10;
			
			setFill(0xFFFFFF, 1);
			setLine(0, 0xAAAAAA, 1);
			
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			if (sprite.stage)
				onSpriteAddedToStage(null);
			else
				sprite.addEventListener(Event.ADDED_TO_STAGE, onSpriteAddedToStage);
			
			timer = new Timer(1000/24);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public override function init():void {
			initialize();
			cleanup();
			if (displayObject != null) {
				initDisplay();
			} else {
				var w:Number = extents[0] * 2 - 6;
				var h:Number = extents[1] * 2 - 6;
				
				sprite.graphics.clear();
				sprite.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
				sprite.graphics.beginFill(fillColor, fillAlpha);
				sprite.graphics.drawRoundRect(-w/2, -h/2, w, h, 9, 9);
				sprite.graphics.endFill();
			}
			paint();
		}
		
		override public function paint():void {
			super.paint();
			
			if (!textField.parent)
			{
				sprite.buttonMode = true;
				sprite.useHandCursor = true;
				sprite.addChild(textField);
			}
		}
		
		// events
		
		protected function onSpriteAddedToStage(event:Event):void
		{
			sprite.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseDown(event:Event):void
		{
			timer.start();
		}
		
		protected function onMouseUp(event:Event):void
		{
			timer.stop();
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			position = new Vector(position.x + sprite.mouseX/2, position.y + sprite.mouseY/2);
		}
	}
}
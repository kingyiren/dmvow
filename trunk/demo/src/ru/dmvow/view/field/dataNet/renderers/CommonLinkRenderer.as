package ru.dmvow.view.field.dataNet.renderers
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import mx.managers.PopUpManager;
	
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.SpringConstraint;
	import org.cove.ape.Vector;

	public class CommonLinkRenderer extends SpringConstraint
	{
		protected var DEFAULT_REST_LENGTH:Number = 170;
		protected var causedBy:Array;
		protected var initialized:Boolean = false;
		protected var _hover:Boolean = false;
		protected var _showTip:Boolean = false;
		protected var popUp:LinkTip;
		
		public function CommonLinkRenderer(
			p1:AbstractParticle, 
			p2:AbstractParticle,
			causedBy:Array, 
			lineThickness:Number = 1,
			stiffness:Number=0.5, 
			collidable:Boolean=false, 
			rectHeight:Number=1, 
			rectScale:Number=1, 
			scaleToLength:Boolean=false)
		{
			this.lineThickness = lineThickness;
			this.causedBy = causedBy; 
			
			super(p1, p2, stiffness, collidable, rectHeight, rectScale, scaleToLength);
			
			restLength = DEFAULT_REST_LENGTH;
		}
		
		override public function paint():void
		{
			var start:Vector = new Vector(p1.px, p1.py);
			var delta:Vector = new Vector(p2.px - p1.px, p2.py - p1.py);
			var delta1:Vector = delta.mult(0.65);
			var delta2:Vector = delta1.mult(1 / delta1.magnitude()).multEquals(10);
			var delta3:Vector = delta1.plus(delta2);
			var t:Number = delta2.x;
			delta2.x = - delta2.y;
			delta2.y = t;
			
			if (!initialized)
			{
				initialized = true;
				sprite.addEventListener(MouseEvent.MOUSE_OVER, onSpriteOver, false, 0, true);
				sprite.addEventListener(MouseEvent.CLICK, onSpriteClick, false, 0, true);
				sprite.addEventListener(MouseEvent.MOUSE_OUT, onSpriteOut, false, 0, true);
				if (sprite.stage)
					sprite.stage.addEventListener(MouseEvent.CLICK, onStageClick, false, 0, true);
			}
			
			var sGraphics:Graphics = sprite.graphics;
			// Drawing the line itself
			sGraphics.clear();
			sGraphics.lineStyle(lineThickness, lineColor, lineAlpha);
			sGraphics.moveTo(p1.px, p1.py);
			sGraphics.lineTo(p2.px, p2.py);
			
			sGraphics.moveTo(p1.px + delta3.x, p1.py + delta3.y);
			sGraphics.lineTo(p1.px + delta1.x + delta2.x, p1.py + delta1.y + delta2.y);
			
			delta2.multEquals(-1);
			sGraphics.moveTo(p1.px + delta3.x, p1.py + delta3.y);
			sGraphics.lineTo(p1.px + delta1.x + delta2.x, p1.py + delta1.y + delta2.y);
			// Drawing the opaque background
			if (lineThickness < 7)
			{
				sGraphics.lineStyle(7, 0x000000, 0);
				sGraphics.moveTo(p1.px, p1.py);
				sGraphics.lineTo(p2.px, p2.py);
			}
		}
		
		protected function get hover():Boolean
		{
			return _hover;
		}
		
		protected function set hover(value:Boolean):void
		{
			_hover = value;
			
			if (_hover)
				sprite.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 255, 0);
			else
				sprite.transform.colorTransform = new ColorTransform();
		}
		
		protected function get showTip():Boolean
		{
			return _showTip;
		}
		
		protected function set showTip(value:Boolean):void
		{
			if (_showTip == value)
				return;
			
			_showTip = value;
			
			if (showTip)
			{
				if (!popUp)
				{
					popUp = new LinkTip();
					popUp.causedBy = causedBy;
				}
				popUp.x = sprite.stage.mouseX + 5;
				popUp.y = sprite.stage.mouseY + 5;
				PopUpManager.addPopUp(popUp, DMVoW.instance);
			}
			else
			{
				PopUpManager.removePopUp(popUp);
			}
		}
		
		protected function onSpriteOver(event:Event):void
		{
			hover = true;
		}
		
		protected function onSpriteOut(event:Event):void
		{
			hover = false;
		}
		
		protected function onSpriteClick(event:Event):void
		{
			showTip = true;
			
			event.stopImmediatePropagation();
		}
		
		protected function onStageClick(event:Event):void
		{
			showTip = false;
		}
	}
}
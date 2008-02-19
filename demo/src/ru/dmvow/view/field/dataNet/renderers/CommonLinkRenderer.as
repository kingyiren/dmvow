package ru.dmvow.view.field.dataNet.renderers
{
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.SpringConstraint;
	import org.cove.ape.Vector;

	public class CommonLinkRenderer extends SpringConstraint
	{
		protected var DEFAULT_REST_LENGTH:Number = 200;
		
		public function CommonLinkRenderer(p1:AbstractParticle, p2:AbstractParticle, stiffness:Number=0.0, collidable:Boolean=false, rectHeight:Number=1, rectScale:Number=1, scaleToLength:Boolean=false)
		{
			super(p1, p2, stiffness, collidable, rectHeight, rectScale, scaleToLength);
			
			restLength = DEFAULT_REST_LENGTH;
		}
		
		override public function paint():void
		{
			var start:Vector = new Vector(p1.px, p1.py);
			var delta:Vector = new Vector(p2.px - p1.px, p2.py - p1.py);
			delta.multEquals(0.8);
			
			sprite.graphics.clear();
			sprite.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			sprite.graphics.moveTo(p1.px, p1.py);
			sprite.graphics.lineTo(p1.px + delta.x, p1.py + delta.y);
			sprite.graphics.lineStyle(lineThickness, 0x00FF00, lineAlpha);
			sprite.graphics.lineTo(p2.px, p2.py);	
		}
	}
}
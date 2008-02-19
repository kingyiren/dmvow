package ru.dmvow.view.apeLayouts
{
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.Group;
	import org.cove.ape.SpringConstraint;
	import org.cove.ape.Vector;
	
	import ru.dmvow.model.custom.models.assotiationModel.CustomAssociationModel;
	import ru.dmvow.model.custom.models.assotiationModel.CustomItem;
	import ru.dmvow.model.pmml.models.associationModel.PMMLAssociationRule;
	import ru.dmvow.model.pmml.models.associationModel.PMMLItemset;

	public class DefaultLayout extends Group
	{
		protected var itemParticles:Dictionary = new Dictionary();
		protected var springs:Array = new Array();
		protected var timer:Timer = new Timer(30);
		
		public function DefaultLayout(model:CustomAssociationModel)
		{
			super(true);
			
			var i:Number;
			var j:Number;
			var k:Number;
			
			var x:Number;
			var y:Number;
			var width:Number;
			var height:Number;
			for (i = 0; i < model.items.length; i++)
			{
				var customItem:CustomItem = model.items.getItemAt(i) as CustomItem;
				x = 100 + 400 * Math.random();
				y = 100 + 400 * Math.random();
				width = 110;
				height = 30;
				var customItemView:CustomItemView = new CustomItemView(
					customItem,
					x,
					y,
					width,
					height);
				addParticle(customItemView);
				itemParticles[customItem] = customItemView;
			}
			
			for (i = 0; i < model.associationRules.length; i++)
			{
				var rule:PMMLAssociationRule = model.associationRules.getItemAt(i) as PMMLAssociationRule;
				var ant:Itemset = rule.antecedent;
				var con:Itemset = rule.consequent;
				
				for (j = 0; j <ant.items.length; j++)
				{
					for (k = 0; k < con.items.length; k++)
					{
						var fromParticle:AbstractParticle = itemParticles[ant.items.getItemAt(j)] as AbstractParticle;
						var toParticle:AbstractParticle = itemParticles[con.items.getItemAt(k)] as AbstractParticle;
						var spring:SpringConstraint = new CommonLinkRenderer(
							fromParticle,
							toParticle, 0.5, false, 5
							);
						spring.fixedEndLimit = 0.25;
						spring.setLine(2, 0x888888, rule.confidence);
						spring.sprite;
						addConstraint(spring);
						springs.push(spring);
					}
				} 
			}
			 
			for each (var particle:AbstractParticle in itemParticles)
			{
				var spriteParent:DisplayObjectContainer = particle.sprite.parent;
				spriteParent.setChildIndex(particle.sprite, spriteParent.numChildren-1);
			}
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			var summ:Number = 0;
			for each (var spring:SpringConstraint in springs)
			{
				summ += spring.stiffness *= 0.5;
			}
			
			if (summ < 0.0001)
			{
				timer.stop();
				for each (spring in springs)
					spring.stiffness = 0;
			}
			
			for each (var particle:AbstractParticle in itemParticles)
			{
				particle.velocity = new Vector(particle.velocity.x/2, particle.velocity.y/2);
			}
		}
		
	}
}
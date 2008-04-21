package ru.dmvow.control.dataNet
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.cove.ape.APEngine;
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.Group;
	import org.cove.ape.SpringConstraint;
	import org.cove.ape.Vector;
	
	import ru.dmvow.control.dataNet.alignEngine.AlignEngine;
	import ru.dmvow.view.field.dataNet.DataNetView;
	
	/**
	 * This class is used to control APEEngine and DataNetView 
	 * instances. When we need to show one of our data nets,
	 * it calls show() method. When it want us to hide it,
	 * it calls hide().  
	 */
	public class APEManager
	{
		protected static const TIMER_DELAY:Number = 1000/24;
		// protected static const TIMER_DELAY:Number = 100;
		protected static var apeInitialized:Boolean = false;
		protected static var showing:Boolean = false;
		protected static var timer:Timer;
		protected static var pauseTimer:Timer;
		protected static var particles:Array;
		protected static var springs:Array;
		protected static var paused:Boolean = false;
		
		public static function show(target:DataNetView, align:Boolean = true):void
		{
			checkInitialization();
			
			if (showing)
				hide();
			
			showing = true;
			
			var group:Group;
			APEngine.container = target.container;
			particles = new Array();
			springs = new Array();
			var totalItems:Number = 0;
			for each (group in target.groups)
			{
				totalItems += group.constraints.length;
				for each (var spring:SpringConstraint in group.constraints)
				{
					springs.push(spring);
				}
				
				totalItems += group.particles.length;
				for each (var particle:AbstractParticle in group.particles)
				{
					particles.push(particle);
				}
				APEngine.addGroup(group);
			}
			
			if (align)
			{
				AlignEngine.align(target);
			}
			
			if (totalItems < 130)
				timer.start();
			APEngine.step(false);
			APEngine.paint();
		}
		
		public static function pause():void
		{
			paused = true;
		}
		
		public static function unpause():void
		{
			paused = false;
		}
		
		public static function pauseFor(time:Number):void
		{
			if (!paused)
			{
				paused = true;
				
				pauseTimer.reset();
				pauseTimer.delay = time;
				pauseTimer.start();
			}
			else
			{
				pauseTimer.stop();
				pauseTimer.delay = time;
				pauseTimer.start();
			}
		}
		
		public static function hide():void
		{
			// TODO: remove from engine and stop engine
			if (showing)
			{
				showing = false;
				
				var group:Group;
				for each (group in APEngine.groups)
				{
					APEngine.removeGroup(group);
				}
				
				timer.stop();
			}
		}
		
		protected static function checkInitialization():void
		{
			if (!apeInitialized)
			{
				APEngine.init(1/4);
				
				timer = new Timer(TIMER_DELAY);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				
				pauseTimer = new Timer(1, 1);
				pauseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onPauseTimer);
				
				apeInitialized = true;
			}
		}
		
		protected static function slowerMotion():void
		{
			var spring:SpringConstraint;
			var particle:AbstractParticle;
			
			/*var summ:Number = 0;
			for each (spring in springs)
			{
				summ += spring.stiffness *= 0.5;
			}
			
			if (summ < 0.0001)
			{
				for each (spring in springs)
					spring.stiffness = 0;
			}*/
			
			for each (particle in particles)
			{
				particle.velocity = new Vector(particle.velocity.x/2, particle.velocity.y/2);
			}
		}
		
		protected static function onTimer(event:Event):void
		{
			if (!paused)
			{
				APEngine.step(true);
				APEngine.paint();
				
				slowerMotion();
			}
		}
		
		protected static function onPauseTimer(event:Event):void
		{
			paused = false;
		}
	}
}
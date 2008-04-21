package ru.dmvow.view.cluster
{
import flash.events.Event;

public class ClusterEvent extends Event
{
	public static const MINIMIZE:String = "minimize";
	public static const MAXIMIZE:String = "maximize";
	public static const DISCARD:String = "discard";
	public static const ENTER:String = "enter";
	
	public function ClusterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable);
	}
	
}
}
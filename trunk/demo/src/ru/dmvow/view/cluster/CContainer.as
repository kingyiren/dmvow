package ru.dmvow.view.cluster
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import mx.core.UIComponent;

public class CContainer extends UIComponent
{
	protected var realCont:Sprite;
	
	public function CContainer()
	{
		super();
		
		initContent();
	}
	
	override public function addChild(child:DisplayObject):DisplayObject
	{
		return realCont.addChild(child);
	}
	
	override public function addChildAt(child:DisplayObject, index:int):DisplayObject
	{
		return realCont.addChildAt(child, index);
	}
	
	override public function removeChild(child:DisplayObject):DisplayObject
	{
		return realCont.removeChild(child);
	}
	
	override public function removeChildAt(index:int):DisplayObject
	{
		return realCont.removeChildAt(index);
	}
	
	override public function get width():Number
	{
		return realCont.width;
	}
	
	override public function set width(value:Number):void
	{
		realCont.width = value;
	}
	
	override public function get height():Number
	{
		return realCont.height;
	}
	
	override public function set height(value:Number):void
	{
		realCont.height = value;
	}
	
	override public function get scaleX():Number
	{
		return realCont.scaleX;
	}
	
	override public function set scaleX(value:Number):void
	{
		realCont.scaleX = value;
	}
	
	override public function get scaleY():Number
	{
		return realCont.scaleY;
	}
	
	override public function set scaleY(value:Number):void
	{
		realCont.scaleY = value;
	}
	
	override public function get numChildren():int
	{
		return realCont.numChildren;
	}
	
	private function initContent():void
	{
		realCont = new Sprite();
		super.addChild(realCont);
	}
}
}
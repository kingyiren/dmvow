package ru.dmvow.model.supportTree
{
import flash.utils.Dictionary;

import ru.dmvow.model.common.IItem;

public class SupportTreeNode
{
	public var children:Dictionary = new Dictionary(true);
	public var item:IItem;
	public var support:Number;
	
	public function SupportTreeNode(item:IItem = null, support:Number = 0)
	{
		this.item = item;
		this.support = support;
	} 
}
}
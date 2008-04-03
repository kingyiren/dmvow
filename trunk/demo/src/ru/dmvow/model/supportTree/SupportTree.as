package ru.dmvow.model.supportTree
{
/**
 * This class represents the tree of items. Each node has
 * a support value, that is calculated as the suppport of
 * all items from this node to the root of the tree.
 * 
 * We suppose to get this tree from all the itemsets and
 * all the rules of the model.
 * 
 * Maybe in future we will grow up this tree with approximation
 * of additional itemsets and support.
 */
public class SupportTree
{
	// Array of SupportTreeNodes objects
	public var children:Array = new Array();
	
	public function hasItems(itemsArray:Array):Boolean
	{
		return false;
	}
	
	public function getItemsSupport(itemsArray:Array):Number
	{
		return 0;
	}
}
}
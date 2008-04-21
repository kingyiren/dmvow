package ru.dmvow.model.supportTree
{
	import flash.utils.Dictionary;
	
	import ru.dmvow.model.common.IItem;
	
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
	public var children:Dictionary = new Dictionary(true);
	
	/**
	 * Update the support tree structure (typically - add new nodes) from
	 * the given data.
	 * 
	 * @param items Array of IItem-s.
	 * @param support Support of this itemset.
	 */	
	public function updateSupportTreeWith(items:Array, support:Number):void
	{
		items = items.concat().sortOn("index", Array.NUMERIC);
		
		var firstItem:IItem = IItem(items.shift());
		var child:SupportTreeNode = children[firstItem] as SupportTreeNode; 
		if (!child)
		{
			child =
			children[firstItem] = new SupportTreeNode(firstItem);
		}
		updateIteration(child, items, support);
	}
	
	public function getSupportTreeValue(items:Array):Number
	{
		items = items.concat().sortOn("index", Array.NUMERIC);
		
		var firstItem:IItem = IItem(items.shift());
		var child:SupportTreeNode = children[firstItem] as SupportTreeNode; 
		if (!child)
		{
			items.push(firstItem);
			return getPredicted(null, items);
		}
		else
		{
			return getIteration(child, items);
		}
	}
	
	/**
	 * One iteration of tree update.
	 * @param child current parent tree node
	 * @param items items left to add (if they are not added yet) to the tree
	 * @param support support of all the combination
	 */	
	private function updateIteration(child:SupportTreeNode, items:Array, support:Number):void
	{
		if (items.length == 0)
		{
			child.support = support;
		}
		else
		{
			var nextItem:IItem = IItem(items.shift());
			var nextChild:SupportTreeNode = child.children[nextItem] as SupportTreeNode; 
			if (!nextChild)
			{
				nextChild =
				child.children[nextItem] = new SupportTreeNode(nextItem);
			}
			updateIteration(nextChild, items, support);
		}
	}
	
	private function getIteration(child:SupportTreeNode, items:Array):Number
	{
		if (items.length == 0)
		{
			return child.support;
		}
		else
		{
			var nextItem:IItem = IItem(items.shift());
			var nextChild:SupportTreeNode = child.children[nextItem]; 
			if (!nextChild)
			{
				items.push(nextItem);
				return getPredicted(child, items);
			}
			else
			{
				return getIteration(nextChild, items);
			}
		}	
	}
	
	/**
	 * This method is called when the tree doesn't have the actual support value
	 * for such items. Maybe we can predict here something, but for now it's 0. 
	 */	
	private function getPredicted(child:SupportTreeNode, items:Array):Number
	{
		//if (child)
		//	return child.support / Math.pow(2, items.length);
		//else
			return 0;
	}
}
}
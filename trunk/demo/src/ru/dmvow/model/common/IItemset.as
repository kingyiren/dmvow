package ru.dmvow.model.common
{
import mx.collections.ArrayCollection;

public interface IItemset
{
	function get itemsetItems():ArrayCollection;
	function get itemsetSupport():Number;
}
}
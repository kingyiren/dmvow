package ru.dmvow.model.common
{
	public interface IItem
	{
		function get itemName():String;
		function get itemValue():String;
		function get index():Number;
		function set index(value:Number):void;
	}
}
package ru.dmvow.model.pmml.header
{
	import ru.dmvow.model.pmml.common.Extendable;
	
	public class Header extends Extendable
	{
		public var copyright:String;
		public var description:String;
		public var application:Application;
		public var annotation:Annotation;
	}
}
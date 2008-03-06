package ru.dmvow.model.view.dataNet
{
	import ru.dmvow.model.common.IData;
	
	public class PreBuildDataNet
	{
		public static const ITEMS_VIEW:String = "items_view";
		public static const RULES_VIEW:String = "rules_view";
		
		public var viewType:String;
		public var data:IData;
		
		public function get viewTitle():String
		{
			if (viewType == ITEMS_VIEW)
			{
				return "Items view";
			}
			else if (viewType == RULES_VIEW)
			{
				return "Rules view";
			}
			else
			{
				return "Unknown viewType";
			}  
		}
	}
}
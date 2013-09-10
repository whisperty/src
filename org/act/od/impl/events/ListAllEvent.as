
package org.act.od.impl.events
{
	
	
	import flash.events.Event;
	import org.act.od.framework.control.OrDesignerEvent;
	import mx.collections.ArrayCollection;
	
	public class ListAllEvent extends OrDesignerEvent
	{
		
		public static const LIST:String = "ListAllEvent.list";
		
		public var filterOptions:Object = null;
		public var inPath:String = null;
		public var outPath:String = null
		
		public var array:ArrayCollection = null;
		
		
		
		
		
		
		public function ListAllEvent(type : String, dataParameter:Object = null ,
								 bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, dataParameter, bubbles, cancelable);
		}
	}
}
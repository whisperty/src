package org.act.od.impl.events
{
	
	
	import flash.events.Event;
	import org.act.od.framework.control.OrDesignerEvent;
	import mx.collections.ArrayCollection;
	
	public class RunEvent extends OrDesignerEvent
	{
		
		public static const RUN:String = "AccountEvent.run";
		
		public var filterOptions:Object = null;
		public var inPath:String = null;
		public var outPath:String = null
		
		public var array:ArrayCollection = null;
		
		
		
		
		
		
		public function RunEvent(type : String, dataParameter:Object = null ,
												  bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, dataParameter, bubbles, cancelable);
		}
	}
}
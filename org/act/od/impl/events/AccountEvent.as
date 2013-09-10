package org.act.od.impl.events
{
	
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class AccountEvent extends Event
	{
		
		public static const ADD:String = "AccountEvent.add";
		public static const ADDDATA:String = "AccountEvent.add.data";
		public static const GET_MONTHS:String = "AccountEvent.Get.Months"
		public var filterOptions:Object = null;
		
		public var strings:String = null;
		public var array:ArrayCollection = null;
		public function AccountEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
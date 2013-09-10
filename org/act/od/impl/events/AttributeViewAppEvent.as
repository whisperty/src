package org.act.od.impl.events
{
	import org.act.od.framework.control.OrDesignerEvent;
	/**
	 * This class define the events raised by the AttributeView.
	 */
	public class AttributeViewAppEvent extends OrDesignerEvent{
		/**
		 * Change the selected figure's attribute.
		 */ 
		public static const CHANGE_ATTRIBUTE : String = "change_attribute_AttributeView";
		/**
		 * Update the attributeView.
		 */ 
		public static const ATTRIBUTEVIEW_UPDATE :String = "attributeView_update_AttributeView";
		
		/**
		 * Constructor, takes the event name (type) and data object (defaults to null)
		 * and also defaults the standard Flex event properties bubbles and cancelable
		 * to true and false respectively.
		 */ 
		public function AttributeViewAppEvent(type : String, dataParameter:Object = null ,
				bubbles : Boolean = false, cancelable : Boolean = false){
			
			super(type, dataParameter, bubbles, cancelable);
		}

	}
}
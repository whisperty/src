package org.act.od.impl.events
{
	import org.act.od.framework.control.OrDesignerEvent;
	/**
	 * This class define the events raised by the DesignerToolBar.
	 */
	public class DesignerToolBarAppEvent extends OrDesignerEvent
	{
		/**
		 * Create a new project.
		 */
		public static const NEW_PROJECT :String = "new_project_DesignerToolBar";
		/**
		 * Create a new folder.
		 */
		public static const NEW_FOLDER :String = "new_folder_DesignerToolBar";
		/**
		 * Create a new file.
		 */
		public static const NEW_FILE :String = "new_file_DesignerToolBar";
		/**
		 * Save the selected file.
		 */ 
		public static const FILE_SAVE :String = "file_save_DesignerToolBar";
		/**
		 * Save all opening files.
		 */ 
		public static const FILE_SAVEALL :String = "file_saveall_DesignerToolBar";
		/**
		 * Create a new BPEL file.
		 */
		public static const CREATE_BPEL :String = "create_bpel_DesignerToolBar";
		/**
		 * Constructor, takes the event name (type) and data object (defaults to null)
		 * and also defaults the standard Flex event properties bubbles and cancelable
		 * to true and false respectively.
		 */ 
		public function DesignerToolBarAppEvent(type : String, dataParameter:Object = null,
											  bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, dataParameter, bubbles, cancelable);
		}

	}
}
package org.act.od.impl.commands
{
	import mx.controls.Alert;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FileIDManager;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.viewhelper.FileNavigatorViewVH;
	/**
	 * Create a new xmlFile in fileNavigator.
	 */ 
	public class NewFileCMD extends AODCommand
	{
		public function NewFileCMD(){
			super();
		}
		/**
		 * @param event {fileName}
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var fileNavigatorViewVH :FileNavigatorViewVH = 
					ViewLocator.getInstance().getViewHelper(FileNavigatorViewVH.VH_KEY) as FileNavigatorViewVH;
			var fileNavigatorViewModel :FileNavigatorViewModel =
					OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();

			if(fileNavigatorViewVH.getSelectedItem() != null 
				&& fileNavigatorViewVH.getSelectedItem().@type != FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE 
				){
					
				var exist:Boolean = false;
				var xmlList :XMLList = XMLList(fileNavigatorViewVH.getSelectedItem()).elements();
				for(var i :int = 0; i < xmlList.length(); i++){
					if(event.data.fileName == xmlList[i].@name)
						exist = true;
				}
				if(exist)
					Alert.show("This file name is exist.");
				else{
					var newFileNode:XML=<file/>;	
					newFileNode.@ID = FileIDManager.getAvailabelFileId();
					newFileNode.@name=event.data.fileName;
					newFileNode.@type=FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE;
					fileNavigatorViewVH.addAndExpandItem(fileNavigatorViewVH.getSelectedItem(), newFileNode, 0, true);
				}
				
			}else{
				Alert.show("Please select a  project or folder first.");
			}
		}
	}
}
package org.act.od.impl.commands
{
	import mx.controls.Alert;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.viewhelper.FileNavigatorViewVH;
	/**
	 * Create a new folder in fileNavigator.
	 */ 
	public class NewFolderCMD extends AODCommand
	{
		public function NewFolderCMD(){
			super();
		}
		/**
		 * @param event {folderName}
		 */ 
		override public function execute(event :OrDesignerEvent) :void{
			var fileNavigatorViewVH :FileNavigatorViewVH = 
					ViewLocator.getInstance().getViewHelper(FileNavigatorViewVH.VH_KEY) as FileNavigatorViewVH;
			var fileNavigatorViewModel :FileNavigatorViewModel =
					OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();
					
			if(fileNavigatorViewVH.getSelectedItem() != null 
				&& fileNavigatorViewVH.getSelectedItem().@type != FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE
				){
					
					
				var newFolderNode:XML = <folder/>;
				newFolderNode.@ID= "0"
				newFolderNode.@name=event.data.folderName;
				newFolderNode.@type="folder";
				var exist:Boolean = false;
				var xmlList :XMLList = XMLList(fileNavigatorViewVH.getSelectedItem()).elements();
				for(var i :int = 0; i < xmlList.length(); i++){
					if(event.data.folderName == xmlList[i].@name)
						exist = true;
				}
				if(exist)
					Alert.show("This folder name is exist.");
				else{
					fileNavigatorViewVH.addAndExpandItem(fileNavigatorViewVH.getSelectedItem(), newFolderNode, 0, true);
				}
			}
		}
	}
}
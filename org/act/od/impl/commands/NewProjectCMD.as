package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.viewhelper.FileNavigatorViewVH;
	import mx.controls.Alert;
	/**
	 * Create a new project in fileNavigator.
	 */ 
	public class NewProjectCMD extends AODCommand
	{
		public function NewProjectCMD(){
			super();
		}
		/**
		 * @param event {projectName}
		 */
		override public function execute(event :OrDesignerEvent) :void{
			var fileNavigatorViewVH :FileNavigatorViewVH = 
					ViewLocator.getInstance().getViewHelper(FileNavigatorViewVH.VH_KEY) as FileNavigatorViewVH;
			var fileNavigatorViewModel :FileNavigatorViewModel =
					OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();

			var newProjectNode:XML = <folder/>;
			newProjectNode.@ID="0";
			newProjectNode.@name=event.data.projectName;
			newProjectNode.@type="project";
			var exist:Boolean = false;
			for(var i :int = 0; i < fileNavigatorViewModel.xmlList.length(); i++){
				if(event.data.projectName == fileNavigatorViewModel.xmlList[i].@name)
					exist = true;
			}
			if(exist)
				Alert.show("This project name is exist.");
			else{
				fileNavigatorViewModel.xmlListCollection.addItem(newProjectNode);
			}
		}

	}
}
package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	import org.act.od.impl.viewhelper.FileNavigatorViewVH;
	/**
	 * Delete the selected file.
	 */ 
	public class FileDeleteCMD extends AODCommand{
		
		public function FileDeleteCMD(){
			super();
		}
		/**
		 * 
		 * @param event {fileID, type}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var fileNavigatorViewVH :FileNavigatorViewVH = 
					ViewLocator.getInstance().getViewHelper(FileNavigatorViewVH.VH_KEY) as FileNavigatorViewVH;
					
			var figureEditorNavigatorVH :FigureEditorNavigatorVH =
					ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
					
			var theParentItem :Object = fileNavigatorViewVH.getParentItem(fileNavigatorViewVH.getSelectedItem());
			
			var xmlList :XMLList = XMLList(theParentItem).elements();
			for(var i :int = 0; i < xmlList.length(); i++){
				if(xmlList[i].@ID == event.data.fileID)
					break;
			}
			fileNavigatorViewVH.getDataDescriptor().removeChildAt(theParentItem, fileNavigatorViewVH.getSelectedItem(), i);
			figureEditorNavigatorVH.CloseTabelByGivenFileID(event.data.fileID);
			
			var figureEditorNavigatorModel :FigureEditorNavigatorModel = OrDesignerModelLocator.getInstance().figureEditorNavigatorModel;
			
			if(event.data.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
				figureEditorNavigatorModel.deleteFigureEditorModel(event.data.fileID);
			
		}

	}
}
package org.act.od.impl.commands
{
	import mx.controls.Alert;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	import org.act.od.impl.viewhelper.FigureEditorVH;

	/**
	 * Close the FigureEditor page and then cancel it.
	 */ 
	public class CancleCloseFigureEditorCMD extends AODCommand
	{
		public function CancleCloseFigureEditorCMD()
		{
			super();
		}
		
		/**
		 * 
		 * @param event {closedFigureEditor}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			var closedFigureEditor : FigureEditor = event.data.closedFigureEditor as FigureEditor;
			
			if(closedFigureEditor == null)
				Alert.show("closedFigureEditor null in CancleCloseFigureEditorCMD");
			else {
				var closedFEModel : FigureEditorModel = closedFigureEditor.figureEditorModel;
				
				//readd cancled-closing figure editor
				var viewLoc : ViewLocator =  ViewLocator.getInstance();
				var feNavModel :FigureEditorNavigatorModel = 
					OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
				var feNavVH : FigureEditorNavigatorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
				feNavVH.createNewFigureEditor(closedFEModel, closedFigureEditor.filePath, closedFigureEditor.label);
				var feVH : FigureEditorVH = viewLoc.getViewHelper(FigureEditorVH.getViewHelperKey(closedFEModel.fileID)) as FigureEditorVH;
				
				//reset current state and active figure editor model
				feNavModel.activeFigureEditorModel = closedFigureEditor.figureEditorModel;
				
				feNavVH.SwithToGivenFileID(closedFEModel.fileID);
			}
		}
		
	}
}
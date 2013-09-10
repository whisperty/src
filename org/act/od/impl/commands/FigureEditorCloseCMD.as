package org.act.od.impl.commands
{
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.SelectionState;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.view.SaveChangeWindow;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	
	/**
	 * Close a figureEditor page.
	 */ 
	public class FigureEditorCloseCMD extends AODCommand{
		
		private var closedFE : FigureEditor;
		private var filePath :String;
		public function FigureEditorCloseCMD(){
			super();
		}
		
		/**
		 * 
		 * @param event {closedFE}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			closedFE = event.data.closedFE;
			filePath = closedFE.filePath;
			//parameter		
			var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
		
			var feNavModel :FigureEditorNavigatorModel = orDesModelLoc.getFigureEditorNavigatorModel();
			
			var feNavVH :FigureEditorNavigatorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
			
			var saveChangeWindow :SaveChangeWindow = SaveChangeWindow(
					PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveChangeWindow, true));
			//added by zjn 09.7.28
			saveChangeWindow.setClosedFE(closedFE);
			saveChangeWindow.setFileName(filePath.substring(filePath.lastIndexOf("/",filePath.length) + 1,filePath.length));
			saveChangeWindow.addEventListener(CloseEvent.CLOSE, updateCanvasXML);
			PopUpManager.centerPopUp(saveChangeWindow);
				
			orDesModelLoc.getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
			
			//as the last index figure editor page automatically become the active figure editor,
			//set the last figure editor model to be the active figure editor model
			var lastFeNavChild :FigureEditorNavigatorChild = feNavVH.getSelectedChildOfNavigator();
					
			if(lastFeNavChild != null) {
				if(lastFeNavChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE){
					feNavModel.activeFigureEditorModel = FigureEditor(lastFeNavChild).figureEditorModel;
					
				}
				
			}else {
				feNavModel.activeFigureEditorModel = null;
				
			}
			//reset attribute view's showing figure
			
			//comment by ty 20130703
			//orDesModelLoc.getAttributeViewModel().editedFigure = null;
			//orDesModelLoc.getAttributeViewModel().updateAttribute();
		}
		
		private function updateCanvasXML(event :CloseEvent):void{
//			closedFE.figureEditorModel.updateCanvasXML();
			closedFE.figureEditorModel.saveCanvasXML();
		}

	}
}
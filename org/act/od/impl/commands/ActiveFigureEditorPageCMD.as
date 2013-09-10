package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	
	
	/**
	 * Active the FigureEditor page, if not exist, creat a new one 
	 * @author lizq
	 * 
	 */
	public class ActiveFigureEditorPageCMD extends AODCommand{
		
		
		public function ActiveFigureEditorPageCMD(){
			super();
		}
		
		
		/**
		 * 
		 * @param event { fileID, filePath, fileName, figureEditorModel }
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var viewLoc :ViewLocator =  ViewLocator.getInstance();
			
			var feNavVH :FigureEditorNavigatorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
					
			var feNavModel :FigureEditorNavigatorModel = 
					OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			
			var feVH :FigureEditorVH;
			
			//1. find if the figureEditorPage exist		
			if( viewLoc.registrationExistsFor(FigureEditorVH.getViewHelperKey(event.data.fileID)) ){
				feVH = viewLoc.getViewHelper(FigureEditorVH.getViewHelperKey(event.data.fileID)) as FigureEditorVH;
				
			}else{ //2. creat new figureEditor
				feNavVH.createNewFigureEditor(event.data.figureEditorModel, event.data.filePath, event.data.fileName);
				feVH = viewLoc.getViewHelper(FigureEditorVH.getViewHelperKey(event.data.fileID)) as FigureEditorVH;
			}

			//3. set the activeModel
			feNavModel.activeFigureEditorModel = event.data.figureEditorModel;
			
			//4. swith tab of figureEditorNavigator
			feNavVH.SwithToGivenFileID(event.data.fileID);
			
		}

	}
}
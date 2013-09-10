package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	/**
	 * Save the active file
	 */ 
	public class FileSaveCMD extends AODCommand
	{
		private var figureEditorNavigatorVH :FigureEditorNavigatorVH;
		private var figureEditorNavigatorModel :FigureEditorNavigatorModel;
		public function FileSaveCMD(){
			figureEditorNavigatorVH = ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
			figureEditorNavigatorModel = OrDesignerModelLocator.getInstance().figureEditorNavigatorModel;
		}
		/**
		 * 
		 * @param event {}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			var activeFeNavChild :FigureEditorNavigatorChild = figureEditorNavigatorVH.getSelectedChildOfNavigator();
			if(activeFeNavChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE){
//				modifier  likexin
//				figureEditorNavigatorModel.activeFigureEditorModel.updateCanvasXML();
				figureEditorNavigatorModel.activeFigureEditorModel.saveCanvasXML();
			}
			
		}
	}
}
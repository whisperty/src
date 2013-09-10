package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	/**
	 * Save the all open file.
	 */ 
	public class FileSaveAllCMD extends AODCommand
	{
		private var figureEditorNavigatorVH :FigureEditorNavigatorVH;
		private var figureEditorNavigatorModel :FigureEditorNavigatorModel;
		public function FileSaveAllCMD(){
			figureEditorNavigatorVH = ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
		}
		/**
		 * 
		 * @param event 
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
		}

	}
}
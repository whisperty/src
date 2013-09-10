package org.act.od.impl.commands
{
	import Pattern.PatternModel;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	import org.act.od.impl.vo.BasicAttribute;

	/**
	 * 
	 */ 
	public class SetConnectionEndPointCMD extends AODCommand{
		
		//model
		private var orDesModelLoc : OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
		private var figureEditorNavModel : FigureEditorNavigatorModel = orDesModelLoc.getFigureEditorNavigatorModel();
		private var fcStateDomain : FigureCanvasStateDomain= orDesModelLoc.getFigureCanvasStateDomain();
		private var toolPanelModel : ToolPanelModel = orDesModelLoc.getToolPanelModel();
		
		//state information
		private var endFigure : IFigure;
		
		public function SetConnectionEndPointCMD(){
			super();
		}
		
		/**
		 * @param event{endFigure}
		 */
		override public function execute(event : OrDesignerEvent) : void {
			
			var endFigure : IFigure = event.data.endFigure as IFigure;
			var cf : ConnectionFigure = ConnectionFigure(toolPanelModel.selectedFigure);
			var startFigure :AbstractFigure = AbstractFigure(cf.getStartFigure());
			var startAtts :BasicAttribute = BasicAttribute(startFigure.attribute);
			var sPatMod :PatternModel = startAtts.patMode;
			
			if(endFigure != null){
				
				this.endFigure = endFigure;
/*				if(endFigure is SubProcessow2Figure)
					SubProcessow2Figure(endFigure).setPatModel(sPatMod);
				else if(endFigure is Endow2Figure)
					Endow2Figure(endFigure).setPatModel(sPatMod);*/
				cf.setEndFigure(endFigure);
				cf.autoSetAnchor();
				//added by zjn
				cf.setID(figureEditorNavModel.activeFigureEditorModel.idManager.getAvailabelId());
				figureEditorNavModel.activeFigureEditorModel.rootFigure.addchild(toolPanelModel.selectedFigure);
			}
		}
	}
}
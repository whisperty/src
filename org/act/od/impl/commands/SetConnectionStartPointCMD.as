package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.figure.Startow2Figure;
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.state.CreateConnectionEndState;
	import org.act.od.impl.viewhelper.FigureEditorVH;

	public class SetConnectionStartPointCMD extends AODCommand{
		
		
		public function SetConnectionStartPointCMD(){
			super();
		}
		
		/**
		 * 
		 * @param event [startFigure]
		 * 
		 */
		override public function execute(event : OrDesignerEvent) : void {
			
			//model
			var orDesModelLoc : OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			var feNavModel : FigureEditorNavigatorModel = orDesModelLoc.getFigureEditorNavigatorModel();
			var fcStateDomain : FigureCanvasStateDomain = orDesModelLoc.getFigureCanvasStateDomain();
			var toolPanelModel : ToolPanelModel = orDesModelLoc.getToolPanelModel();
		
			//state information
			var startFigure : IFigure = event.data.startFigure as IFigure;
			var curConnection : ConnectionFigure = ConnectionFigure(toolPanelModel.selectedFigure);
			
			curConnection.setStartFigure(startFigure);
			
			curConnection.setposition(startFigure.getrx(),startFigure.getry());
			if(startFigure is Startow2Figure)
			{
				Startow2Figure(startFigure).addLink(curConnection);
			}
				
			//add connection figure to active figure canvas
			var activeFEVHKey : String = FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID);
			var activeFEViewHelper : FigureEditorVH = ViewLocator.getInstance().getViewHelper(activeFEVHKey) as FigureEditorVH;
			if(activeFEViewHelper == null)
				throw new Error("activeFEViewHelper null");
			else				
				activeFEViewHelper.addFigureToCanvas(curConnection);
				
				
			var i:int;
			for(i=0;i<feNavModel.activeFigureEditorModel.selectedFigures.length;i++){
				IFigure(feNavModel.activeFigureEditorModel.selectedFigures[i]).hideContextPanel();
			}
			fcStateDomain.setFCActiveState(new CreateConnectionEndState());
			
			//!!!can consider write putting this command into stack here, because if the start figure
			//is null, there's no need to put this command into command stack
		}
	}
}
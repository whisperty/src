package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.state.CreateConnectionStartState;
	import org.act.od.impl.state.CreationState;

	/**
	 * Selectd a figure in the toolPanel.
	 */
	public class SelectFigureOfToolPanelCMD extends AODCommand{
		
		
		public function SelectFigureOfToolPanelCMD(){
			super();
		}
		
		/**
		 * @param event {selectedFigureId}
		 */
		override public function execute(event : OrDesignerEvent) :void{
			
			var orDesModelLoc : OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			
			var model : ToolPanelModel = orDesModelLoc.getToolPanelModel();
			
			var activeFEModel : FigureEditorModel = orDesModelLoc.getFigureEditorNavigatorModel().activeFigureEditorModel;
			
			var selectedFigureId : int = event.data.selectedFigureId as int;
			
			//if selected figure not null, then change the tool panel model's selectedFigure attribute value
			if(selectedFigureId != -1) {
			
				var selectedFigure : IFigure = FigureFactory.createFigure(selectedFigureId);
				
				selectedFigure.setMultiple(activeFEModel._showingMultiple);
				
				model.selectedFigure = selectedFigure;
			
				if(selectedFigure is ConnectionFigure){
					orDesModelLoc.getFigureCanvasStateDomain().setFCActiveState(new CreateConnectionStartState());
					
				}else if(selectedFigure is GraphicalFigure){
					orDesModelLoc.getFigureCanvasStateDomain().setFCActiveState(new CreationState());
				}
			
			}
		}
	}
}
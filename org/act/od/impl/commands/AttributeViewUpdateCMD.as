package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.RunningState;
	import org.act.od.impl.state.SelectionState;
	import org.act.od.impl.figure.Startow2Figure;
	
	/**
	 * Initialize the AttributeView by a seledted figure
	 */ 
	public class AttributeViewUpdateCMD extends AODCommand{
		
		
		public function AttributeViewUpdateCMD(){
			super();
		}
		
		
		/**
		 * 
		 * @param event {selectedFigure}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			
			var selectFig :AbstractFigure = event.data.selectedFigure as AbstractFigure;
				if(selectFig != null) {
					orDesModelLoc.getAttributeViewModel().editedFigure = selectFig;
					orDesModelLoc.getAttributeViewModel().attibutes = selectFig.getAttributeArray();
				}else {
					orDesModelLoc.getAttributeViewModel().editedFigure = null;
					orDesModelLoc.getAttributeViewModel().updateAttribute();
				}
					
		}

	}
}
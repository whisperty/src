package org.act.od.impl.commands
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;

	import org.act.od.impl.business.delegates.AccountDelegate;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.ToolPanelAppEvent;
	import org.act.od.impl.figure.FigureFactory;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;

	/**
	 * 
	 */ 
	public class NodeCreateLinkCMD extends AODCommand
	{
		public function NodeCreateLinkCMD(){
			super();
		}
		private var accounts:ArrayCollection = new ArrayCollection();
		
		/**
		 * @param event {startFigure}
		 */
		override public function execute(event:OrDesignerEvent):void{
			
			var orDesModelLoc : OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			var feNavModel : FigureEditorNavigatorModel = orDesModelLoc.getFigureEditorNavigatorModel();
			var fcStateDomain : FigureCanvasStateDomain = orDesModelLoc.getFigureCanvasStateDomain();
			var selectedFigureName:String="Link";
			var selectedFigId : int = FigureFactory.nametoid(selectedFigureName);
	

		
			new ToolPanelAppEvent( ToolPanelAppEvent.SELECT_FIGURE,
				{selectedFigureId :selectedFigId} ).dispatch();
				
			var startFigure : IFigure = event.data.startFigure as IFigure;
			new FigureCanvasAppEvent(FigureCanvasAppEvent.CREATE_CONNECTION_START,
				{startFigure :startFigure} ).dispatch();
			
		}
		
	}
}
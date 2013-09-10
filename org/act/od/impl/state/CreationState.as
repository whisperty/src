package org.act.od.impl.state{
	
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.viewhelper.FigureEditorVH;

	/**
	 * when click figure of the toolPanel, then switch to this state
	 * @author lizq
	 * 
	 */
	public class CreationState extends AbstractState{
		
		private var toolPanelModel :ToolPanelModel;
		
		private var feNavModel :FigureEditorNavigatorModel;
		
		public function CreationState(){
			super();
			this.toolPanelModel = OrDesignerModelLocator.getInstance().getToolPanelModel();
			this.feNavModel = 
				OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
		}

		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseDown(point :Point, event :MouseEvent) :void{
			this.fcStateDomain.setFCActiveState(new CreatingState());
			this.fcStateDomain.mouseDown(point,event);
			
		}
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseMove(point :Point,event :MouseEvent):void{
			
			var x:Number=point.x;
			var y:Number=point.y;
			
			var absFigure:AbstractFigure = AbstractFigure(toolPanelModel.selectedFigure);
			
			if(absFigure){ //redraw the figure
//				absFigure.drawclear();
				absFigure.setposition(x,y);
//				absFigure.drawpicture();
				absFigure.updateDraw();
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function RollOver(event :MouseEvent) :void{
			
			var feVH :FigureEditorVH = ViewLocator.getInstance().getViewHelper(
						FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID)) as FigureEditorVH;
			
			var absFigure:AbstractFigure = AbstractFigure(toolPanelModel.selectedFigure);
			
			//add new figure to figure canvas(VIEW)
			if(feVH == null)
				throw new Error("no binding with existed figure editor model");
			else {
				feVH.addFigureToCanvas(absFigure.getuic());
			}
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function RollOut(event :MouseEvent) :void{
			
			var feVH :FigureEditorVH = ViewLocator.getInstance().getViewHelper(
						FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID)) as FigureEditorVH;
			
			feVH.removeFiguresFromCanvas( DisplayObject(toolPanelModel.selectedFigure) );
			
			//if rollOut, then out of this state. add by lizq
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
			
		}
				
	}
}
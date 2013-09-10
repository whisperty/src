package org.act.od.impl.state
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	import org.act.od.impl.events.ToolPanelAppEvent;
	
	/**
	 * CreateConnectionEndState
	 * 
	 */
	public class CreateConnectionEndState extends AbstractState{
		
		private var toolPanelModel :ToolPanelModel;
		private var feNavModel :FigureEditorNavigatorModel;				
				
		public function CreateConnectionEndState(){
			
			super();
			this.toolPanelModel = OrDesignerModelLocator.getInstance().getToolPanelModel();
			this.feNavModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
		}

		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseMove(point:Point,event:MouseEvent):void{

			var ox : Number = point.x;
			var oy : Number = point.y;
			var cf : ConnectionFigure = ConnectionFigure(toolPanelModel.selectedFigure);

			//repaint while dragging
			cf.drawclear();
			cf.setTailposition(ox,oy);
			
			var p:Point=new Point(ox,oy);
			
			cf.setposition(GraphicalFigure(cf.getStartFigure()).getEdgePoint(p).x,
				GraphicalFigure(cf.getStartFigure()).getEdgePoint(p).y);
				
			cf.drawpicture();
			
			//and the connection to canvas again, for rollout reason, 
			var activeFEVHKey : String = FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID);
			var activeFEVH : FigureEditorVH = ViewLocator.getInstance().getViewHelper(activeFEVHKey) as FigureEditorVH;
			activeFEVH.addFigureToCanvas( cf.getuic());
		}
		
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseDown(point:Point,event:MouseEvent):void{

			var ox : Number = point.x;
			var oy : Number = point.y;
			var cf : ConnectionFigure = ConnectionFigure(toolPanelModel.selectedFigure);
			
			var endFigureT : IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(ox,oy);
			
			var str:String;
			var activeFEVHKey : String = FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID);
			var activeFEViewHelper : FigureEditorVH = ViewLocator.getInstance().getViewHelper(activeFEVHKey) as FigureEditorVH;
			
			if(endFigureT && (endFigureT is GraphicalFigure) && endFigureT != cf.getStartFigure() ){
						
				new FigureCanvasAppEvent(FigureCanvasAppEvent.CREATE_CONNECTION_END,
					{endFigure :endFigureT}).dispatch();
				
			}else{
				cf.setStartFigure(null);
				// is need to clear the connection? by lizq
//				toolPanelModel.selectedFigure.drawclear();remove by ly 2009-7-15
			
				activeFEViewHelper.removeFiguresFromCanvas(cf);//add by ly 2009-7-15
			}
			
			var selectedFigureName:String="Link";
			var selectedFigId : int = FigureFactory.nametoid(selectedFigureName);
			
			new ToolPanelAppEvent( ToolPanelAppEvent.SELECT_FIGURE,
				{selectedFigureId :selectedFigId} ).dispatch();

//			this.fcStateDomain.setFCActiveState(new SelectionState());
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function RollOut(event:MouseEvent):void{
			
			var activeFEVHKey : String = FigureEditorVH.getViewHelperKey(feNavModel.activeFigureEditorModel.fileID);
			var activeFEViewHelper : FigureEditorVH = ViewLocator.getInstance().getViewHelper(activeFEVHKey) as FigureEditorVH;
			
			activeFEViewHelper.removeFiguresFromCanvas(DisplayObject(toolPanelModel.selectedFigure));
			
		}
	}
}
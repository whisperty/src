package org.act.od.impl.state{

	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.AttributeViewModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;

	public class MovingState extends AbstractState{
		
		private var fx:Number=0;
		private var fy:Number=0;
		
		private var attributeViewModel :AttributeViewModel;
		private var figureENModel :FigureEditorNavigatorModel;

		public function MovingState(){
			super();
			
			this.attributeViewModel = 
				OrDesignerModelLocator.getInstance().getAttributeViewModel();
				
			this.figureENModel = 
				OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
		}
				
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseDown(point:Point,event:MouseEvent):void{
			var tempArr:Array = figureENModel.activeFigureEditorModel.selectedFigures;
			var i:int;
			for(i=0;i<tempArr.length;i++){
				IFigure(tempArr[i]).setIsShowContextPanel(false);
			}
			fx = point.x;
			fy = point.y;
		}
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseUp(point:Point,event:MouseEvent):void{
			var i:int;
			
			var tempArr:Array = figureENModel.activeFigureEditorModel.selectedFigures;
			if(tempArr.length==1){
				IFigure(tempArr[0]).setIsShowContextPanel(true);
				OrDesignerModelLocator.getInstance().getAttributeViewModel().editedFigure = AbstractFigure(tempArr[0]);
				IFigure(tempArr[0]).updateDraw();
			}
			else{
				for(i=0;i<tempArr.length;i++){
					IFigure(tempArr[i]).setIsShowContextPanel(false);
					IFigure(tempArr[i]).updateDraw();
				}
			}
			this.fcStateDomain.setFCActiveState(new SelectionState());
		}
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseMove(point:Point,event:MouseEvent):void{

			var tempArr:Array;
			var tempIFigure:IFigure;
			var dx:Number;
			var dy:Number;
			var x:Number=point.x;
			var y:Number=point.y;
			
			tempArr = figureENModel.activeFigureEditorModel.selectedFigures;

			dx=x-fx;
			dy=y-fy;
			
			for(var i:int=0; i<tempArr.length; i++){
				
				tempIFigure=IFigure(tempArr[i]);
				if(tempIFigure is ConnectionFigure){
					continue;
				}
				
				tempIFigure.setposition(tempIFigure.getdrawx()+dx,tempIFigure.getdrawy()+dy);
				tempIFigure.updateDraw();
			}
			fx=x;
			fy=y;
		}
		
	}
}
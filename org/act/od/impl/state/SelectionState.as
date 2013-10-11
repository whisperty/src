package org.act.od.impl.state
{
	
	import Pattern.PatternModel;
	
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	
	


	/**
	 * 
	 * @author lizq
	 */
	public class SelectionState extends AbstractState{
		
		private var feNavModel :FigureEditorNavigatorModel;
		private var  attrViewModel :AttributeViewModel;
//		private var patMod:PatternModel;
		
		public function SelectionState(){
			super();
			this.feNavModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			this.attrViewModel = OrDesignerModelLocator.getInstance().getAttributeViewModel();
//			this.patMod = OrDesignerModelLocator.getInstance().figureEditorNavigatorModel.activeFigureEditorModel.getPatModel();
		}
		
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		
		override public function mouseDown(point:Point, event:MouseEvent):void{

			var ox:Number=point.x;
			var oy:Number=point.y;
			var i:int;
			var num:int;
			var j:int;

			var selectedFigures:Array = feNavModel.activeFigureEditorModel.selectedFigures;
/*			if (selectedFigures.length == 1 && selectedFigures[0] is Startow2Figure)
			{
				//Startow2Figure(selectedFigures[0]).setPatModel(patMod);
				feNavModel.activeFigureEditorModel.setPatModel(patMod);
			}*/
		
			for(i=0; i<selectedFigures.length; i++){
				num = IFigure(selectedFigures[i]).changedirection(ox,oy);
				if(num!=0){ 
					for(j=0;j<selectedFigures.length;j++)
					{
						IFigure(selectedFigures[j]).hideContextPanel();
					}
					this.fcStateDomain.setFCActiveState(new ChangeSizeState(IFigure(selectedFigures[i]), num));
					return;
				}
			}
			
			if(!event.ctrlKey){
				this.clickXY(point,event);
			}else{
				this.ctrlClickXY(point,event);
			}
		}
		
		
		private function clickXY(point:Point,event:MouseEvent):void{
			var x:Number=point.x;
			var y:Number=point.y;
			var selectedFigures:Array=feNavModel.activeFigureEditorModel.selectedFigures;
			var temp:IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(x,y);
			var i:int;
			
			if(temp!=null)
			{
				
				if(selectedFigures.indexOf(temp)==-1){
					feNavModel.activeFigureEditorModel.resetSelectedFigure();
				}
				
				temp.ifiguretoarray(selectedFigures);
				
				if(temp.isin(x,y)==1){
					OrDesignerModelLocator.getInstance().getAttributeViewModel().editedFigure = AbstractFigure(temp);
					this.fcStateDomain.setFCActiveState(new MovingState());
					this.fcStateDomain.mouseDown(point,event);
				}
				
			}
			else
			{
				feNavModel.activeFigureEditorModel.resetSelectedFigure();
				this.fcStateDomain.setFCActiveState(new MultiSelectionState());
				this.fcStateDomain.mouseDown(point,event);
			}
			
			for(i=0;i<selectedFigures.length;i++){
				AbstractFigure(selectedFigures[i]).setSelected(true);
				AbstractFigure(selectedFigures[i]).updateDraw();
			}
		}
		
		
		private function ctrlClickXY(point:Point,event:MouseEvent):void{
			var x:Number=point.x;
			var y:Number=point.y;
			var selectedFigures:Array=feNavModel.activeFigureEditorModel.selectedFigures;
			var temp:IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(x,y);
			
			if(temp!=null)
			{
				
				if(selectedFigures.indexOf(temp)==-1)
				{
					temp.ifiguretoarray(selectedFigures);
					temp.setSelected(true);
					
				}
				else
				{
					selectedFigures.splice(selectedFigures.indexOf(temp),1);
					temp.setSelected(false);
				}
				
				temp.updateDraw();
				
			}
		}
		
		
		
		/**
		 * 
		 * @param event
		 * 
		 */
		override public function keyDown(event:KeyboardEvent):void{
			
			
			
			
			// figure delete handle
			if(event.keyCode==46){//del	
				if( feNavModel.activeFigureEditorModel == null ){
						throw new Error("no ActiveFigureEditorModel!");
					}	
					
				new FigureCanvasAppEvent(FigureCanvasAppEvent.POP_FIGURE_DELETE_CONFIRM, 
										 {fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
				return;
			}
			
			
			// figure copy handle
			if(event.keyCode==71){//CG
				if(event.ctrlKey){
					if( feNavModel.activeFigureEditorModel == null ){
						throw new Error("no ActiveFigureEditorModel!");
					}
					new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_COPY,
							{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
				}
				return;
			}
			
			
			//figure paste handle
			if(event.keyCode==85){//VU
				if(event.ctrlKey){
					if( feNavModel.activeFigureEditorModel == null ){
						throw new Error("no ActiveFigureEditorModel!");
					}
					new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_PASTE, 
							{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
				}
				return;
			}
			
			
			
			if(event.keyCode==37){//LEFT
			
				if( feNavModel.activeFigureEditorModel == null ){
					throw new Error("no ActiveFigureEditorModel!");
				}
				new FigureCanvasAppEvent(FigureCanvasAppEvent.MOVE_LEFT,
						{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
			
			
				return;
			}
			
			
			if(event.keyCode==38){//UP
			
				if( feNavModel.activeFigureEditorModel == null ){
					throw new Error("no ActiveFigureEditorModel!");
				}
				new FigureCanvasAppEvent(FigureCanvasAppEvent.MOVE_UP,
						{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
			
			
				return;
			}
			
			
			if(event.keyCode==39){//RIGHT
			
				if( feNavModel.activeFigureEditorModel == null ){
					throw new Error("no ActiveFigureEditorModel!");
				}
				new FigureCanvasAppEvent(FigureCanvasAppEvent.MOVE_RIGHT,
						{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
			
			
				return;
			}
			
			
			if(event.keyCode==40){//DOWN
			
				if( feNavModel.activeFigureEditorModel == null ){
					throw new Error("no ActiveFigureEditorModel!");
				}
				new FigureCanvasAppEvent(FigureCanvasAppEvent.MOVE_DOWN,
						{fileID :feNavModel.activeFigureEditorModel.fileID} ).dispatch();
			
			
			
				return;
			}
			
			
		}
		
		//ty 2013.10.11
		override public function mouseDoubleClick(point:Point, event:MouseEvent):void
		{
			var tempFigure :IFigure = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel.rootFigure.getupperfigure(point.x, point.y);
			if(tempFigure is Selectow2Figure) {
				new FigureCanvasAppEvent(FigureCanvasAppEvent.CREATE_NEW_SELECT, {selectow2Figure:tempFigure}).dispatch();
			}
			if(tempFigure is Projectow2Figure){
				new FigureCanvasAppEvent(FigureCanvasAppEvent.EDIT_PROJECT_PARAMETER, {Projectow2Figure:tempFigure}).dispatch();
				
			}else if(tempFigure is Startow2Figure){
				new FigureCanvasAppEvent(FigureCanvasAppEvent.EDIT_PROJECT_PATTERN, {startow2Figure:tempFigure}).dispatch();
			}
		}
		
	}
}

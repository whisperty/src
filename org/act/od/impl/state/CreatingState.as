package org.act.od.impl.state{

	
	import Pattern.PatternModel;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.Endow2Figure;
	import org.act.od.impl.figure.Startow2Figure;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.view.FigureCreateFailedWarning;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.view.SelectModel;
	import org.act.od.impl.view.SelectProperty;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	import org.act.od.impl.vo.BasicAttribute;

	/**
	 * process of drag creating
	 * @author lizq
	 * 
	 */
	public class CreatingState extends AbstractState{
	
		public var ox:Number=0;
		public var oy:Number=0;
		
		private var figureENModel :FigureEditorNavigatorModel;
		
		private var toolPanelModel :ToolPanelModel;
		
		public function CreatingState(){
			super();
			
			this.figureENModel = 
				OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			this.toolPanelModel = OrDesignerModelLocator.getInstance().getToolPanelModel();
		}
		
				
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseDown(point:Point,event:MouseEvent):void{
			
			ox=point.x;
			oy=point.y;
			
		}
		
		/**
		 * 
		 * @param point
		 * @param event
		 * 
		 */
		override public function mouseUp(point:Point,event:MouseEvent):void
		{
			
			this.fcStateDomain.setFCActiveState(new SelectionState());
			var i:int;
			var arr:Array;
			var fcfw :FigureCreateFailedWarning;
			var feVH :FigureEditorVH;
			if(this.toolPanelModel.selectedFigure is Startow2Figure)
			{
				arr=new Array();
				this.figureENModel.activeFigureEditorModel.rootFigure.ifiguretoarray(arr);
				for(i=0;i<arr.length;i++)
				{
					if(arr[i] is Startow2Figure)
					{
						fcfw = PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),
															 FigureCreateFailedWarning, true) as FigureCreateFailedWarning;

						PopUpManager.centerPopUp(fcfw);
						feVH = ViewLocator.getInstance().getViewHelper(
									FigureEditorVH.getViewHelperKey(figureENModel.activeFigureEditorModel.fileID)) as FigureEditorVH;
						feVH.removeFiguresFromCanvas( DisplayObject(toolPanelModel.selectedFigure) );
						return;
					}
					else
					{
						continue;
					}
				}
			}
			if(this.toolPanelModel.selectedFigure is Endow2Figure){
				arr=new Array();
				this.figureENModel.activeFigureEditorModel.rootFigure.ifiguretoarray(arr);
				for(i=0;i<arr.length;i++){
					if(arr[i] is Endow2Figure){
						fcfw = PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),
															 FigureCreateFailedWarning, true) as FigureCreateFailedWarning;

					
						PopUpManager.centerPopUp(fcfw);
						feVH = ViewLocator.getInstance().getViewHelper(
									FigureEditorVH.getViewHelperKey(figureENModel.activeFigureEditorModel.fileID)) as FigureEditorVH;
						feVH.removeFiguresFromCanvas( DisplayObject(toolPanelModel.selectedFigure) );
						return;
					}
					else{
						continue;
					}
				}
			}

			
			//modified by zjn
			this.toolPanelModel.selectedFigure.setID(figureENModel.activeFigureEditorModel.idManager.getAvailabelId());
			
			
		
			if(this.toolPanelModel.selectedFigure is Startow2Figure)
			{
			
/*				var fcfw1 :SelectModel;
				fcfw1 = PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),
					SelectModel, true) as SelectModel;
				fcfw1.width = 350;
				fcfw1.height = 180;
				fcfw1.callbackFunction = this.setModFunction;
				PopUpManager.centerPopUp(fcfw1);*/
				this.figureENModel.activeFigureEditorModel.rootFigure.addchild(this.toolPanelModel.selectedFigure);
//				new FigureCanvasAppEvent(FigureCanvasAppEvent.EDIT_PROJECT_PATTERN, {startow2Figure:toolPanelModel.selectedFigure}).dispatch();
				
			}else{
				this.figureENModel.activeFigureEditorModel.rootFigure.addchild(this.toolPanelModel.selectedFigure);

			}
			this.toolPanelModel.selectedFigure.updateDraw();
		
			var vl:ViewLocator=ViewLocator.getInstance();
			var fenVH:FigureEditorNavigatorVH=FigureEditorNavigatorVH(vl.getViewHelper(FigureEditorNavigatorVH.VH_KEY));
			FigureEditor(fenVH.getSelectedChildOfNavigator()).toolPanel.resetAllSelections();
			
//			this.toolPanelModel.selectedFigure.updateDraw();
		}
		
		
/*		public function setModFunction(pat:PatternModel):void
		{
//			Startow2Figure(this.toolPanelModel.selectedFigure).setPatModel(pat);
			figureENModel.activeFigureEditorModel.setPatModel(pat);
		}*/
		
		/**
		 * change the figure size
		 * 
		 * @param point
		 * @param event
		 */
		override public function mouseMove(point:Point,event:MouseEvent):void{
						
			var x:Number=point.x;
			var y:Number=point.y;
			
			
			
			toolPanelModel.selectedFigure.setposition(ox,oy);
			toolPanelModel.selectedFigure.autosetsize(x,y,0);
			toolPanelModel.selectedFigure.updateDraw();
		}
		
		
	}
}
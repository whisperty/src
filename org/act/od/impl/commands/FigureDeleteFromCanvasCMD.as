package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	
	
	/**
	 * delete figures from canvas and figureEditorModel.
	 *  
	 * @author lizq
	 * 
	 */
	public class FigureDeleteFromCanvasCMD extends AODCommand{
		
		
		public function FigureDeleteFromCanvasCMD(){
			super();
		}
		
		
		/**
		 * 
		 * @param event {fileID}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var delArr :Array = new Array();
			var delArr1 :Array = new Array();
			
			var fileID :String = event.data.fileID;
			
			var feVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(fileID)) as FigureEditorVH;
			
			var feModel :FigureEditorModel = 
					OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().getFigureEditorModel(fileID);
			
			var selectedFigures :Array = feModel.selectedFigures;
			
			var rootFigure :IFigure = feModel.rootFigure;
			var j:int;
			for(var i:int=0; i<selectedFigures.length; i++){
				rootFigure.removechildWithConnection( AbstractFigure(selectedFigures[i]), delArr, delArr1);
				for(j=0;j<delArr.length;j++){
					if(selectedFigures.indexOf(delArr[j])==-1){
						selectedFigures.push(delArr[j]);
					}
				}
				for(j=0;j<delArr1.length;j++){
					if(selectedFigures.indexOf(delArr1[j])==-1){
						selectedFigures.push(delArr1[j]);
					}
				}
				IFigure(selectedFigures[i]).setSelected(false);
				feVH.removeFiguresFromCanvas( AbstractFigure(selectedFigures[i]) );
			}
			new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
		}
	
	}
}
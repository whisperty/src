package org.act.od.impl.commands
{
	import flash.geom.Point;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.SelectionState;

	/**
	 * Change the size of the selected figure.
	 */
	public class ChangeFigureSizeCMD extends AODCommand{


		public function ChangeFigureSizeCMD(){
			super();
		}
		
		/**
		 * 
		 * @param event {resizedFigure, direction, point}
		 * 
		 */
		override public function execute(event : OrDesignerEvent) :void{
			//resize current figure	
			var resizedFigure :IFigure = event.data.resizedFigure as IFigure;
			var direction :int = event.data.direction as int;
			var point :Point = event.data.point as Point;
			
			resizedFigure.autosetsize(point.x,point.y,direction);
			resizedFigure.updateDraw();
			
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
		}
	}
}
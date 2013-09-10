package org.act.od.impl.state{
	
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.figure.IFigure;



	/**
	 * ChangeSizeState
	 */
	public class ChangeSizeState extends AbstractState {
		
		private var objFigure :IFigure;
		private var direction :int;
		
		public function ChangeSizeState(obj :IFigure ,dir :int){
			super();
			this.objFigure=obj;
			this.direction=dir;
		}
				
		override public function mouseUp(point :Point, event :MouseEvent) :void{

			var resizedFigure : IFigure = this.objFigure;
			var direction : int = this.direction;
			var point : Point = point;
			
			new FigureCanvasAppEvent(FigureCanvasAppEvent.CHANGE_FIGURE_SIZE_IN_CANVAS,
				{resizedFigure:resizedFigure, direction:direction, point:point}).dispatch();
		}
		
		override public function mouseMove(point:Point,event:MouseEvent):void{
			objFigure.autosetsize(point.x,point.y,direction);
			objFigure.updateDraw();
			objFigure.hideContextPanel();
		}
		
	}
}
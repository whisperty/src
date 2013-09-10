package org.act.od.impl.state
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;

	public class AbstractState implements IState{
		
		protected var fcStateDomain:FigureCanvasStateDomain;
		
		public function AbstractState(){
			this.fcStateDomain = OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain();
		}
		
		
		public function mouseDoubleClick(point:Point,event:MouseEvent):void{
		}
		
		public function mouseClick(point:Point,event:MouseEvent):void{
		}
		
		public function mouseDown(point:Point,event:MouseEvent):void{
		}
		
		public function mouseUp(point:Point,event:MouseEvent):void{
		}
		
		public function mouseMove(point:Point,event:MouseEvent):void{
		}
		
		public function keyDown(event:KeyboardEvent):void{
		}
		
		public function keyUp(event:KeyboardEvent):void{
		}
		
		public function RollOut(event:MouseEvent):void{
		}
		
		public function RollOver(event:MouseEvent):void{
		}
		
	}
}
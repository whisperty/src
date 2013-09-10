package org.act.od.impl.commands
{
	import mx.containers.Canvas;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;


	/**
	 * 
	 */ 
	public class CanvasChildrenChangedCMD extends AODCommand
	{
		public function CanvasChildrenChangedCMD(){
			super();
		}
		/**
		 * @param event{canvas}
		 */ 
		override public function execute(event:OrDesignerEvent):void{
			var canvas :Canvas = event.data.canvas as Canvas;
		}
		
	}
}
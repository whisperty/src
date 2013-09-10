package org.act.od.impl.commands
{
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	/**
	 * Move figures up.
	 */ 
	public class MoveUpCMD extends AODCommand
	{
		public function MoveUpCMD(){
			super();
		}

		/**
		 * @param event {fileID}
		 */
		override public function execute(event:OrDesignerEvent):void{	
			
			var fileID :String = event.data.fileID;
			
			var feModel :FigureEditorModel = 
					OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().getFigureEditorModel(fileID);
			
			var selectedFigures :Array = feModel.selectedFigures;
			
			var i:int;
			var conn:Array=new Array();
			for(i=0;i<selectedFigures.length;i++){
				IFigure(selectedFigures[i]).setxy(IFigure(selectedFigures[i]).getx(),IFigure(selectedFigures[i]).gety()-5);
				if(selectedFigures[i] is ConnectionFigure){
					conn.push(selectedFigures[i]);
				}
			}
			for(i=0;i<conn.length;i++){
				ConnectionFigure(conn[i]).autoSetAnchor();
			}
			for(i=0;i<selectedFigures.length;i++){
				IFigure(selectedFigures[i]).updateDraw();
			}
			
		}
		
	}
}
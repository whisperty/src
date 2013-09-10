package org.act.od.impl.commands
{
	import org.act.od.framework.commands.SequenceCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.events.FigureEditorNavigatorAppEvent;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	
	/**
	 * To open a figureFile 
	 * @author lizq
	 * 
	 */
	public class FigureFileOpenCMD extends SequenceCommand{
		
		
		public function FigureFileOpenCMD(){
			super();
		}
		

		/**
		 * 
		 * @param event {fileID, filePath, fileName }
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			//1. creat the figureEditorModel, if already exist, return the old one
			var feNavModel :FigureEditorNavigatorModel = 
					OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			
			var feModel :FigureEditorModel = feNavModel.addFigureEditorModel(event.data.fileID);
			
			//2. active the figureEditorpage
			this.nextEvent = new FigureEditorNavigatorAppEvent(FigureEditorNavigatorAppEvent.ACTIVE_FIGUREEDITOR_PAGE,
					{ fileID:event.data.fileID, filePath:event.data.filePath, 
					  fileName:event.data.fileName, figureEditorModel:feModel }
					);
			
			this.executeNextCommand();
			
		}

	}
}
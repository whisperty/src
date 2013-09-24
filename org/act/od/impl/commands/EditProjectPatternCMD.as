package org.act.od.impl.commands
{
	import Pattern.PatternModel;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.FileNavigatorViewAppEvent;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.figure.Startow2Figure;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.model.ToolPanelModel;
	import org.act.od.impl.view.SelectModel;
	
	public class EditProjectPatternCMD extends AODCommand
	{
		public function EditProjectPatternCMD()
		{
			super();
		}
		
		override public function execute(event :OrDesignerEvent) :void{
			var s = event.data.startow2Figure as Startow2Figure;
			var fileName : String = event.data.fileName;
			
			var newFile : SelectModel = SelectModel(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SelectModel,true));
			newFile.width = 350;
			newFile.height = 180;
			newFile.callbackFunction = this.setModFunction;
			PopUpManager.centerPopUp(newFile);
			newFile.setTitle("File");
			var selectedFigures:Array = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel.selectedFigures;
			if(selectedFigures.length > 0)
				selectedFigures[0].hideContextPanel();
			PopUpManager.centerPopUp(newFile);
			//			newFile.addEventListener(CloseEvent.CLOSE,newFileResult);
		}
		public function setModFunction(pat:PatternModel):void
		{
			var toolPanelModel:ToolPanelModel = OrDesignerModelLocator.getInstance().getToolPanelModel();
//			Startow2Figure(toolPanelModel.selectedFigure).setPatModel(pat);
			OrDesignerModelLocator.getInstance().setProjectPattern(pat);
		}
	}
}
package org.act.od.impl.commands
{
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.FileNavigatorViewAppEvent;
	import org.act.od.impl.view.ProjectProperty;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.figure.Projectow2Figure;
	import org.act.od.impl.figure.IFigure;
	
	public class EditProjectParameterCMD extends AODCommand
	{
		public function EditProjectParameterCMD()
		{
			super();
		}
		
		override public function execute(event :OrDesignerEvent) :void{
			var s = event.data.switchow2Figure as Projectow2Figure;
			var fileName : String = event.data.fileName;
			
			var newFile : ProjectProperty = ProjectProperty(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), ProjectProperty,true));
			newFile.setTitle("File");
			IFigure(OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel.selectedFigures[0]).hideContextPanel();
			PopUpManager.centerPopUp(newFile);
//			newFile.addEventListener(CloseEvent.CLOSE,newFileResult);
		}
	}
}
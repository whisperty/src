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
	import org.act.od.impl.figure.Selectow2Figure;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.view.SelectProperty;
	
	public class CreatSelectCMD extends AODCommand
	{
		private var selectow2Figure : Selectow2Figure;
		public function CreatSelectCMD()
		{
			super();
		}
		override public function execute(event :OrDesignerEvent) :void{
			selectow2Figure = event.data.subProcessFigure as Selectow2Figure;
			var contidionSetPanel : SelectProperty = SelectProperty(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SelectProperty,true));
			PopUpManager.centerPopUp(contidionSetPanel);
		}
	}
}
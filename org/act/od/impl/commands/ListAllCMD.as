package org.act.od.impl.commands
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	
	import org.act.od.impl.business.delegates.AccountDelegate;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.ToolPanelAppEvent;
	import org.act.od.impl.figure.FigureFactory;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.model.FigureCanvasStateDomain;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.business.delegates.ListDataDelegate;
	/**
	 * 
	 * 
	 * 
	 * 
	 * 
	 */ 
	public class ListAllCMD extends AODCommand
	{
		public function ListAllCMD(){
			super();
		}
		private var accounts:ArrayCollection = new ArrayCollection();
		
		/**
		 * @param event {startFigure}
		 */
		override public function execute(event:OrDesignerEvent):void{
			
			var delegate:ListDataDelegate = new ListDataDelegate();
			
			delegate.loadPhotos(event.data.fileID);
		}
		
	}
}
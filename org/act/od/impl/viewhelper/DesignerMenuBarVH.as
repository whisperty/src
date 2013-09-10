package org.act.od.impl.viewhelper
{
	import mx.events.CloseEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.view.ViewHelper;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.DesignerMenuBarAppEvent;
	import org.act.od.impl.events.DesignerToolBarAppEvent;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.FigureEditorAppEvent;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.DesignerMenuBar;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.view.SaveFileWindow;

	/**
	 * The ViewHelper of DesignerMenuBar.
	 * Used to isolate command classes from the implementation details of a view.
	 */
	public class DesignerMenuBarVH extends ViewHelper
	{
		/**
		 * The key of DesignerMenuBarVH
		 */
        public static const VH_KEY :String = "DesignerMenuBarVH";    
        private var fileNavigatorModel:FileNavigatorViewModel;
		private var figureEditorNavigatorModel:FigureEditorNavigatorModel;

		/**
		 * Initialize DesignerMenuBar with DesignerMenuBarVH
		 */
		public function DesignerMenuBarVH(document : Object, id : String)
		{
			super();
			initialized(document, id);
			this.fileNavigatorModel=OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();
		}
		/**
		 * Return DesignerMenuBar.
		 */
		private function get designerMenuBar() :DesignerMenuBar{
			return this.view as DesignerMenuBar;
		}
		
		/**
		 * Deal with the MenuClick event.
		 */
		public function menuClick(event:MenuEvent) :void{
			
			switch(int(event.item.@id))
			{
				case 1: //new project
					var newProject:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
					newProject.setTitle("Project");
					PopUpManager.centerPopUp(newProject);
					newProject.addEventListener(CloseEvent.CLOSE, newProjectResult);
					break;
					
				case 2://open/new folder
					var newFolder:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
					newFolder.setTitle("Folder");
					PopUpManager.centerPopUp(newFolder);
					newFolder.addEventListener(CloseEvent.CLOSE, newFolderResult);
					break;
				case 3://quit or new file
					var newFile:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
					newFile.setTitle("File");
					PopUpManager.centerPopUp(newFile);
					newFile.addEventListener(CloseEvent.CLOSE,newFileResult);
					break;
					
				case 4:// Close
//					this.figureEditorNavigatorModel.closeFigureEditor();
					break;
					
				case 5://Close All
//					this.figureEditorNavigatorModel.closeAllFigureEditor();
					break;
					
				case 6://save
					this.onSaveHandle();
					break;
					
				case 7://save all
					this.onSaveAllHandle();
					break;
					
				case 8://Cut
					this.onCutHandle();
					break;
					
				case 9://Copy
					this.onCopyHandle();
					break;
					
				case 10://Paste
					this.onPasteHandle();
					break;
					
				case 11://Select All
					this.onSelectAll();
					break;
					
				case 12://Create BPEL
					this.onBpelHandel();
					break;
					
				case 13://About
					this.onAboutHandle();
					break;
				
				default:
					break;
			}
		}
		private function newProjectResult(event:CloseEvent):void{
			var projectName:String=SaveFileWindow(event.currentTarget).getText();
			if(projectName != "")
				new DesignerMenuBarAppEvent(DesignerMenuBarAppEvent.NEW_PROJECT,
					{projectName:projectName}).dispatch();
		}
		private function newFolderResult(event:CloseEvent):void{
			var folderName:String=SaveFileWindow(event.currentTarget).getText();
			if(folderName != "")
				new DesignerMenuBarAppEvent(DesignerMenuBarAppEvent.NEW_FOLDER,
					{folderName:folderName}).dispatch();
		}
		private function newFileResult(event:CloseEvent):void{
			var fileName:String=SaveFileWindow(event.currentTarget).getText();
			if(fileName != "")
				fileName = fileName + ".xml";
				new DesignerToolBarAppEvent(DesignerToolBarAppEvent.NEW_FILE,
					{fileName:fileName}).dispatch();
		}
		
		private function onSaveHandle():void {
			new DesignerToolBarAppEvent(DesignerToolBarAppEvent.FILE_SAVE,
				{}).dispatch();
		}
		private function onSaveAllHandle():void{
			new DesignerToolBarAppEvent(DesignerToolBarAppEvent.FILE_SAVEALL,
				{}).dispatch();
		}
		private function onCutHandle():void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_COPY,
					{fileID :activeFEModel.fileID} ).dispatch();
				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURE_DELETE_FROM_CANVAS,
					{fileID :activeFEModel.fileID} ).dispatch();
			}
		}
		
		private function onCopyHandle():void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_COPY,
					{fileID :activeFEModel.fileID} ).dispatch();
			}
		}
		
		private function onPasteHandle():void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_PASTE,
					{fileID :activeFEModel.fileID} ).dispatch();
			}
		}
		private function onSelectAll():void{
			
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.Select_All,
					{fileID :activeFEModel.fileID} ).dispatch();
			}
		}
		private function onBpelHandel():void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null && activeFEModel.relativeBpelID != null){
				var figureEditorVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(activeFEModel.fileID)) as FigureEditorVH;
					
				var filePath :String = figureEditorVH.filePath;
				var figureFileName :String = filePath.substring(filePath.lastIndexOf("/", filePath.length) + 1, filePath.length);
				var bpelFileName :String = figureFileName.substring(0, figureFileName.length - 4) + ".bpel";
				
			}else if(activeFEModel != null){
				this.onBpelHandelResult(new CloseEvent(CloseEvent.CLOSE));
			}
		}
		private function onBpelHandelResult(event :CloseEvent) :void{
			var figureEditorNavigatorVH :FigureEditorNavigatorVH = ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
			if(figureEditorNavigatorVH.getCurrentChildType() == null)
				return;
			if(figureEditorNavigatorVH.getCurrentChildType() == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE){
				var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
				var figureEditorVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(activeFEModel.fileID)) as FigureEditorVH;
				new FigureEditorAppEvent(FigureEditorAppEvent.BPEL_CREAT, 
					{figureFilePath :figureEditorVH.filePath }).dispatch();
			}
		}
		private function onAboutHandle():void{
			
			new FigureCanvasAppEvent(FigureCanvasAppEvent.About_Info).dispatch();
		}
	}

}
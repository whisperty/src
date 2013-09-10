package org.act.od.impl.viewhelper
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import flash.utils.setInterval;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.business.BpelCreator;
	import org.act.od.impl.figure.ProcessFigure;
	import org.act.od.impl.model.OrDesignerModelLocator;
	
	import fileoperation.SaveToFile;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;
	
	import org.act.od.framework.view.ViewHelper;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.DesignerToolBarAppEvent;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.FigureEditorAppEvent;
	import org.act.od.impl.events.RunEvent;
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.model.DataSourceViewModel;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.CheckState;
	import org.act.od.impl.view.DesignerToolBar;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.view.SaveFileWindow;
	import org.act.od.impl.business.delegates.AccountDelegate;
	
	/**
	 * The ViewHelper of DesignerToolBar.
	 * Used to isolate command classes from the implementation details of a view.
	 */
	public class DesignerToolBarVH extends ViewHelper
	{
		/**
		 * The key of DesignerToolBarVH
		 */
        public static const VH_KEY :String = "DesignerToolBarVH";
        private var fileNavigatorModel:FileNavigatorViewModel;
		private var dsViewModel:DataSourceViewModel;
		private var arrToSave:ArrayCollection;
		
		//add by lbw
		private var saveFile:SaveToFile;
		[Bindable]
		public var filterOptions:Object = new Object();
		/**
		 * Initialize DesignerToolBar with DesignerToolBarVH
		 */
		public function DesignerToolBarVH(document : Object, id : String){
			super();
			initialized(document, id);	
			this.fileNavigatorModel=OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();
			this.dsViewModel = OrDesignerModelLocator.getInstance().getDataSourceViewModel();
			this.arrToSave = dsViewModel.datasource;
			
			//add by lbw
			this.saveFile = new SaveToFile();
		}
		/**
		 * Return DesignerToolBar.
		 */
		private function get designerToolBar() :DesignerToolBar{
			return this.view as DesignerToolBar;
		}
		/**
		 * The handler of "New Project" button.
		 */
		public function newProjectHandler(event:MouseEvent):void{
			var newProject:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
			newProject.setTitle("Project");
			PopUpManager.centerPopUp(newProject);
			newProject.addEventListener(CloseEvent.CLOSE, newProjectResult);
		}
		private function newProjectResult(event:CloseEvent):void{
			var projectName:String=SaveFileWindow(event.currentTarget).getText();
			if(projectName != "")
				new DesignerToolBarAppEvent(DesignerToolBarAppEvent.NEW_PROJECT,
					{projectName:projectName}).dispatch();
		}
		/**
		 * The handler of New Folder button.
		 */
		public function newFolderHandler(event:MouseEvent):void{
			var newFolder:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
			newFolder.setTitle("Folder");
			PopUpManager.centerPopUp(newFolder);
			newFolder.addEventListener(CloseEvent.CLOSE, newFolderResult);
		}
		private function newFolderResult(event:CloseEvent):void{
			var folderName:String=SaveFileWindow(event.currentTarget).getText();
			if(folderName != "")
				new DesignerToolBarAppEvent(DesignerToolBarAppEvent.NEW_FOLDER,
					{folderName:folderName}).dispatch();
		}
		/**
		 * The handler of "New File" button.
		 */
		public function newFileHandler(event:MouseEvent):void{
			var newFile:SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), SaveFileWindow,true));
			newFile.setTitle("File");
			PopUpManager.centerPopUp(newFile);
			newFile.addEventListener(CloseEvent.CLOSE,newFileResult);
		}
		private function newFileResult(event:CloseEvent):void{
			var fileName:String=SaveFileWindow(event.currentTarget).getText();
			if(fileName != ""){
				fileName = fileName + ".xml";
				new DesignerToolBarAppEvent(DesignerToolBarAppEvent.NEW_FILE,
					{fileName:fileName}).dispatch();
			}
		}
		/**
		 * The handler of "Save" button.
		 */
		public static function ArrayToString(arr:ArrayCollection):String{
			var rootname:String = "list";
			var xmlstr:String = "<"+rootname+">";
			xmlstr+="\n";
			for each(var item:* in arr.source){
				xmlstr+=objToString(item);
			}
			xmlstr+="</"+rootname+">";
			return xmlstr;
		}
		
		public static function objToString(obj:Object):String{
			var str:String = "\t";
			var classInfo:Object = ObjectUtil.getClassInfo(obj);
			var properties:Array = classInfo["properties"] as Array;
			str+="<item>"+"\n";
			for each(var q:QName in properties){
				var value:String = obj[q.localName] as String;
				str+="\t"+"\t";
				str+="<"+q+">"+value+"</"+q+">";
				str+="\n";
			}
			str+="\t"+"</item>";
			str+="\n";
			return str;
		}
		public function onSaveHandler(event :MouseEvent):void {
			//new DesignerToolBarAppEvent(DesignerToolBarAppEvent.FILE_SAVE,
				//{}).dispatch();
			this.dsViewModel = OrDesignerModelLocator.getInstance().getDataSourceViewModel();
			//var arr2:ArrayCollection = OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.
			this.arrToSave = dsViewModel.datasource;
			//Alert.show(arrToSave.toString());
			var stringToSave:String = ArrayToString(arrToSave)
			saveFile.saveData(stringToSave);
		}
		/**
		 * The handler of "Save All" button.
		 */
		public function onSaveAllHandler(event :MouseEvent):void{
			new DesignerToolBarAppEvent(DesignerToolBarAppEvent.FILE_SAVEALL,
				{}).dispatch();
		}
		/**
		 * The handler of "Cut" button.
		 */
		public function onCutHandler(event:MouseEvent):void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_COPY,
					{fileID :activeFEModel.fileID} ).dispatch();
				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURE_DELETE_FROM_CANVAS,
					{fileID :activeFEModel.fileID} ).dispatch();
				new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
			}
		}
		/**
		 * The handler of "Copy" button.
		 */
		public function onCopyHandler(event:MouseEvent):void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_COPY,
					{fileID :activeFEModel.fileID} ).dispatch();
			}
		}
		/**
		 * The handler of "Paste" button.
		 */
		public function onPasteHandler(event:MouseEvent):void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.FIGURES_PASTE,
					{fileID :activeFEModel.fileID} ).dispatch();
			
				new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
			}
		}
		/**
		 * The handler of "Zoom In" button.
		 */
		public function onZoomInHandler(event:MouseEvent):void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.Zoom_In,
					{fileID :activeFEModel.fileID} ).dispatch();
				new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
			}
		}
		/**
		 * The handler of "Zoom Out" button.
		 */
		public function onZoomOutHandler(event:MouseEvent):void{
			var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
			if(activeFEModel != null){

				new FigureCanvasAppEvent(FigureCanvasAppEvent.Zoom_Out,
					{fileID :activeFEModel.fileID} ).dispatch();
				new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
			}
		}
		/**
		 * The handler of "Create BPEL" button.
		 */
		public function onBpelHandler(event:MouseEvent):void{
			/*var figureEditorNavigatorVH :FigureEditorNavigatorVH = ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
			if(figureEditorNavigatorVH.getCurrentChildType() == null)
				return;
			if(figureEditorNavigatorVH.getCurrentChildType() == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE){
				var activeFEModel :FigureEditorModel =  OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel().activeFigureEditorModel;
				var figureEditorVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(activeFEModel.fileID)) as FigureEditorVH;
				new FigureEditorAppEvent(FigureEditorAppEvent.BPEL_CREAT, 
					{figureFilePath :figureEditorVH.filePath }).dispatch();
			}*/
			
			//change absolute filepath to relative ones ***Edited by ty 20130705
			var feModel:FigureEditorModel = OrDesignerModelLocator.getInstance().figureEditorNavigatorModel.activeFigureEditorModel;
			var inputFileID:String ="F:\\Stream\\"+feModel.datasrcName; 
			var outputFileID:String  = "F:\\Stream\\"+feModel.resultFileName;
			//Alert.show("F:\\Stream\\"+OrDesignerModelLocator.getInstance().resultFileName);
			//var outputFileID:String ="F:\\Stream\\c.TXT";
			filterOptions.property = "state";
			filterOptions.operater = "!=";
			filterOptions.value = "0";
			
//			processNetwork(AbstractFigure(feModel.rootFigure));
			
			var delegate:AccountDelegate = new AccountDelegate();
			
			//begin of lyy
			var _network:RemoteObject;
			_network = (ServiceLocator.getInstance().getRemoteObject("network"));
			
			var bpelCreator :BpelCreator = new BpelCreator();
			var newBPELText :String;
			var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			newBPELText = bpelCreator.outputInfo(ProcessFigure(orDesModelLoc.getFigureEditorNavigatorModel().activeFigureEditorModel.rootFigure) );
			
			_network.init(newBPELText);
			//Alert.show(newBPELText);
			//end of lyy
			
			delegate.loadPhotos(inputFileID, outputFileID, filterOptions);
			OrDesignerModelLocator.getInstance().popProgressBar();
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new CheckState());
		}
		
		public function processNetwork(_root:AbstractFigure):void
		{
			
		}
	}
}
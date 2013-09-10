package org.act.od.impl.viewhelper{
	
	
	import flash.events.Event;
	
	import flexlib.events.SuperTabEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.act.od.framework.view.ViewHelper;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.FigureEditorNavigatorAppEvent;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.view.FigureEditorNavigator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;

	/**
	 * The ViewHelper of FigureEditorNavigator.
	 * Used to isolate command classes from the implementation details of a view.
	 */
	public class FigureEditorNavigatorVH extends ViewHelper {
		
		/**
		 * The source for "title" image data binding.
		 */
		[Bindable] 
		[Embed(source="../assets/icon/container/title.gif")]
        public var title :Class;
        
		/**
		 * The source for "bpelTitle" image data binding.
		 */
     
		/**
		 * The key of FigureEditorNavigatorVH
		 */
        public static const VH_KEY :String = "FigureEditorNavigatorVH";
		
		// model attribute
       	private var figureEditorNavigatorModel :FigureEditorNavigatorModel;
		
		/**
		 * Initialize FigureEditorNavigator with FigureEditorNavigatorVH
		 */
		public function FigureEditorNavigatorVH(document :Object, id :String){
			super();
			this.initialized(document, id);
			this.figureEditorNavigatorModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
		}

		/**
		 * return FigureEditorNavigator
		 */
		private function get figureEditorNavigator() :FigureEditorNavigator{
			return this.view as FigureEditorNavigator;
		}
		
		/**
		 * Return active editor's type.
		 * This method return "Figure_Editor_Type" or "Bpel_Editor_Type".
		 */
		public function getCurrentChildType() :String{
			var curChild :FigureEditorNavigatorChild = this.figureEditorNavigator.selectedChild as FigureEditorNavigatorChild;
			if(curChild != null)
				return curChild.type;
			else
				return null;
		}

		public function cancelClosedFigureEditor(figureEditor : FigureEditor) : void {
			FigureEditorNavigator(this.view).addChild(figureEditor);
			FigureEditorNavigator(this.view).enabled = Boolean (FigureEditorNavigator(this.view).numChildren - 1);
		}
		
		
		public function getSelectedChildOfNavigator() :FigureEditorNavigatorChild{
			return this.figureEditorNavigator.selectedChild as FigureEditorNavigatorChild;
		}
		
		/**
		 * Handle of TabIndexChange event 
		 * @param event
		 * 
		 */
		public function onTabIndexChangeHandle(event :Event) :void {
				
			var viewLoc :ViewLocator = ViewLocator.getInstance();
			
			var curChild :FigureEditorNavigatorChild = this.figureEditorNavigator.selectedChild as FigureEditorNavigatorChild;
			
			if(curChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE) {
				
				figureEditorNavigatorModel.activeFigureEditorModel = FigureEditor(curChild).figureEditorModel;
				
				if( !viewLoc.registrationExistsFor(FigureEditorVH.getViewHelperKey(curChild.fileID)) ){
					throw new Error("no binding  with existed figure editor model");
				}
				
			}
			if(curChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
				FigureEditor(curChild).figureCanvas.notifyMicroimageUpdate();
		}
		
		
		/**
		 * Handle of TabClose Event
		 * @param event
		 * 
		 */
		public function onTabCloseHandle(event :SuperTabEvent):void {
			
			var curChild :FigureEditorNavigatorChild = 
					this.figureEditorNavigator.getChildAt(event.tabIndex) as FigureEditorNavigatorChild;
					
			if(curChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE) {
				var closedFE : FigureEditor = curChild as FigureEditor;
				var closedFEModel : FigureEditorModel = closedFE.figureEditorModel;
				closedFEModel.updateCanvasXML();
				//added by zjn 09.7.28
				if(closedFEModel.isChanged()) {
					new FigureEditorNavigatorAppEvent(FigureEditorNavigatorAppEvent.FIGURE_EDITOR_CLOSE, 
						{closedFE:closedFE} ).dispatch();
				}
				
				FigureEditor(this.figureEditorNavigator.selectedChild).figureCanvas.notifyMicroimageUpdate();
				
			}
			if(curChild.type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
				FigureEditor(curChild).figureCanvas.notifyMicroimageUpdate();
			var num :int = 0;
			for(var i :int = 0; i < this.figureEditorNavigator.numChildren; i++){
				if(FigureEditorNavigatorChild (this.figureEditorNavigator.getChildAt(i)).type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
					num++;
			}
			
		}
		/**
		 * Create a new FigureEditor.
		 * @param feModel
		 * @param filePath
		 * @param fileName
		 * @return 
		 * 
		 */
		public function createNewFigureEditor(feModel :FigureEditorModel, filePath :String, fileName :String) :FigureEditor{
			var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			var cos:ArrayCollection = orDesModelLoc.cos;
			var figureEditor :FigureEditor = new FigureEditor(filePath, fileName, feModel, cos);
			figureEditor.icon = title;
			this.figureEditorNavigator.removeAllChildren();
		
			this.figureEditorNavigator.removeAllChildren();
			this.figureEditorNavigator.addChild(figureEditor);
			
			return figureEditor;
		}
		
		/**
		 * Create a new BPELEditor.
		 * @param beModel
		 * @param filePath
		 * @param fileName
		 * @return 
		 * 
		 */
	
		
		
		/**
		 * Change the figureEditorNavigator.selectedIndex by the given fileID
		 * if the Tab of the given fileID not exist, then do nothing
		 * 
		 * @param feNavChild
		 */
		public function SwithToGivenFileID(fileID :String) :void{
			
			var index :int;
			
			for(index=0; index<this.figureEditorNavigator.numChildren; index++) {
				
				var curChildren :FigureEditorNavigatorChild = 
						FigureEditorNavigatorChild(this.figureEditorNavigator.getChildAt(index));
				
				if(curChildren.fileID == fileID){
					this.figureEditorNavigator.selectedIndex = index;
					break;
				}
			}
		}
		/**
		 * Close one Tab in the figureEditorNavigator by the given fileID
		 * if the Tab of the given fielID not exist, then do nothing.
		 * 
		 * @param feNavChild
		 */
		public function CloseTabelByGivenFileID(fileID :String):void{
			var curChildren :FigureEditorNavigatorChild;
			for (var index :int = 0; index < this.figureEditorNavigator.numChildren; index++){
				curChildren = FigureEditorNavigatorChild(this.figureEditorNavigator.getChildAt(index));
				
				if(curChildren.fileID == fileID){
					this.figureEditorNavigator.removeChildAt(index);
				}
			}
		}
	}
}
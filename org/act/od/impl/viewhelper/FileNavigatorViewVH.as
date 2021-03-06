package org.act.od.impl.viewhelper
{
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.view.ViewHelper;
	import org.act.od.impl.events.FileNavigatorViewAppEvent;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.DeleteConfirmWindow;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.view.FileNavigatorView;
	import org.act.od.impl.view.SaveFileWindow;

	/**
	 * The ViewHelper of FileNavigatorView.
	 * Used to isolate command classes from the implementation details of a view.
	 */
	public class FileNavigatorViewVH extends ViewHelper
	{
		/**
		 * The key of FileNavigatorViewVH
		 */
		public static const VH_KEY :String = "FileNavigatorViewVH";
		private var figureEditorNavigatorModel:FigureEditorNavigatorModel;
		
		/**
		 * Initialize AttributeView with FileNavigatorViewVH
		 */
		public function FileNavigatorViewVH(document : Object, id : String){
			super();
			initialized(document, id);
			this.figureEditorNavigatorModel=OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
		}
		/**
		 * Return VH_KEY
		 */
		public static function getViewHelperKey() :String{
			return VH_KEY;
		}
		/**
		 * Return FileNavigatorView
		 */
		private function get fileNavigatorView() :FileNavigatorView{
			return this.view as FileNavigatorView;
		}
		/**
		 * Return the selectedItem in the tree control
		 */
		public function getSelectedItem():Object{
			return this.fileNavigatorView.selectedItem;
		}
		/**
		 * Rename the selectedItem in the tree control
		 */
		public function reName(newName :String):void{
			this.fileNavigatorView.selectedItem.@name = newName;
		}
		/**
		 * Return the path of selectedItem in the tree control
		 */
		public function getSelectedItemPath():String{
			var theParentItem:Object;
			var str:String;
			var path:String;
			if(this.fileNavigatorView.selectedItem != null)
				path = this.fileNavigatorView.selectedItem.@name;
				
			else
				return "";
			theParentItem=this.fileNavigatorView.selectedItem;
			while(theParentItem != null){
				theParentItem=this.fileNavigatorView.getParentItem(theParentItem);
				if(theParentItem!=null){
                	str=theParentItem.@name+"/"+path;
                	path=str;
                }
			}
			return path;
		}
		/**
		 * Retrun the dataDescriptor of the tree control
		 */
		public function getDataDescriptor():ITreeDataDescriptor{
			return this.fileNavigatorView.dataDescriptor;
		}
		/**
		 * Append a node in the parent item and expand the parent item.
		 */ 
        public function addAndExpandItem(parent:Object, newChild:Object, index:int, open:Boolean):void{
        	this.fileNavigatorView.dataDescriptor.addChildAt(parent, newChild, index);
        	this.fileNavigatorView.expandItem(parent, open);
        }
        /**
         * Return the selectedItem's patent item. 
         */
        public function getParentItem(item :Object):*{
        	return this.fileNavigatorView.getParentItem(item);
        }
        /**
         * Handler of doubleClick event in a item of the tree control
         */
		public function tree_itemDoubleClick(event :MouseEvent):void {
			
			var node:XML = this.fileNavigatorView.selectedItem as XML;
            var isOpen:Boolean = this.fileNavigatorView.isItemOpen(node);
   			if(node != null){
   				if(node.@type == "project" || node.@type == "folder")
   					this.fileNavigatorView.expandItem(node, !isOpen);
   				else
   					this.fileOpen();
   			}
        }
        /**
         * Remove a item in the parent item
         */
		public function itemDelete(event :KeyboardEvent):void{
			if(event.keyCode == 46 && this.fileNavigatorView.selectedItem != null){
				var deleteConfirmWindow :DeleteConfirmWindow= DeleteConfirmWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(), DeleteConfirmWindow,true));
				deleteConfirmWindow.fileName=this.fileNavigatorView.selectedItem.@name;
				PopUpManager.centerPopUp(deleteConfirmWindow);
				deleteConfirmWindow.addEventListener(CloseEvent.CLOSE, itemDeleteHandler);
			}
        }
        private function itemDeleteHandler(event :CloseEvent):void{
        	if(this.getSelectedItem().@type == "project" || this.getSelectedItem().@type == "folder"){
        		new FileNavigatorViewAppEvent(FileNavigatorViewAppEvent.FOLDER_DELETE, {}).dispatch();
        	}
        	else{
        		new FileNavigatorViewAppEvent(FileNavigatorViewAppEvent.FILE_DELETE,
        			{fileID :this.getSelectedItem().@ID, type :this.getSelectedItem().@type}).dispatch();
        	}
        }
		private function fileOpen():void{
			var fileIDT :String = this.fileNavigatorView.selectedItem.@ID;
			var filePathT: String = this.getSelectedItemPath();
			var fileNameT: String = this.fileNavigatorView.selectedItem.@name;
			var BPELFileName :String = fileNameT.substring(0, fileNameT.length-4) + ".xml";
			var relativeFigureFileIDT :String;
			
			var theParentItem :XML = this.fileNavigatorView.getParentItem(this.view.selectedItem);
			
			var temp:XMLList = theParentItem.elements();
			for(var i :int  = 0; i < temp.length(); i++)
				if( XML(temp[i]).@name == BPELFileName)
					break;
			relativeFigureFileIDT = XML(temp[i]).@ID;
			
			if(this.fileNavigatorView.selectedItem.@type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
				
				new FileNavigatorViewAppEvent(FileNavigatorViewAppEvent.FIGUREFILE_OPEN,
					{fileID :fileIDT, filePath :filePathT, fileName :fileNameT}).dispatch();
		
		}
		/**
		 * Handler of fileRename event.
		 */
		public function fileRename(event :ContextMenuEvent):void{
			var reName :SaveFileWindow = SaveFileWindow(PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),SaveFileWindow,true));
			reName.setRenameTitle("Rename");
			var fileName :String = this.getSelectedItem().@name;
			var i :int = fileName.indexOf(".", 0);
			if(fileName.indexOf(".", 0) != -1)
				reName.setText(fileName.substring(0, fileName.indexOf(".", 0)));
			else 
				reName.setText(fileName);
			PopUpManager.centerPopUp(reName);
			reName.addEventListener(CloseEvent.CLOSE, reNameResult);
		}
		private function reNameResult(event :CloseEvent):void{
			var newName:String=SaveFileWindow(event.currentTarget).getText();
			if(newName != ""){
				if(this.getSelectedItem().@type == FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
					newName = newName + ".xml";
		
				new FileNavigatorViewAppEvent(FileNavigatorViewAppEvent.FILE_RENAME,
					{fileName :newName}).dispatch();
			}
		}
	}
}
package org.act.od.impl.commands
{
	import mx.collections.ICollectionView;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.FileNavigatorViewAppEvent;
	import org.act.od.impl.model.FileNavigatorViewModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureEditorNavigatorChild;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	import org.act.od.impl.viewhelper.FileNavigatorViewVH;
	/**
	 * Delete the selected folder.
	 */ 
	public class FolderDeleteCMD extends AODCommand
	{
		private var fileNavigatorViewVH :FileNavigatorViewVH = 
				ViewLocator.getInstance().getViewHelper(FileNavigatorViewVH.VH_KEY) as FileNavigatorViewVH;
		public function FolderDeleteCMD(){
			super();
		}
		/**
		 * 
		 * @param event 
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
		

			var figureEditorNavigatorVH :FigureEditorNavigatorVH =
					ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
					
			var theParentItem:Object;
			
			theParentItem=fileNavigatorViewVH.getParentItem(fileNavigatorViewVH.getSelectedItem());
			
			this.Traversing(fileNavigatorViewVH.getSelectedItem());
			
			if(theParentItem != null){
				fileNavigatorViewVH.getDataDescriptor().removeChildAt(theParentItem, fileNavigatorViewVH.getSelectedItem(), 0);
			}
			else{
				var fileNavigatorViewModel :FileNavigatorViewModel = OrDesignerModelLocator.getInstance().getFileNavigatorViewModel();
				fileNavigatorViewModel.xmlListCollection.removeItemAt(fileNavigatorViewModel.xmlListCollection.getItemIndex(fileNavigatorViewVH.getSelectedItem()));	
			}
			
		}
		private function Traversing(theParentItem:Object):void{
			if(fileNavigatorViewVH.getDataDescriptor().isBranch(theParentItem)){
				var children :ICollectionView = fileNavigatorViewVH.getDataDescriptor().getChildren(theParentItem);
				var i:int;
				for(i = 0; i < children.length; i++){
					Traversing(children[i]);
				}
			
		
			}
		}
	}
}
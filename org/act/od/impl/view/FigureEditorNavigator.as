package org.act.od.impl.view
{
	import flexlib.containers.SuperTabNavigator;
	import flexlib.events.SuperTabEvent;
	
	import mx.events.IndexChangedEvent;
	
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;


	/**
	 * The parent panel of FigureEditor and BPELEditor.
	 */
	public class FigureEditorNavigator extends SuperTabNavigator {
        
  		//viewHelper
        private var figureEditorNavigatorVH :FigureEditorNavigatorVH;
        
        /**
         * Initialize FigureEditorNavigator
         */
		public function FigureEditorNavigator(){
			super();

			//view init
			this.setStyle("borderStyle","solid");
			this.dragEnabled = false;//disable drag function
			this.allowTabSqueezing = false;
			this.percentHeight=100;
			this.percentWidth=100;
	
			//viewHelper init
			figureEditorNavigatorVH = new FigureEditorNavigatorVH(this, FigureEditorNavigatorVH.VH_KEY);
			
			this.initEventListener();
		}
		
		
		private function initEventListener() :void{
			
			this.addEventListener(SuperTabEvent.TAB_CLOSE, figureEditorNavigatorVH.onTabCloseHandle);
			
			this.addEventListener(IndexChangedEvent.CHANGE, figureEditorNavigatorVH.onTabIndexChangeHandle);
			
		}

	}
}
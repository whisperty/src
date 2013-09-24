package org.act.od.impl.view{
	
	import mx.collections.ArrayCollection;
	import mx.containers.HDividedBox;
	import mx.containers.Panel;
	import mx.containers.VDividedBox;
	import mx.controls.Alert;
	import mx.effects.WipeRight;
	import mx.events.FlexEvent;
	import mx.managers.ToolTipManager;
	
	import org.act.od.impl.control.OrDesignerController;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.*;
	
	/**
	 * Initialize all views and OrDesignerController.
	 */
	public class OrchestraDesigner extends Panel{
		
		/** controller，must init here  */
		private var odController :OrDesignerController = new OrDesignerController();
		
		/** Menu Bar */	
		private var designerMenuBar :DesignerMenuBar;
		
		/** Tool Bar*/
		public var designerToolBar :DesignerToolBar;
		
		/** Attribute Navigator*/	
		public var figureAttributeNav :FigureAttributeNavigator;
		/** Figure Editor Navigator*/	
		private var figureEditorNavigator:FigureEditorNavigator;
	
		/** File Navigator */	
		private var fileNavigator : FileNavigator;
		[Bindable]
		public var pms:ArrayCollection;
		[Bindable]
		public var cos:ArrayCollection;
		
		/**	Microimage */

		
		/**
		 * Initialize OrchestraDesigner.
		 */
		public function OrchestraDesigner(){
			super();
			this.percentWidth=100;
			this.percentHeight=100;
			this.init();
		}
		
		/**
		 * Initialize all views.
		 */
		private function init():void{
			
			//initilize main menu
		
			designerToolBar = new DesignerToolBar();
			this.addChild(designerToolBar);
			
			
			//initilize figure editor area
			figureEditorNavigator = new FigureEditorNavigator();
			
			//initilize attribute area
			figureAttributeNav = new FigureAttributeNavigator();
			
			//comment by ty
			//fileNavigator = new FileNavigator();
			
			

			
			
			//layout arrangement
			var midHDBox :Panel = new Panel();
			midHDBox.addChild(figureEditorNavigator);
			midHDBox.setStyle("borderStyle","solid");
			midHDBox.setStyle("headerHeight","0");
			midHDBox.setStyle("borderThicknessTop","2");
			midHDBox.setStyle("borderThicknessLeft","2");
			midHDBox.setStyle("borderThicknessRight","2");
			midHDBox.setStyle("backgroundAlpha","0.5");
			
			midHDBox.percentHeight=70;
			midHDBox.percentWidth=100;
			
			
			//layout arrangement
			var midVDBox :VDividedBox = new VDividedBox();
			
			var bottomMdBox :Panel = new Panel();
			bottomMdBox.percentHeight = 30;
			bottomMdBox.percentWidth = 100;
			bottomMdBox.setStyle("borderStyle","solid");
			bottomMdBox.setStyle("headerHeight","0");
			bottomMdBox.setStyle("borderThicknessTop","2");
			bottomMdBox.setStyle("borderThicknessLeft","2");
			bottomMdBox.setStyle("borderThicknessRight","2");
			bottomMdBox.setStyle("backgroundAlpha","0.5");
			bottomMdBox.addChild(figureAttributeNav);
			
			midVDBox.addChild(midHDBox);
			midVDBox.addChild(bottomMdBox);
			midVDBox.percentHeight=100;
			midVDBox.percentWidth=85;
			
			
			//layout arrangement
			var bottomHDBox :HDividedBox = new HDividedBox();
			
			
			//comment by ty
			/*
			var leftBmBox :Panel = new Panel();
			leftBmBox.percentHeight = 100;
			leftBmBox.percentWidth = 15;
			leftBmBox.setStyle("borderStyle","solid");
			leftBmBox.setStyle("headerHeight","0");
			leftBmBox.setStyle("borderThicknessTop","2");
			leftBmBox.setStyle("borderThicknessLeft","2");
			leftBmBox.setStyle("borderThicknessRight","2");
			leftBmBox.setStyle("backgroundAlpha","0.5");
			leftBmBox.addChild(fileNavigator);*/
			
			
			
			var rightVDBox :VDividedBox = new VDividedBox();
			rightVDBox.percentWidth=15;
			rightVDBox.percentHeight=100;
			

			var rightBmBox :Panel = new Panel();
			rightBmBox.percentHeight = 100;
			rightBmBox.percentWidth = 100;
			rightBmBox.setStyle("borderStyle","solid");
			rightBmBox.setStyle("headerHeight","0");
			rightBmBox.setStyle("borderThicknessTop","2");
			rightBmBox.setStyle("borderThicknessLeft","2");
			rightBmBox.setStyle("borderThicknessRight","2");
			rightBmBox.setStyle("backgroundAlpha","0.5");

			rightVDBox.addChild(rightBmBox);
			
			bottomHDBox.addChild(midVDBox);
			bottomHDBox.percentHeight=95;
			bottomHDBox.percentWidth=100;

			
			this.addChild(bottomHDBox);
			this.setStyle("headerHeight","20");
			this.setStyle("borderThicknessTop","2");
			this.setStyle("borderThicknessLeft","2");
			this.setStyle("borderThicknessRight","2");
			this.setStyle("backgroundAlpha","0.7");
			
			this.initToolTip();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, editorCreationComplete);
			
		}
		
		private function initToolTip() :void{
			var wiperight:WipeRight=new WipeRight();
			wiperight.duration=600;
			wiperight.repeatCount=1;
			ToolTipManager.showEffect=wiperight;
		}
		
		private function editorCreationComplete(event :FlexEvent):void{
			//To be considered
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
//			mx.controls.Alert.show("selection state");
			OrDesignerModelLocator.getInstance().setOrchestraDesigner(this);
			OrDesignerModelLocator.getInstance().pms = this.pms;
			OrDesignerModelLocator.getInstance().cos = this.cos;
		}
		public function editorChange2RunningState():void{
			OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new RunningState());
			OrDesignerModelLocator.getInstance().getFigureAttributeNavigator().changeFAState();
		}
	}
}
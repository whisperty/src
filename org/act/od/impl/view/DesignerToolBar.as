package org.act.od.impl.view
{
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	
	import mx.collections.ArrayCollection;
	import mx.containers.ControlBar;
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.LinkButton;
	import mx.controls.VRule;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	
	import org.act.od.impl.model.*;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.other.Localizator;
	import org.act.od.impl.view.ToggleLinkButtonSkin;
	import org.act.od.impl.viewhelper.DesignerToolBarVH;
	
	/**
	 * Tool Bar for OrDesigner.
	 */
	public class DesignerToolBar extends ControlBar
	{
		/**
		 * The source for "newproject" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/toolbar/newproject.gif")]
        public var newproject :Class;
	
		/**
		 * The source for "newfolder" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/toolbar/newfolder.gif")]
        public var newfolder :Class;
		
		/**
		 * The source for "newfile" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/toolbar/newfile.gif")]
        public var newfile :Class;

		/**
		 * The source for "save" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/save.gif")]
        public var save :Class;

		/**
		 * The source for "saveall" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/saveall.gif")]
        public var saveall :Class;

		/**
		 * The source for "zoomin" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/zoomin.gif")]
        public var zoomin :Class;

		/**
		 * The source for "zoomout" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/zoomout.gif")]
        public var zoomout :Class;
        
		/**
		 * The source for "bpel" image data binding.
		 */
     
		/**
		 * The source for "cut" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/cut.gif")]
        public var cut :Class;

		/**
		 * The source for "copy" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/copy.gif")]
        public var copy :Class;

		/**
		 * The source for "paste" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/toolbar/paste.gif")]
        public var paste :Class;
		
		[Bindable]
		[Embed(source="../assets/icon/toolbar/bpel.gif")]
		public var bpel :Class;
		[Bindable]
		[Embed(source="../assets/icon/toolbar/pause.gif")]
		public var pause :Class;
		
		private var newProjectButton :LinkButton = new LinkButton();
		private var newFolderButton :LinkButton = new LinkButton();
		private var newFileButton :LinkButton = new LinkButton();
		private var saveButton :LinkButton = new LinkButton();
		private var saveAllButton :LinkButton = new LinkButton();
		private var zoomInButton :LinkButton = new LinkButton();
		private var zoomOutButton :LinkButton = new LinkButton();
		private var bpelButton:LinkButton = new LinkButton();
		private var cutButton :LinkButton = new LinkButton();
		private var copyButton :LinkButton = new LinkButton();
		private var pasteButton :LinkButton = new LinkButton();
		
		private var pauseButton :LinkButton = new LinkButton();
		
		private var designerToolBarVH:DesignerToolBarVH;
		private var localizator : Localizator;
		
		/**
		 * Initialize DesignerToolBar.
		 */
		public function DesignerToolBar() {
			super();
			this.designerToolBarVH = new DesignerToolBarVH(this, "DesignerToolBarVH");
			this.localizator = Localizator.getInstance();
			this.percentHeight = 2;
			this.percentWidth = 100;
			
		
			//comment by ty
			/*
			newFileButton.setStyle("icon",newfile);
			newFileButton.percentHeight = 100;
			newFileButton.width = 20;
			newFileButton.toolTip = localizator.getText('toolbar.newfile');
			
			
			
			saveAllButton.setStyle("icon",saveall);
			saveAllButton.percentHeight = 100;
			saveAllButton.width = 20;
			saveAllButton.toolTip = localizator.getText('toolbar.saveall');
			
			zoomInButton.setStyle("icon",zoomin);
			zoomInButton.height = 20;
			zoomInButton.width = 20;
			zoomInButton.percentHeight = 100;
			zoomInButton.width = 20;
			zoomInButton.toolTip = localizator.getText('toolbar.zoomin');
			
			zoomOutButton.setStyle("icon",zoomout);
			zoomOutButton.height = 20;
			zoomOutButton.width = 20;
			zoomOutButton.percentHeight = 100;
			zoomOutButton.width = 20;
			zoomOutButton.toolTip = localizator.getText('toolbar.zoomout');*/
			
			saveButton.setStyle("icon",save);
			saveButton.percentHeight = 100;
			saveButton.width = 20;
			bpelButton.height = 20;
			saveButton.toolTip = localizator.getText('toolbar.save');
			saveButton.enabled = false;
			
			bpelButton.setStyle("icon",bpel);

			bpelButton.height = 20;
			bpelButton.width = 20;
			bpelButton.percentHeight = 100;
			bpelButton.width = 20;
			bpelButton.toggle = true;
			bpelButton.toolTip = localizator.getText('toolbar.createbpel');
			bpelButton.setStyle("skin", ToggleLinkButtonSkin);
			bpelButton.enabled = false;
			//cutButton.setStyle("icon",cut);
			
			pauseButton.setStyle("icon",pause);
			pauseButton.height = 20;
			pauseButton.width = 20;
			pauseButton.percentHeight = 100;
			pauseButton.width = 20;
			pauseButton.toggle = true;
			pauseButton.setStyle("skin", ToggleLinkButtonSkin);
			pauseButton.toolTip = localizator.getText('toolbar.pause');
			pauseButton.enabled = false;
			/*
			cutButton.height = 20;
			cutButton.width = 20;
			cutButton.percentHeight = 100;
			cutButton.width = 20;
			cutButton.toolTip = localizator.getText('toolbar.cut');
			
			copyButton.setStyle("icon",copy);
			copyButton.height = 20;
			copyButton.width = 20;
			copyButton.percentHeight = 100;
			copyButton.width = 20;
			copyButton.toolTip = localizator.getText('toolbar.copy');
			
			pasteButton.setStyle("icon",paste);
			pasteButton.height = 20;
			pasteButton.width = 20;
			pasteButton.percentHeight = 100;
			pasteButton.width = 20;
			pasteButton.toolTip = localizator.getText('toolbar.paste');*/
			
			var saveBox :HBox = new HBox();
			saveBox.percentHeight = 100;
			saveBox.width = 25;
			saveBox.addChild(saveButton);
			
		
			//layout
			/*
			var newBox :HBox = new HBox();
			newBox.percentHeight = 100;
			newBox.width = 30;
			newBox.addChild(newFileButton);
			
			
			
			var zoomBox :HBox = new HBox();
			zoomBox.percentHeight = 100;
			zoomBox.width = 50;
			zoomBox.addChild(zoomInButton);
			zoomBox.addChild(zoomOutButton);
			
			var editBox :HBox = new HBox();
			editBox.percentHeight = 100;
			editBox.width = 80;
			editBox.addChild(cutButton);
			editBox.addChild(copyButton);
			editBox.addChild(pasteButton);*/
			
			var runBox :HBox = new HBox();
			runBox.percentHeight = 100;
			runBox.width = 80;
			runBox.addChild(bpelButton);
			runBox.addChild(pauseButton);
			
			var vrule2 :VRule = new VRule();
			vrule2.percentHeight = 100;
			/*
			var vrule1 :VRule = new VRule();
			vrule1.percentHeight = 100;
			
			
			
			var vrule3 :VRule = new VRule();
			vrule3.percentHeight = 100;
			
			var vrule4:VRule = new VRule();
			vrule4.percentHeight = 100;*/
			
			this.setStyle("borderStyle", "solid");
			
			
		/*
			
			this.addChild(editBox);
			this.addChild(vrule3);
			this.addChild(zoomBox);
			this.addChild(vrule4);
			this.addChild(runBox);*/
			//add by ty
			this.addChild(runBox);
			this.addChild(vrule2);
			this.addChild(saveBox);
			bpelButton.enabled = false;
			pauseButton.enabled = false;
			this.initEventListener();
		}
		/**
		 * Initialize the listeners of all button.
		 */
		private function initEventListener():void{
/*			this.newProjectButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.newProjectHandler);
			this.newFolderButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.newFolderHandler);
			this.newFileButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.newFileHandler);
			
			this.saveButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onSaveHandler);
			this.saveAllButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onSaveAllHandler);
			
			this.copyButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onCopyHandler);
			this.pasteButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onPasteHandler);
			this.cutButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onCutHandler);
			
			this.zoomInButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onZoomInHandler);
			this.zoomOutButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onZoomOutHandler);*/

			this.bpelButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.onBpelHandler);
			this.saveButton.addEventListener(MouseEvent.CLICK, designerToolBarVH.saveResult);
			//Alert.show("run run");
		}
		public function runState():void{
			bpelButton.enabled = true;
			pauseButton.enabled = true;
		}
		public function setSaveButton():void{
			bpelButton.enabled = false;
			pauseButton.enabled = false;
			saveButton.enabled = true;
		}
	}
}
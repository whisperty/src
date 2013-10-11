package org.act.od.impl.view{
	
	import Pattern.OperatorClass;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.containers.Accordion;
	import mx.containers.Box;
	import mx.containers.VBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.LinkButton;
	import mx.events.ListEvent;
	
	import org.act.od.impl.events.ToolPanelAppEvent;
	import org.act.od.impl.figure.FigureFactory;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.other.Localizator;
	import org.act.od.impl.state.SelectionState;
	
	/**
	 * Tool Panel
	 * @author Zjn
	 */
	public class ToolPanel extends Box{
		
		// can not use ToolPanelViewHelper for ToolPanel, by lizq
		
		//view initilization
		/**
		 * The source for "palette" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/container/palette.gif")]
        public var palette :Class;
		
		/**
		 * The source for "folder" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/accordion/folder.gif")]
        public var folder :Class;
		
		private var accordion :Accordion = new Accordion();
		
		private var othersBox :VBox;
		
		private var othersToolTile: ToolTile = new ToolTile();
		
		private var basicBox :VBox;
		
		private var userBox:VBox;
		
		private var basicToolTile :ToolTile = new ToolTile();
		
		private var userToolTile:ToolTile = new ToolTile();
		
		private var othersXMLList :XMLList = new XMLList();
		
		private var basicXMLList :XMLList = new XMLList();
		
		private var userXMLList:XMLList = new XMLList();
		
		private var localizator :Localizator;
		
		private var f:FileReference;
		public static var tt:int = 0;
		
		private static var tools :XML =
			<tools>
				<others name="" id="0"/>
				<others name="" id="1"/>
				<others name="" id="2"/>
				<basic name="" id="3"/>
				<basic name="" id="4"/>
				<basic name="" id="5"/>
			</tools>;	  
						  
		private var isSelected:Boolean=false;
		
		[Bindable]
		public var cos:ArrayCollection;
		
		public function ToolPanel(cos:ArrayCollection){
			super();
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.cos = cos;
			this.localizator = Localizator.getInstance();
			this.label = localizator.getText('toolpanel.label');
			this.icon = palette;
			initXMLList();
			this.initAccordion();
			this.addChild(accordion);
		}
		private function initAccordion() :void{
			
			accordion.percentHeight = 100;
			accordion.percentWidth = 100;
			accordion.buttonMode = true;
			initOthersBox();
			initBasicBox();
			initUserBox();
			accordion.addChild(othersBox);
			accordion.addChild(basicBox);
			accordion.addChild(userBox);
			this.setHeader();
			accordion.addEventListener(MouseEvent.CLICK, selectedChanged);
		}
		
		private function selectedChanged(event:MouseEvent):void{
			if(tt == 1)
			{
				this.userBox.addChild(userToolTile);
				tt++;
			}
		}
		private function initXMLList() :void{
			
			for each(var item : XML in tools.descendants()) {
				var labelText : String = null;
				if(item.@id == "0") {
					labelText = localizator.getText('toolpanel.others.start');
					item.@name = labelText;
				}
				else if(item.@id == "1") {
					labelText = localizator.getText('toolpanel.others.end');
					item.@name = labelText;
				}
				else if(item.@id == "2") {
					labelText = localizator.getText('toolpanel.others.link');
					item.@name = labelText;
				}
				else if(item.@id == "3") {
//					labelText = localizator.getText('toolpanel.basic.activity');//join
					item.@name = "Combine";
				}
				else if(item.@id == "4") {
					labelText = localizator.getText('toolpanel.basic.switch');//project
					item.@name = labelText;
				}
				else if(item.@id == "5") {
					labelText = localizator.getText('toolpanel.basic.subprocess');//select
					item.@name = labelText;
				}
/*				else if(item.@id == "6") {
					labelText = localizator.getText('toolpanel.basic.union');
					item.@name = labelText;
				}
				else if(item.@id == "7") {
					labelText = localizator.getText('toolpanel.basic.restrict');
					item.@name = labelText;
				}*/
			}
			
			
			this.othersXMLList = tools.descendants("others");
			this.basicXMLList = tools.descendants("basic");
			//this.userXMLList = tools.descendants("user");
			//edited by ty
			//Alert.show(String(cos.length));
			var usertools:XML = new XML(<tools></tools>);
			for(var i:int = 0; i<cos.length; i++)
			{
				var op:OperatorClass = OperatorClass(cos[i]);
				var temp:XML = new XML("<user></user>");
				temp.@id = op.figureID;
				temp.@name = op.name;
				//Alert.show(op.name);
				usertools.appendChild(temp);
				//FigureFactory.setdic(temp.@name, temp.@id);
			}
			//Alert.show(usertools);
			this.userXMLList = usertools.descendants("user");
		}
		private function initOthersBox():void{
			
			othersBox = new VBox();
			othersBox.label = localizator.getText('toolpanel.others');
			othersBox.percentHeight = 100;
			othersBox.percentWidth = 100;
			othersToolTile.setXMLData(othersXMLList);
			othersBox.addChild(othersToolTile);
			othersToolTile.initArray();
			othersToolTile.addEventListener(ListEvent.ITEM_CLICK, this.itemClickHandle);
			othersBox.addEventListener(MouseEvent.CLICK,othersboxClickHandle);

		}
		private function initBasicBox() :void{
			basicBox = new VBox();
			basicBox.label = localizator.getText('toolpanel.basic');
			basicBox.percentHeight = 100;
			basicBox.percentWidth = 100;
			basicToolTile.setXMLData(basicXMLList);
			basicBox.addChild(basicToolTile);
			basicToolTile.initArray();
			basicToolTile.addEventListener(ListEvent.ITEM_CLICK, this.itemClickHandle);
			basicBox.addEventListener(MouseEvent.CLICK,basicboxClickHandle);
		}
		private function initUserBox() :void{
			userBox = new VBox();
			userBox.label = "UserDefinedOperator";
			userBox.percentHeight = 100;
			userBox.percentWidth = 100;
			userToolTile.setXMLData(userXMLList);
			userBox.addChild(userToolTile);
			userToolTile.initArray();
			userToolTile.addEventListener(ListEvent.ITEM_CLICK, this.userItemClickHandle);
			userBox.addEventListener(MouseEvent.CLICK,userboxClickHandle);
			//userBox.addEventListener("customOperatorUpdate", this.addCustomOp);
		}
		private function UpdateCustomOp():void
		{
			//Alert.show(String(cos.length));
			//var cosTemp:ArrayCollection = event.cos;
			var usertools:XML = new XML(<tools></tools>);
			for(var i:int = 0; i<cos.length; i++)
			{
				var op:OperatorClass = OperatorClass(cos[i]);
				var temp:XML = new XML("<user></user>");
				temp.@id = op.figureID;
				temp.@name = op.name;
				//Alert.show(op.name);
				usertools.appendChild(temp);
				//FigureFactory.setdic(temp.@name, temp.@id);
			}
			this.userXMLList = usertools.descendants("user");
			userBox.removeAllChildren();
			userToolTile.resetContent();
			userToolTile.setXMLData(userXMLList);
			userToolTile.initArray();
			userBox.addChild(userToolTile);
			
		}
		private function setHeader() :void{
			
			var idx :uint; 
            var len :uint = accordion.numChildren; 
            var btn:Button; 
            for (idx=0; idx<len; idx++) { 
                btn = accordion.getHeaderAt(idx); 
                btn.useHandCursor = true; 
                btn.buttonMode = true; 
                btn.setStyle("icon", folder); 
            } 

		}
		
		private function itemExisted(name:String):Boolean
		{
			for(var i:int = 0; i<cos.length; i++)
			{
				var op:OperatorClass = OperatorClass(cos[i]);
				if(op.name == name)
					return true;
			}
			return false;
		}
		private function itemClickHandle(event : ListEvent) :void {
			
			isSelected=true;
			var selectedFigureName : String = (event.itemRenderer.data as LinkButton).label;
			var selectedFigId : int = FigureFactory.nametoid(selectedFigureName);
			
			new ToolPanelAppEvent( ToolPanelAppEvent.SELECT_FIGURE,
				{selectedFigureId :selectedFigId} ).dispatch();
	
		}
		private function userItemClickHandle( event: ListEvent): void
		{
			isSelected=true;
			UpdateCustomOp();
			var selectedFigureName : String = (event.itemRenderer.data as LinkButton).label;
			if(!itemExisted(selectedFigureName))
				return;
			var selectedFigId : int = FigureFactory.nametoid(selectedFigureName);
			
			new ToolPanelAppEvent( ToolPanelAppEvent.SELECT_FIGURE,
				{selectedFigureId :selectedFigId} ).dispatch();
		}
		
		private function othersboxClickHandle(event:MouseEvent):void{
			if(!isSelected){
				this.resetAllSelections();
			}
			else{
				isSelected=false;
			}
		}
		private function basicboxClickHandle(event:MouseEvent):void{
			if(!isSelected){
				this.resetAllSelections();
			}
			else{
				isSelected=false;
			}
		}
		private function userboxClickHandle(event:MouseEvent):void{
			if(!isSelected){
				this.resetAllSelections();
			}
			else{
				isSelected=false;
				//Alert.show("ToolPanel"+String(cos.length));
			}
		}
		/**
		 * Reset the toolPanel.
		 */
		public function resetAllSelections():void{
			this.othersToolTile.selectedIndex=-1;
			this.basicToolTile.selectedIndex=-1;
			this.userToolTile.selectedIndex=-1;
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
		}
		
		public function removeAllUserOperator():void{
			this.userBox.removeChild(userToolTile);
		}
	}
}
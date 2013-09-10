package org.act.od.impl.figure
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.controls.Alert;
	
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.LabelNodeEvent;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.NodeContextPanel;
	import org.act.od.impl.vo.BasicAttribute;
	
	public class GraphicalFigure extends AbstractFigure
	{
//		[Bindable]
//		public var nodeName:String = "No Name";
		
		protected var startConnection:Array;
		protected var endConnection:Array;
		
		protected var nodeContextPanel:NodeContextPanel;
		protected var isShowContextPanel:Boolean=false;
		protected var lblNodeName:Label;
		
		
		public function GraphicalFigure()
		{
			super();
			startConnection=new Array();
			endConnection=new Array();
			nodeContextPanel=new NodeContextPanel();
			nodeContextPanel.init();
			this.lblNodeName=new Label();
			
			
			BindingUtils.bindProperty(this.lblNodeName, "text", this, "figureName");
			BindingUtils.bindProperty(this.nodeContextPanel,"nodeName",this,"figureName");
			
			
			this.lblNodeName.setStyle("verticalCenter", 0);
			this.lblNodeName.selectable = false;
			this.lblNodeName.setStyle("textAlign","center"); 
			this.lblNodeName.setStyle("fontWeight","bold");
			this.addEventListener("removeNode", handleRemoveNode);
			this.addEventListener("createLink",handleCreateLink);
			this.addEventListener(LabelNodeEvent.LABEL_NODE, handleLabelNode);
			
		}
		
		
		
		override public function setIsShowContextPanel(isShowContextPanel:Boolean):void{
			this.isShowContextPanel=isShowContextPanel;
		}
		
		override public function getIsShowContextPanel():Boolean{
			return this.isShowContextPanel;
		}
		
		public function handleLabelNode(event : LabelNodeEvent):void{
			this.figureName=event.value;
			this.updateDraw();
			this.setFigureSizeAccordingTolblNodeName();
			this.updateDraw();
//			this.updateDraw();
			this.hideContextPanel();
			new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
		}
		
		protected function removeNodeContextPanel():void {
			this.nodeContextPanel.currentState = null;
			if(this.contains(this.nodeContextPanel)){
				this.removeChild(this.nodeContextPanel);
			}
		}
		
		override public function showContextPanel():void{
			if(!this.contains(this.nodeContextPanel)) {
				this.nodeContextPanel.resize.end();
				this.nodeContextPanel.y =((this.height / 2) - (this.nodeContextPanel.height / 2));
				this.nodeContextPanel.x =(this.width - 10);
				this.addChild(this.nodeContextPanel);
			}
		}
		
		override public function hideContextPanel():void{
			if(this.contains(this.nodeContextPanel)){
				this.removeChild(this.nodeContextPanel);
			}
			this.nodeContextPanel.resetAll();
		}
		
		public function handleRemoveNode(event:Event):void{
			var headarr:Array=new Array();
			var tailarr:Array=new Array();
			if(this.contains(this.nodeContextPanel)){
				this.removeChild(this.nodeContextPanel);
			}
			if(this.getrootfigure()){
				this.getrootfigure().removechildWithConnection(this,headarr,tailarr);
			}
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		public function handleCreateLink(event:Event):void{
			var feNavModel:FigureEditorNavigatorModel=OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			if(feNavModel.activeFigureEditorModel==null){
				throw new Error("no ActiveFigureEditorModel!");
			}
			this.hideContextPanel();
			new FigureCanvasAppEvent(FigureCanvasAppEvent.Node_Create_Link,
				{fileID :feNavModel.activeFigureEditorModel.fileID ,startFigure :this} ).dispatch();
		}
		
		public function getStartConnection():Array{
			return startConnection;
		}
		
		public function getEndConnection():Array{
			return endConnection;
		}
		
		public function getEdgePoint(end:Point):Point{
			return new Point(this.getrx(),this.getry());
		}
	
		public function updateConnection():void{
			var i:int;
			var temp_CF:ConnectionFigure;
			for(i=0;i<startConnection.length;i++){
				temp_CF=ConnectionFigure(this.startConnection[i]);
				temp_CF.autoSetAnchor();
			}
			for(i=0;i<endConnection.length;i++){
				temp_CF=ConnectionFigure(this.endConnection[i]);
				temp_CF.autoSetAnchor();
			}			
		}
		
		override public function setposition(x:Number, y:Number):void{
			updateConnection();
		}
		
		override public function autosetsize(arrowX:Number, arrowY:Number, mode:Number):void{
			updateConnection();
		}
		
		override public function updateDraw():void{
			var i:int;
			for(i=0;i<startConnection.length;i++){
				ConnectionFigure(this.startConnection[i]).autoSetAnchor();
				ConnectionFigure(this.startConnection[i]).updateDraw();
			}
			for(i=0;i<endConnection.length;i++){
				ConnectionFigure(this.endConnection[i]).autoSetAnchor();
				ConnectionFigure(this.endConnection[i]).updateDraw();
			}
			super.updateDraw();
			if(!this.contains(this.lblNodeName)){
				this.addChild(this.lblNodeName);
			}
			this.lblNodeName.validateNow();
			/*if(this is Startow2Figure)
			{
				var patName:String = BasicAttribute(this.attribute).patName;
				Alert.show(patName);
				OrDesignerModelLocator.getInstance().setSelectedPatFromName(patName);
			}*/
			if(this.lblNodeName.textWidth.toString()!="NaN"){
				lblNodeName.width=this.lblNodeName.textWidth+5;
				lblNodeName.height=this.lblNodeName.textHeight+3;
				this.setlblNodeNamePosition();
				if(doChangeSize()){
					this.setFigureSizeAccordingTolblNodeName();
				}
				if(this.lblNodeName.textWidth){
					autoSetStandardWidth();
				}
				if(this.lblNodeName.textHeight){
					autoSetStandardHeight();
				}
			}
			if(this.isShowContextPanel){
				this.showContextPanel();
			}
			else{
				this.hideContextPanel();
			}
		}
		
		
		protected function setlblNodeNamePosition():void{
			lblNodeName.x=this.width/2-this.lblNodeName.width/2;
			lblNodeName.y=this.height+4;
		}
		protected function doChangeSize():Boolean{
			return false;
		}
		public function setFigureSizeAccordingTolblNodeName():void{
			
		}
		protected function autoSetStandardWidth():void{
			
		}
		protected function autoSetStandardHeight():void{
			
		}

		protected function pointLine(x1:Number,y1:Number,x2:Number,y2:Number,px:Number,py:Number):Boolean{
			if(py<(y2-y1)/(x2-x1)*(px-x1)+y1){
				return true;
			}
			else{
				return false;
			}
		}
		
		override public function getContextPanel():Canvas{
			return this.nodeContextPanel;
		}
		
		override public function isin(currentX:Number, currentY:Number):int{
			if(this.contains(this.nodeContextPanel)){
				if(currentX>=this.x+this.nodeContextPanel.x&&currentX<=this.x+this.nodeContextPanel.x+this.nodeContextPanel.width&&currentY>=this.y+this.nodeContextPanel.y&&currentY<=this.y+this.nodeContextPanel.y+this.nodeContextPanel.height){
					return 2;
				}
			}
			return super.isin(currentX,currentY);
		}
		override public function drawclear():void{
			super.drawclear();
		}
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			//modified by zjn
			info.@figureName=this.figureName;

			return info;
		}
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			//modified by zjn
			this.figureName=String(info.@figureName);
		}
		
		override protected function OutputScale(mtp:Number):void{
			super.OutputScale(mtp);
			if(this.lblNodeName)
				this.lblNodeName.setStyle("fontSize",this.fontsize);
		}
	}
}
package org.act.od.impl.view{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.Tree;
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.effects.Fade;
	import mx.effects.IEffectInstance;
	import mx.effects.Iris;
	import mx.effects.Parallel;
	import mx.effects.Rotate;
	import mx.effects.WipeDown;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDirection;
	import mx.managers.DragManager;
	
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.events.AttributeViewAppEvent;
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	import org.act.od.impl.state.CreatingState;
	import org.act.od.impl.state.SelectionState;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	
	/**
	 * Canvas edit area
	 * 
	 */
	public class FigureCanvas extends Canvas{
		
		private static var grapWidth: Number = 25;
		
		private var _width :Number;
		
		private var _height :Number;
		
		//FigureEditorModel
		private var _editorModel :FigureEditorModel;
		
		private var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
		
		public var curState:String;
		
		/**
		 * Create a new canvas by the figureEditorModel.
		 */
		public function FigureCanvas(figureEditorModel :FigureEditorModel){
			super();

			this.styleName="GraphicalViewerStyle";
			this.percentWidth = 100;
			this.percentHeight = 100;
			this._editorModel = figureEditorModel;
			this.curState="Edit";
			this.doubleClickEnabled = true;
			//this.createStart(_editorModel);
			this.initEventListener();
		}
		
		
		private function initEventListener() :void{
			
			//draw vertical or hierachical lines on the canvas
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onInitializeHandle);
			
			this.addEventListener(ResizeEvent.RESIZE, repaintCanvasHandle);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandle);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandle);
			
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandle);
			
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandle);
			
			this.addEventListener(MouseEvent.CLICK, mouseClickHandle);
			
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandle);
			
			this.addEventListener(MouseEvent.ROLL_OUT, mouseRollOutHandle);
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseRollOverHandle); 
			
			this.addEventListener(FlexEvent.SHOW, showEffectHandle);
			
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandle);
			
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandle);
			
			this.addEventListener(DragEvent.DRAG_OVER, dragOverHandle);
			
			this.addEventListener(ResizeEvent.RESIZE,resizeHandle);
			
			this.addEventListener(FlexEvent.SHOW,showHandle);
			
			this.addEventListener(ScrollEvent.SCROLL,scrollHandle);
			
		}
		
		/**
		 * Update the Microimage show.
		 */
		/*public function createStart(figureEditorModel: FigureEditorModel):void{
			var selectedFigureId : int = 100;
			var selectedFigure : IFigure = FigureFactory.createFigure(selectedFigureId);
			selectedFigure.setposition(100,100);
			selectedFigure.updateDraw();
			this.addChild(AbstractFigure(selectedFigure));
			
			//orDesModelLoc.getFigureCanvasStateDomain().setFCActiveState(new SelectionState());
		}*/
		public function notifyMicroimageUpdate():void{
			
			new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :this}).dispatch();
			
		}
				
		/**
		 * Set the figureEditorModel
		 */
		public function setFigureEditorModel(feModel :FigureEditorModel) :void {
			this._editorModel = feModel;
		}
		/**
		 * Change the width of the canvas.
		 */
		public function changeWidth(newWidth :Number) :void {
			this.width = newWidth;
		}
		
		private function doubleClickHandle(event : MouseEvent) : void {
			this.setFocus();
			var ox :Number = FigureCanvas(event.currentTarget).mouseX;
			var oy :Number = FigureCanvas(event.currentTarget).mouseY;
			var point :Point = new Point(ox+this.horizontalScrollPosition,oy+this.verticalScrollPosition);
			
			var tempFigure :IFigure = this._editorModel.rootFigure.getupperfigure(point.x,point.y);
			if(tempFigure is SubProcessow2Figure) {
				var figureEditorVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(this._editorModel.fileID)) as FigureEditorVH;
				SubProcessow2Figure(tempFigure).filePath = figureEditorVH.filePath;
				new FigureCanvasAppEvent(FigureCanvasAppEvent.CREATE_NEW_SUBPROCESS, 
					{subProcessFigure:tempFigure}).dispatch();
			}
			if(tempFigure is Switchow2Figure){
				new FigureCanvasAppEvent(FigureCanvasAppEvent.EDIT_PROJECT_PARAMETER, {switchow2Figure:tempFigure}).dispatch();
			
			}else if(tempFigure is Startow2Figure){
				new FigureCanvasAppEvent(FigureCanvasAppEvent.EDIT_PROJECT_PATTERN, {startow2Figure:tempFigure}).dispatch();
			}

		}
		//added by zjn
		private function dragOverHandle(event :DragEvent):void{
			if(event.dragInitiator is Tree)
				DragManager.showFeedback(DragManager.COPY);
		}
		//added by zjn
		private function dragEnterHandle(event:DragEvent):void {
			var ds :DragSource = event.dragSource;
			if(ds.hasFormat("items"))
				DragManager.acceptDragDrop((event.target as IUIComponent));
			else if(ds.hasFormat("treeItems")) {
				DragManager.acceptDragDrop((event.target as IUIComponent));
			}
		}
		
		//added by zjn
		private function dragDropHandle(event:DragEvent):void 
		{
			
			if(event.dragSource.hasFormat("items")) {
				//add invoke figure
				var items:Array = event.dragSource.dataForFormat("items") as Array;
				
				for each(var xml:XML in items) {
					var serviceName:XMLList = xml.ServiceName;
					var serviceLoc:XMLList = xml.ServiceLocation;
					var new_atts:ArrayCollection = new ArrayCollection();
					new_atts.addItem({name: "Name: ", value: serviceName.text()});
					
					var drawId:int = FigureFactory.nametoid("Invoke");
					//modified by zjn
			
				}
			}
			else if(event.dragSource.hasFormat("treeItems")) {
				var treeItems : Array = event.dragSource.dataForFormat("treeItems") as Array;
				for each(var treeXml : XML in treeItems) {
					if(treeXml.@type != FigureEditorNavigatorChild.FIGURE_EDITOR_TYPE)
						return;
					var idXML : XMLList = treeXml.@ID;
					var fileNameXNL : XMLList = treeXml.@name;
					var fileId : String = idXML.toString();
					var fileName : String = fileNameXNL.toString();
					
					var sbDrawId : int = FigureFactory.nametoid("DataSource");
					var subProcessFigure : SubProcessow2Figure = SubProcessow2Figure(FigureFactory.createFigure(sbDrawId));
					//modified by zjn
					subProcessFigure.setID(this._editorModel.idManager.getAvailabelId());
					subProcessFigure.setMultiple(this._editorModel._showingMultiple);
					subProcessFigure.setxy(event.localX,event.localY);
					subProcessFigure.setSubProcessFileName(fileName);
					subProcessFigure.setSubProcessFileID(fileId);
					
					this.addChild(subProcessFigure);
					this._editorModel.rootFigure.addchild(subProcessFigure);
					subProcessFigure.updateDraw();
				}
			}
			
			this.notifyMicroimageUpdate();
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function UpdateFigureHandle(event:Event):void{
			this.updateFigure();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function onInitializeHandle(event :Event): void{
			renderCanvas();
			
			this.notifyMicroimageUpdate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function repaintCanvasHandle(event :ResizeEvent) :void {
			renderCanvas();
		}
		

		/**
		 * Delegate 
		 * @param event
		 * 
		 */
		private function mouseMoveHandle(event:MouseEvent):void{
			var ox :Number = FigureCanvas(event.currentTarget).mouseX;
			var oy :Number = FigureCanvas(event.currentTarget).mouseY;
			var point :Point = new Point( ox+this.horizontalScrollPosition, oy+this.verticalScrollPosition );
			orDesModelLoc.getFigureCanvasStateDomain().mouseMove(point,event);
			
//			this.notifyMicroimageUpdate();
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function mouseDownHandle(event:MouseEvent):void{
			
			
			this.setFocus();
			
			if(this.verticalScrollBar){
				if(Canvas(event.currentTarget).mouseX>=this.verticalScrollBar.x
				&&Canvas(event.currentTarget).mouseX<=this.verticalScrollBar.x+this.verticalScrollBar.width
				&&Canvas(event.currentTarget).mouseY>=this.verticalScrollBar.y
				&&Canvas(event.currentTarget).mouseY<=this.verticalScrollBar.y+this.verticalScrollBar.height){
					return;
				}
			}
			if(this.horizontalScrollBar){
				if(Canvas(event.currentTarget).mouseX>=this.horizontalScrollBar.x
				&&Canvas(event.currentTarget).mouseX<=this.horizontalScrollBar.x+this.horizontalScrollBar.width
				&&Canvas(event.currentTarget).mouseY>=this.horizontalScrollBar.y
				&&Canvas(event.currentTarget).mouseY<=this.horizontalScrollBar.y+this.horizontalScrollBar.height){
					return;
				}
			}
			
			
			var ox :Number = FigureCanvas(event.currentTarget).mouseX;
			var oy :Number = FigureCanvas(event.currentTarget).mouseY;
			var point :Point = new Point(ox+this.horizontalScrollPosition,oy+this.verticalScrollPosition);
			
			//if selected, bubble the current figure's attributes event
			var tempFigure :IFigure = this._editorModel.rootFigure.getupperfigure(point.x,point.y);
			new AttributeViewAppEvent(AttributeViewAppEvent.ATTRIBUTEVIEW_UPDATE, 
					{selectedFigure:tempFigure} ).dispatch();
		
			//Delegate
			orDesModelLoc.getFigureCanvasStateDomain().mouseDown(point, event);
			this.notifyMicroimageUpdate();
		}
		
		
		/**
		 * Delegate
		 * @param event
		 * 
		 */
		private function mouseUpHandle(event:MouseEvent):void{
			var ox :Number = FigureCanvas(event.currentTarget).mouseX;
			var oy :Number = FigureCanvas(event.currentTarget).mouseY;
			var point :Point = new Point(ox+this.horizontalScrollPosition,oy + this.verticalScrollPosition);
			orDesModelLoc.getFigureCanvasStateDomain().mouseUp(point, event);
			
			
			this.notifyMicroimageUpdate();
		}
		
		
		/**
		 * Delegate
		 * @param event
		 * 
		 */
		private function keyDownHandle(event:KeyboardEvent):void{
			orDesModelLoc.getFigureCanvasStateDomain().keyDown(event);
			
			this.notifyMicroimageUpdate();
		}
		
		
		/**
		 * Delegate
		 * @param event
		 * 
		 */
		private function mouseClickHandle(event:MouseEvent):void{
			var ox:Number = FigureCanvas(event.currentTarget).mouseX;
			var oy:Number = FigureCanvas(event.currentTarget).mouseY;
			var point:Point = new Point(ox+this.horizontalScrollPosition,oy+this.verticalScrollPosition);
			orDesModelLoc.getFigureCanvasStateDomain().mouseClick(point, event);
			this.notifyMicroimageUpdate();
		}
		/**
		 * Delegate
		 * @param event
		 * 
		 */
		private function mouseRollOutHandle(event:MouseEvent):void{
			orDesModelLoc.getFigureCanvasStateDomain().RollOut(event);
			
//			this.notifyMicroimageUpdate();
		}
		
		/**
		 * Delegate
		 * @param event
		 * 
		 */
		private function mouseRollOverHandle(event:MouseEvent):void{
			orDesModelLoc.getFigureCanvasStateDomain().RollOver(event);
			
//			this.notifyMicroimageUpdate();
		}
		
		
		private function resizeHandle(event:ResizeEvent):void{
			
			
//			this.notifyMicroimageUpdate();
		}
		
		
		private function showHandle(event:FlexEvent):void{
			
			this.notifyMicroimageUpdate();
		}
		
		private function scrollHandle(event:ScrollEvent):void{
			
			switch(event.direction)
			{
				case ScrollEventDirection.VERTICAL:
				if(this.verticalScrollPosition<=0&&event.delta<0){
					return;
				}
				if(this.verticalScrollPosition>=this.verticalScrollBar.maxScrollPosition&&event.delta>0){
					return;
				}
				break;
				
				case ScrollEventDirection.HORIZONTAL:
				if(this.horizontalScrollPosition<=0&&event.delta<0){
					return;
				}
				if(this.horizontalScrollPosition>=this.horizontalScrollBar.maxScrollPosition&&event.delta>0){
					return;
				}
				break;
				
				default:
				break;
				
			}
			
			this.notifyMicroimageUpdate();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		private function showEffectHandle(event:FlexEvent):void{
			var parallel:Parallel=new Parallel();
			var rotate:Rotate=new Rotate();
			rotate.angleFrom=180;
			rotate.angleTo=360;
			var fade:Fade=new Fade();
			fade.alphaFrom=0.0;
			fade.alphaTo=1.0;
			var iris:Iris=new Iris();
			iris.scaleXFrom=1;
			iris.scaleXTo=0;
			iris.scaleYFrom=1;
			iris.scaleYTo=0;
			var wipedown:WipeDown=new WipeDown();
			parallel.addChild(wipedown);
			parallel.addChild(iris);
			parallel.duration = 1600;
			parallel.repeatCount = 1;
			var instance:IEffectInstance = parallel.createInstance(this);
			instance.startEffect();
		}
		
		
		/**
		 * Update the selected figure by new attribute and redraw it.
		 */
		public function updateFigure() :void {
			
			var tempArr :Array = new Array();
			var linkarr :Array = new Array();
			
			this._editorModel.rootFigure.ifiguretoarray(tempArr);
			this.removeAllChildren();

			var len :int=tempArr.length;
			
			for(var i:int=0; i<len; i++){
				if(tempArr is GraphicalFigure){
					this.addChild(DisplayObject(tempArr));
					IFigure(tempArr[i]).updateDraw();
				}
				else if(tempArr is ConnectionFigure){
					linkarr.push(tempArr[i]);
				}
			}
			
			len = linkarr.length;
			
			for(var j:int=0; j<len; j++){
				this.addChild(DisplayObject(linkarr[j]));
				IFigure(linkarr[j]).updateDraw();
			}
			
		}
		
		/**
		 * paint the gridding line
		 */
		private function renderCanvas() :void {
			this.graphics.clear();
				
			//fill background
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
				
			this.graphics.lineStyle(1, 0xD8D8DB);
			//draw hirerachical line
			var i : int = 0;
			var totalLength: Number = 0;
			while(totalLength <= this.height){
				this.graphics.moveTo(0, grapWidth * i);
				this.graphics.lineTo(this.width, grapWidth * i);
				totalLength = grapWidth * i;
				i ++;
			}
				
			//reset var
			totalLength = 0;
			var j :int = 0;
				
			//draw vertical lines
			while(totalLength <= this.width){
				this.graphics.moveTo(grapWidth * j, 0);
				this.graphics.lineTo(grapWidth * j, this.height );
				totalLength = grapWidth * j;
				j++;
			}
		}

		
	}
}
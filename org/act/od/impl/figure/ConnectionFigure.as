package org.act.od.impl.figure
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	
	import org.act.od.impl.events.FigureCanvasAppEvent;
	import org.act.od.impl.events.LabelLinkEvent;
	import org.act.od.impl.figure.arrow.ArrowFactory;
	import org.act.od.impl.figure.arrow.IArrow;
	import org.act.od.impl.figure.router.IRouter;
	import org.act.od.impl.figure.router.RouterFactory;
	import org.act.od.impl.view.LinkContextPanel;
	
	[Style(name="templateBottomLineColor", type="uint", format="Color")]
	[Style(name="tempalteLineColor", type="uint", format="Color")]
	[Style(name="bottomLineColor", type="uint", format="Color")]
	[Style(name="lineColor", type="uint", format="Color")]
	[Style(name="lineRecThickness", type="Number")]
	
	public class ConnectionFigure extends AbstractFigure
	{
		
		protected var startFigure:IFigure;
		protected var endFigure:IFigure;
		protected var startFigureId:int;
		protected var endFigureId:int;
		
		protected var tailX:Number;
		protected var tailY:Number;
		protected var headX:Number;
		protected var headY:Number;
		
		protected var router:IRouter;

		protected var arrow:IArrow;
		
		protected var linkContextPanel:LinkContextPanel;
		protected var isShowContextPanel:Boolean=false;
		protected var label:Label;
		
//		[Bindable] public var linkName:String;

		private var templateBottomLineColor:uint = 0x008080;
		private var tempalteLineColor:uint = 0xF0F0FF;
		private var bottomLineColor:uint = 0x2C2C54;
		private var selectionColor:uint = 0x000000;
		private var lineColor:uint = 0x000000;
		private var lineRecThickness:Number = 4;
		
		public function ConnectionFigure()
		{
			super();
			
//			var ir:IRouter=new DefaultRouter();
			var routerFactory:RouterFactory=new RouterFactory();
			var ir:IRouter=routerFactory.CreateRouter(1);
			this.setRouter(ir);
			var arrowFactory:ArrowFactory=new ArrowFactory();
			var ar:IArrow=arrowFactory.CreateArrow(1);
			this.setarrow(ar);
			linkContextPanel=new LinkContextPanel();
			label=new Label();
			this.label.setStyle("fontFamily", this.getStyle("labelFontFamily"));
			this.label.setStyle("fontSize", this.getStyle("labelFontSize"));
			this.label.setStyle("color",0xffffff);
			this.label.setStyle("fontWeight",this.getStyle("labelFontWeight"));

			
			BindingUtils.bindProperty(this.label, "text", this, "figureName");
			BindingUtils.bindProperty(this.linkContextPanel,"linkName",this,"figureName");
			
			this.addEventListener("removeLink",handleRemoveLink);
			this.addEventListener(LabelLinkEvent.LABEL_LINK, handleLabelLink);
//			this.label.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
//			this.label.addEventListener(MouseEvent.CLICK, handleClick);
		}
//		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
//			this.updateDraw();
//		}
//		public function handleClick(event:MouseEvent):void{
//			this.setFocus();
//		}
//		public function handleLabelResize(event:ResizeEvent):void{
//			this.invalidateDisplayList();
//		}
		
		
		//added by ty 20130704
		public function getStartID():int
		{
			return this.startFigureId;
		}
		
		public function getEndID():int
		{
			return this.endFigureId;
		}
		override public function setIsShowContextPanel(isShowContextPanel:Boolean):void{
			this.isShowContextPanel=isShowContextPanel;
		}
		override public function getIsShowContextPanel():Boolean{
			return this.isShowContextPanel;
		}
		public function handleRemoveLink(event:Event):void{
			var headarr:Array=new Array();
			var tailarr:Array=new Array();
			if(this.contains(this.linkContextPanel)){
				this.removeChild(this.linkContextPanel);
			}
			if(this.getrootfigure()){
				this.getrootfigure().removechildWithConnection(this,headarr,tailarr);
			}
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		public function handleLabelLink(event : LabelLinkEvent):void{
			this.figureName=event.value;
			this.updateDraw();
			this.removeLinkContextPanel();
			new FigureCanvasAppEvent(FigureCanvasAppEvent.Canvas_Children_Changed,
					{canvas :null}).dispatch();
		}
		
		protected function removeLinkContextPanel():void {
			this.linkContextPanel.currentState = null;
			if(this.contains(this.linkContextPanel)){
				this.removeChild(this.linkContextPanel);
			}
		}
		
		override public function addchild(child:IFigure):void{

		}
		override public function removechildWithoutConnection(child:IFigure):void{
			
		}
		override public function setposition(x:Number,y:Number):void{
			this.headX=x;
			this.headY=y;
			this.width=this.tailX-this.headX;
			this.height=this.tailY-this.headY;
			if(this.width<0){
				this.x=this.tailX;
				width=-width;
			}
			else{
				this.x=this.headX;
			}
			if(this.height<0){
				this.y=this.tailY;
				height=-height;
			}
			else{
				this.y=this.headY;
			}
			this.rx=x+this.width/2;
			this.ry=y+this.height/2;
		}
		public function setTailposition(x:Number,y:Number):void{
			this.tailX=x;
			this.tailY=y;
			this.width=this.tailX-this.headX;
			this.height=this.tailY-this.headY;
			if(this.width<0){
				this.x=this.tailX;
				this.width=-this.width;
			}
			else{
				this.x=this.headX;
			}
			if(this.height<0){
				this.y=this.tailY;
				this.height=-this.height;
			}
			else{
				this.y=this.headY;
			}
			this.rx=x+this.width/2;
			this.ry=y+this.height/2;
		}
		public function getTailX():Number{
			return this.tailX;
		}
		public function getTailY():Number{
			return this.tailY;
		}

		override public function setsize(width:Number,height:Number):void{
			if(width<0){
				this.x=this.headX+width;
			}
			if(height<0){
				this.y=this.headY+height;
			}
			
			this.width=Math.abs(width);
			this.height=Math.abs(height);
			this.rx=x+this.width/2;
			this.ry=y+this.height/2;
			this.tailX=this.headX+this.width;
			this.tailY=this.headY+this.height;
		}
		override public function autosetsize(arrowX:Number,arrowY:Number,mode:Number):void{
			
		}
		override public function isin(currentX:Number,currentY:Number):int{
			if(this.contains(this.linkContextPanel)){
				if(currentX>=this.linkContextPanel.x+this.x&&currentX<=this.linkContextPanel.x+this.x+this.linkContextPanel.width&&currentY>=this.y+this.linkContextPanel.y&&currentY<=this.y+this.linkContextPanel.y+this.linkContextPanel.height){
					return 2;
				}
			}
			if((currentX-headX)*(currentX-tailX)<=0&&(currentY-headY)*(currentY-tailY)<=0){
				if(this.GetDistancePointToLine(currentX,currentY,this.headX,this.headY,this.tailX,this.tailY)<=2.5){
					return 1;
				}
			}
			if(this.contains(this.label)){
				if(currentX>=this.label.x+this.x&&currentX<=this.label.x+this.x+this.label.width&&currentY>=this.y+this.label.y&&currentY<=this.y+this.label.y+this.label.height){
					return 1;
				}
			}
			return 0;
		}
		
		public function setStartFigure(sf:IFigure):void{
			this.startFigure=sf;
			if(sf != null)
				this.startFigureId = sf.getID();
//			if(sf){
//				this.startFigureId=int(sf.getAttributeValue("id"));
//			}
//			else{
//				this.startFigureId=-1;
//			}
		}
		
		public function setEndFigure(ef:IFigure):void{
			this.endFigure=ef;
			if(ef != null)
				this.endFigureId = ef.getID();
//			if(ef){
//				this.endFigureId=int(ef.getAttributeValue("id"));
//			}
//			else{
//				this.endFigureId=-1;
//			}
		}
		
		public function getStartFigure():IFigure{
			return this.startFigure;
		}
		
		public function getEndFigure():IFigure{
			return this.endFigure;
		}
		
		public function getStartFigureId():int{
			return this.startFigureId;
		}
		
		public function getEndFigureId():int{
			return this.endFigureId;
		}
		
		public function autoSetAnchor():void{
			var point:Point=new Point();
			var point1:Point=new Point();
			if(this.startFigure&&this.endFigure){
				point.x=GraphicalFigure(endFigure).getrx();
				point.y=GraphicalFigure(endFigure).getry();
				point1=GraphicalFigure(startFigure).getEdgePoint(point);
				this.headX=point1.x;
				this.headY=point1.y;
				point.x=GraphicalFigure(startFigure).getrx();
				point.y=GraphicalFigure(startFigure).getry();
				point1=GraphicalFigure(endFigure).getEdgePoint(point);
				this.tailX=point1.x;
				this.tailY=point1.y;
				this.x=this.headX>this.tailX?this.tailX:this.headX;
				this.y=this.headY>this.tailY?this.tailY:this.headY;
				this.width=Math.abs(this.tailX-this.headX);
				this.height=Math.abs(this.tailY-this.headY);
				this.rx=(this.headX+this.tailX)/2;
				this.ry=(this.headY+this.tailY)/2;
			}
			else{
				return;
			}
		}
		
		public function setRouter(router:IRouter):void{
			this.router=router;
		}
		
		override public function drawpicture():void{
			var sp:Point=new Point();
			var ep:Point=new Point();
			sp.x=this.headX,sp.y=this.headY,ep.x=this.tailX,ep.y=this.tailY;
			router.setSourcePoint(sp);
			router.setTargetPoint(ep);
			router.createPath();
		}
		
		public function setarrow(arrow:IArrow):void{
			this.arrow=arrow;
		}
		
//		override public function outputXMLhead():String{//4.8改
//			var str:String;
//			str=this.getStartFigure().getAttributeValue("id");
//			if(str){
//				this.setAttributeValue("sourceRef",str);
//			}
//			else{
//				this.setAttributeValue("sourceRef",'\\'+this.getStartFigure().getRelativePath(this.getrootfigure()));
//			}
//			str=this.getEndFigure().getAttributeValue("id");
//			if(str){
//				this.setAttributeValue("targetRef",str);
//			}
//			else{
//				this.setAttributeValue("targetRef",'\\'+this.getEndFigure().getRelativePath(this.getrootfigure()));
//			}
//			return super.outputXMLhead();
//		}

		override public function drawSelectedStyle():void{
			sprt.graphics.beginFill(0x000000);
			sprt.graphics.lineStyle(1,0x000000,1);
			sprt.graphics.drawCircle(this.headX-this.x,this.headY-this.y,this.selectedCircleRadius);
			sprt.graphics.drawCircle(this.tailX-this.x,this.tailY-this.y,this.selectedCircleRadius);
			sprt.graphics.endFill();
		}
		
		override public function outputAllInformation():XML{
			
			var info:XML=super.outputAllInformation();
			info.@tailX=this.tailX;
			info.@tailY=this.tailY;
			info.@headX=this.headX;
			info.@headY=this.headY;
			info.@startFigureId=this.startFigureId;
			info.@endFigureId=this.endFigureId;
			
			info.@arrowid=this.arrow.getArrowId();
			info.@routerid=this.router.getRouterId();
			
			info.@labelwidth=this.label.width;
			info.@labelheight=this.label.height;
			info.@labelx=this.label.x;
			info.@labely=this.label.y;
			
//			info.@figureName=this.figureName;
			
			var newnode:XML;
			newnode=this.arrow.outputAllInformation();
			info.appendChild(newnode);
			newnode=this.router.outputAllInformation();
			info.appendChild(newnode);
			
			return info;
		}

		override public function readInformationToFigure(info:XML):void{
			
			super.readInformationToFigure(info);
			
			this.tailX=Number(info.@tailX);
			this.tailY=Number(info.@tailY);
			this.headX=Number(info.@headX);
			this.headY=Number(info.@headY);
			this.startFigureId=int(info.@startFigureId);
			this.endFigureId=int(info.@endFigureId);
			
			this.label.x=Number(info.@labelx);
			this.label.y=Number(info.@labely);
			this.label.width=Number(info.@labelwidth);
			this.label.height=Number(info.@labelheight);
			
			
//			this.figureName=info.@figureName;
			
			var arrowfactory:ArrowFactory=new ArrowFactory();
			var iar:IArrow=arrowfactory.CreateArrow(int(info.@arrowid));
			var routerfactory:RouterFactory=new RouterFactory();
			var iro:IRouter=routerfactory.CreateRouter(int(info.@routerid));
			var xml:XML;
			xml=XML(info.elements("arrow"));
			iar.readInformationToFigure(xml);
			xml=XML(info.elements("router"));
			iro.readInformationToFigure(xml);
			this.setarrow(iar);
			this.setRouter(iro);
		}
		
		override public function updateDraw():void{
			super.updateDraw();
			if(this.contains(this.label)){
				this.removeChild(this.label);
			}
			if(this.figureName&&this.figureName!=""){
//				this.label.height=20;
//				this.label.width=this.label.text.length*10+5;
				this.addChild(this.label);
				this.label.validateNow();
				if(this.label.textWidth.toString()!="NaN"){
					this.label.width=this.label.textWidth+5;
					this.label.height=this.label.textHeight+5;
					this.label.x=this.width/2-this.label.width/2;
					this.label.y=this.height/2-this.label.height/2;
				}
				this.drawLinkRectangle(this.label.x - 5, this.label.y -4, this.label.width + 10, this.label.height + 5);
			}
			if(this.isShowContextPanel){
				if(!this.contains(this.linkContextPanel)){
					this.linkContextPanel.x=this.width/2-this.linkContextPanel.width/2;
					this.linkContextPanel.y=this.height/2-this.linkContextPanel.height;
					if(this.contains(this.label)){
						this.linkContextPanel.y-=this.label.height/2+4;
					}
					this.addChildAt(this.linkContextPanel,this.numChildren);
				}
				else{
					this.addChildAt(this.linkContextPanel,this.numChildren-1);
				}
			}
			else{
				if(this.contains(this.linkContextPanel)){
					this.removeChild(this.linkContextPanel);
					this.linkContextPanel.resize.stop();
				}
			}
		}
		
		protected function drawLinkRectangle(x:Number, y:Number, w:Number, h:Number):void {
			//For easy event handling a transparent stronger line
			var ellipseH:Number = h;
			var ellipseW:Number = ellipseH;
			this.graphics.lineStyle(this.lineRecThickness+8, this.linkContextPanel.parent != null ? selectionColor : bottomLineColor, 0.1);
			this.graphics.drawRoundRect(x, y, w, h, ellipseW, ellipseH);
			//
			this.graphics.beginFill(this.linkContextPanel.parent != null ? selectionColor : bottomLineColor, 1);
			this.graphics.lineStyle(this.lineRecThickness+2, this.bottomLineColor, 0.70);
			this.graphics.drawRoundRect(x, y, w, h, ellipseW, ellipseH);
			this.graphics.beginFill(this.lineColor, 0.70);
			this.graphics.lineStyle(this.lineRecThickness, this.lineColor, 0.70);			
			this.graphics.drawRoundRect(x, y, w, h, ellipseW, ellipseH);
		}
		
//		override public function showname():void{
//			
//		}
		override protected function OutputScale(mtp:Number):void{
			super.OutputScale(mtp);
			if(this.arrow){
				this.arrow.setMultiple(this.multiple);
			}
			if(this.label){
				this.label.setStyle("fontSize",this.fontsize);
			}
		}
		
	}
}
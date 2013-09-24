package org.act.od.impl.figure
{
	
	import flash.geom.Point;
	
	import mx.controls.Alert;
	
	public class LinkFigure extends ConnectionFigure
	{
		public function LinkFigure()
		{
			super();
			drawid=3;
			standardwidth=30;
			standardheight=0;
//			symbolwidth=30;
//			symbolheight=0;
			width=standardwidth;
			height=standardheight;
//			if(isSymbol){
//				width=symbolwidth;
//				height=symbolheight;
//			}
//			this.setAttributeValue("","sequenceFlows");
		}
		
		public function isConfig():Boolean
		{
			if(startFigure == null || endFigure == null){
				Alert.show("存在箭头没有起始或者指向算子节点");
				return false;
			}
			if(startFigure is Endow2Figure){
				Alert.show("终止节点不能作为箭头起点");
				return false;
			}
			if(endFigure is Startow2Figure){
				Alert.show("起始节点不能作为箭头指向");
				return false;
			}
			if(this.figureName == ""){
				Alert.show("给定箭头输入顺序！");
			}
			return true;
		}
		
		override public function drawpicture():void
		{
			super.drawpicture();
			var arr:Array=this.router.getPathPoint();
			var poi1:Point=new Point();
			var poi2:Point=new Point();
			var i:int;
			sprt.graphics.lineStyle(this.lineThickness,0x000000,1);
			for(i=1;i<arr.length;i++){
				poi1.x=Point(arr[i-1]).x;
				poi1.y=Point(arr[i-1]).y;
				poi2.x=Point(arr[i]).x;
				poi2.y=Point(arr[i]).y;
				sprt.graphics.moveTo(poi1.x-this.x,poi1.y-this.y);
				sprt.graphics.lineTo(poi2.x-this.x,poi2.y-this.y);
			}
			this.arrow.setLineStartPoint(this.headX-this.x,this.headY-this.y);
			this.arrow.setLineEndPoint(this.tailX-this.x,this.tailY-this.y);
			this.arrow.createVertexs();
			this.arrow.drawArrow(sprt);
			if(this.contains(sprt)){
				this.removeChild(sprt);
			}
			addChildAt(sprt,0);
		}
		
		override public function drawSelectedStyle():void{
			super.drawSelectedStyle();
		}
		
		override public function changedirection(currentX:Number,currentY:Number):int{
			return 0;
		}
		
//		override public function outputAllInformationForDFX(ns:Array):XML{
//			var xml:XML=super.outputAllInformationForDFX(ns);
//			xml.@type=4001;
//			var curxml:XML=XML(xml.elements("element"));
//			curxml.@["xmi:type"]="bpmn:SequenceFlow";
////			curxml.@href=this.getRelativePath(this.getrootfigure());
//			return xml;
//		}
	}
}
package org.act.od.impl.figure
{
	import Pattern.AttributeModel;
	import Pattern.PatternModel;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	import org.act.od.impl.vo.BasicAttribute;
	import org.act.od.impl.vo.StartAttribute;

	public class Startow2Figure extends ow2Figure
	{
		protected var r:Number;
		protected var datasrc:StartAttribute;
		private var links:ArrayCollection;
		private var pm:PatternModel;
		
		//add by ty
		private var streamFile:String;
		public function Startow2Figure()
		{
			super();
			drawid=100;
			standardwidth=20;
			standardheight=20;
			r=standardwidth/2;
			width=standardwidth;
			height=standardheight;
			this.setpicture(FigureFactory.start);
			this.datasrc = new StartAttribute();
			//this.attribute = new BasicAttribute();
			this.links = new ArrayCollection();
		}

		//add by ty: to set data stream source file
		public function setStreamFile(filename: String):void
		{
			this.streamFile = filename;
		}
		public function isFileSet():Boolean
		{
			if(streamFile == null)
				return false;
			return true;
		}
		
		public function setPatternModel(pm:PatternModel):void
		{
			this.pm = pm;
		}
		
		public function isConfig():Boolean
		{
			if(pm == null){
				Alert.show("未设置网络模式");
				return false;
			}
			return isFileSet();
		}
		
		public function addLink(con:ConnectionFigure):void
		{
			this.links.addItem(con);
		}
		public function removeLink(con:ConnectionFigure):void
		{
			var conIndex:int = this.links.getItemIndex(con);
			this.links.removeItemAt(conIndex);
		}
		public function getdatasourceArray():ArrayCollection
		{
			return this.datasrc.getdatasourceArray();
		}
		public function setdatasourceArray(srcName:String,srcContent:ArrayCollection):void
		{
			this.datasrc.updateDatasrc(srcName,srcContent);
			return;
		}
		override public function setposition(x:Number,y:Number):void{
			super.setposition(x,y);
			this.rx=x;
			this.ry=y;
			this.x=rx-r;
			this.y=ry-r;
		}

		override public function setsize(width:Number,height:Number):void{
			r=width/this.width*r;
			this.width=width;
			this.height=this.width;
			this.x=rx-r;
			this.y=ry-r;
		}
		
		override public function autosetsize(arrowX:Number,arrowY:Number,mode:Number):void{
			var tempN:Number;
			tempN=Math.sqrt((arrowX-this.rx)*(arrowX-this.rx)+(arrowY-this.ry)*(arrowY-this.ry));
			if(tempN<this.standardwidth/2){
				this.width=this.standardwidth;
				this.height=this.standardwidth;
				this.r=this.standardwidth/2;
				this.x=rx-r;
				this.y=ry-r;
			}
			else{
				this.r=tempN;
				this.x=rx-r;
				this.y=ry-r;
				this.width=2*r;
				this.height=2*r;
			}
			super.autosetsize(arrowX,arrowY,mode);
		}
		
		override public function isin(currentX:Number,currentY:Number):int{
			var ret:int=super.isin(currentX,currentY);
			if(ret>0){
				return ret;
			}
			if(Math.pow(currentX-rx,2)+Math.pow(currentY-ry,2)<=r*r){
				return 1;
			}
			else{
				if(this.selectedState){
					if(currentX>this.x&&currentX<this.x+this.width&&currentY>this.y&&currentY<this.y+this.height){
						return 1;
					}
				}
			}
			return 0;
		}

		override public function drawSelectedStyle():void{
			sprt.graphics.lineStyle(this.defaultSelectedLineThickness*this.multiple,0x2244ff,0.4);
			sprt.graphics.drawRoundRect(0,0,this.width,this.height,3,3);
			
			sprt.graphics.lineStyle(2,0x000000,1);
			sprt.graphics.drawCircle(0,this.height/2,this.selectedCircleRadius);
			sprt.graphics.drawCircle(this.width/2,0,this.selectedCircleRadius);
			sprt.graphics.drawCircle(this.width/2,this.height,this.selectedCircleRadius);
			sprt.graphics.drawCircle(this.width,this.height/2,this.selectedCircleRadius);
		}
		
		override public function changedirection(currentX:Number,currentY:Number):int{
			if(!this.selectedState){
				return 0;
			}
			if(getDistance(this.x+this.width/2,this.y,currentX,currentY)<=this.selectedCircleRadius){
				return 2;
			}
			if(getDistance(this.x+this.width,this.y+this.height/2,currentX,currentY)<=this.selectedCircleRadius){
				return 4;
			}
			if(getDistance(this.x+this.width/2,this.y+this.height,currentX,currentY)<=this.selectedCircleRadius){
				return 6;
			}
			if(getDistance(this.x,this.y+this.height/2,currentX,currentY)<=this.selectedCircleRadius){
				return 8;
			}
			return 0;
		}
		
		override public function getdrawx():Number{
			return getrx();
		}
		
		override public function getdrawy():Number{
			return getry();
		}
		
		override public function getEdgePoint(end:Point):Point{
			return this.circlepoint(this.rx,this.ry,end.x,end.y,this.r);
		}
		
		override public function setxy(x:Number,y:Number):void{
			this.setposition(x+this.r,y+this.r);
		}
		
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@r=this.r;
			info.@srcFilename = streamFile;
			var pmXML:XML = new XML("<patterns></patterns>");
			
			for each(var item:AttributeModel in pm.attributes.items){
				var att:XML = new XML("<attribute></attribute>");
				att.@name =item.name;
				att.@type = item.type;
				att.@description = item.descri;
			}
			return info;
		}		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			this.r=Number(info.@r);
			this.streamFile = info.@sercFilename;
			
		}
		override protected function OutputScale(mtp:Number):void{
			super.OutputScale(mtp);
			this.r=this.r/this.premultiple*this.multiple;
		}
		override public function setAttribute(attributes:ArrayCollection):void {
			StartAttribute(this.attribute).update(attributes);
		}
/*		public function setPatModel(pat:PatternModel):void
		{
			this.attribute.setPatMod(pat);
		}*/
	}
}
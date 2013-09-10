package org.act.od.impl.figure
{
	import mx.controls.Alert;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.binding.utils.BindingUtils;
	
	import org.act.od.impl.viewhelper.FigureEditorVH;

	public class ProcessFigure implements IFigure
	{
		public var children:Array;
		protected var attributeName:Array;
		protected var attributeValue:Array;
		
		[Bindable]
		public var multiple:Number=1;
		protected var premultiple:Number=1;
		
		public function ProcessFigure()
		{
			children=new Array();
			attributeName=new Array();
			attributeValue=new Array();
			
			BindingUtils.bindSetter(this.OutputScale,this,"multiple");

		}

		public function drawpicture():void
		{
			var i:int;
			for(i=0;i<children.length;i++){
				IFigure(children[i]).drawpicture();
			}
		}
		
		public function getuic():UIComponent
		{
			return null;
		}
		
		public function drawclear():void
		{
		}
		
		public function getstandardwidth():Number
		{
			return 0;
		}
		
//		public function getsymbolheight():Number
//		{
//			return 0;
//		}
//		
//		public function getsymbolwidth():Number
//		{
//			return 0;
//		}

		public function getstandardheight():Number
		{
			return 0;
		}
		
		public function getdrawid():Number
		{
			return 0;
		}
		
		public function setxy(x:Number,y:Number):void{
			
		}
		
		public function getx():Number
		{
			return 0;
		}
		
		public function gety():Number
		{
			return 0;
		}
		
		public function getrx():Number
		{
			return 0;
		}
		
		public function getry():Number
		{
			return 0;
		}
				
		public function isin(currentX:Number, currentY:Number):int
		{
			return 0;
		}
		
		public function getchildren():Array
		{
			return children;
		}
		
		public function haschild(child:IFigure):Boolean{
			var i:int;
			if(child.getparent()==this){
				return true;
			}
			for(i=0;i<children.length;i++){
				if(IFigure(children[i]).haschild(child)){
					return true;
				}
			}
			return false;
		}
		
		public function searchchildWithId(id:String):IFigure{

//			if(this.getAttributeValue("id")==id){
//				return this;
//			}
			
			var i:int;
			for(i=0;i<this.children.length;i++){
				
				//not consider container figure
//				ifi=IFigure(this.children[i]).searchchildWithId(Id);
//				if(ifi){
//					break;
//				}
				var childFigure:AbstractFigure = AbstractFigure(this.children[i]);
				if(childFigure.ID.toString() == id)
					return childFigure;
			}
			
			return null;
		}

		public function addchild(child:IFigure):void
		{
			if(haschild(child)){
				removechildWithoutConnection(child);
//				child.getchildren().splice(child.getchildren().indexOf(child),0);
//				return;
			}
			
			var i:int;
			var cf:ConnectionFigure;
			child.updateDraw();
			for(i=0;i<children.length;i++){
				IFigure(children[i]).addchild(child);
				if(IFigure(children[i]).haschild(child)){
					break;
				}
			}
			
			if(haschild(child)==false){
				child.setparent(this);
				if(child is ConnectionFigure){
					cf=ConnectionFigure(child);
					if(GraphicalFigure(cf.getEndFigure()).getEndConnection().indexOf(cf)==-1){
						GraphicalFigure(cf.getEndFigure()).getEndConnection().push(cf);
					}
					if(GraphicalFigure(cf.getStartFigure()).getStartConnection().indexOf(cf)==-1){
						GraphicalFigure(cf.getStartFigure()).getStartConnection().push(cf);
					}
				}
				children.push(child);
			}
		}
		
		public function addchildWithConnection(child:IFigure):void{
			var i:int;
			var gf:GraphicalFigure;
			var arr:Array;
			var len:int;
			
			addchild(child);
			
			if(child is GraphicalFigure){
				gf=GraphicalFigure(child);
				arr=gf.getStartConnection();
				len=arr.length;
				for(i=0;i<len;i++){
					if(child.getrootfigure().haschild(ConnectionFigure(arr[i]).getEndFigure())){
						child.getrootfigure().addchild(IFigure(arr[i]));
					}
				}
				arr=gf.getEndConnection();
				len=arr.length;
				for(i=0;i<len;i++){
					if(child.getrootfigure().haschild(ConnectionFigure(arr[i]).getStartFigure())){
						child.getrootfigure().addchild(IFigure(arr[i]));
					}
				}
			}
		}
		
		public function removechildWithConnection(child:IFigure,headarr:Array,tailarr:Array):void{
			var i:int;
			var j:int;
			var l:int;
			var line:Array;
			var otherline:Array;
			if(haschild(child)){
				child.drawclear();
				if(child is GraphicalFigure){
					line=GraphicalFigure(child).getStartConnection();
					j=line.length;
					for(i=0;i<j;i++){
						headarr[i]=line[0];
						this.removechildWithoutConnection(line[0]);
//						otherline=GraphicalFigure(ConnectionFigure(line[0]).getEndFigure()).getEndConnection();
//						otherline.splice(otherline.indexOf(ConnectionFigure(line[0])),1);
//						headarr[i]=line.shift();
					}
					line=GraphicalFigure(child).getEndConnection();
					j=line.length;
					for(i=0;i<j;i++){
						tailarr[i]=line[0];
						this.removechildWithoutConnection(line[0]);
//						otherline=GraphicalFigure(ConnectionFigure(line[i]).getStartFigure()).getStartConnection();
//						otherline.splice(otherline.indexOf(ConnectionFigure(line[i])),1);
//						tailarr[i]=line.shift();
					}
				}
			}
			else{
				return;
			}
			removechildWithoutConnection(child);
		}
		
		public function removechildWithoutConnection(child:IFigure):void
		{
			var i:int;
			var j:int;
			var l:int;
			if(haschild(child)){
				child.drawclear();
			}
			else{
				return;
			}
			var line:Array;
			for(i=0;i<children.length;i++){
				if(IFigure(children[i])==child){
					child.setparent(null);
					children.splice(i,1);
					if(child.getchildren()){
						l=child.getchildren().length;
						for(j=0;j<l;j++){
							addchild(IFigure(child.getchildren().shift()));
						}
					}
					i--;
					if(child is ConnectionFigure){
						line=GraphicalFigure(ConnectionFigure(child).getStartFigure()).getStartConnection();
						line.splice(line.indexOf(child),1);
						line=GraphicalFigure(ConnectionFigure(child).getEndFigure()).getEndConnection();
						line.splice(line.indexOf(child),1);
					}
				}
				else{
					IFigure(children[i]).removechildWithoutConnection(child);
				}
			}
		}
		
		public function setposition(x:Number,y:Number):void{
			
		}
		
		public function getparent():IFigure{
			return null;
		}
		
		public function setparent(parent:IFigure):void{
			
		}
		
		public function getrootfigure():IFigure{
			var ifi:IFigure=this;
			while(ifi.getparent()){
				ifi=ifi.getparent();
			}
			return ifi;
		}
		
		public function getupperfigure(x:Number,y:Number,flag:int=-1):IFigure{
			var temp:IFigure=null;
			var ret:IFigure=null;
			var i:int;
			if(this.getchildren()){
				for(i=0;i<this.getchildren().length;i++){
					temp=IFigure(this.getchildren()[i]).getupperfigure(x,y,flag);
					if(temp!=null){
						if(flag==-1){
							if(ret){
								if(ret.isin(x,y)<temp.isin(x,y)){
									ret=temp;
								}
							}
							else{
								ret=temp;
							}
						}
						else{
							ret=temp;
							break;
						}
					}
				}
			}
			return ret;
		}
		
		public function setsize(width:Number,height:Number):void{
			
		}
		
		public function autosetsize(arrowX:Number,arrowY:Number,mode:Number):void{
			
		}
		
		public function ifiguretoarray(ar:Array):void{
			var i:int;
			for(i=0;i<children.length;i++){
				IFigure(children[i]).ifiguretoarray(ar);
			}
		}
		
		public function getdrawx():Number{
			return getx();
		}
		
		public function getdrawy():Number{
			return gety();
		}
		
		public function isSelected():Boolean{
			return true;
		}
		
		public function setSelected(isslct:Boolean):void{
			
		}
		
		public function drawSelectedStyle():void{
			
		}
		
		public function updateDraw():void{
			var i:int;
			for(i=0;i<children.length;i++){
				IFigure(children[i]).updateDraw();
			}
		}
		
		public function changedirection(currentX:Number,currentY:Number):int{
			return 0;
		}
		
		public function getheight():Number{
			return 0;
		}
		
		public function getwidth():Number{
			return 0;
		}
		
		public function setID(ID:int):void{
			
		}
		
		public function getID():int{
			return -1;
		}
		
		public function getContextPanel():Canvas{
			return null;
		}
		
		public function showContextPanel():void{
			
		}
		
		public function hideContextPanel():void{
			
		}
		
		public function resetChildren():void {
			this.children = new Array();
		}
		public function getIsShowContextPanel():Boolean{
			return false;
		}
		public function setIsShowContextPanel(isShowContextPanel:Boolean):void{
			
		}



		public function outputAllInformation():XML{
			
			var processXML :XML=new XML("<Process></Process>");
			var i:int;
			for(i=0;i<this.children.length;i++){
				processXML.appendChild(IFigure(this.children[i]).outputAllInformation());
				//Alert.show(String(i));
			}
			
			return processXML;
		}
		
		public function readInformationToFigure(info:XML):void{
			
			var list:XMLList=info.elements("Process");	

			//clear children for reset
			this.resetChildren();

			var fig:IFigure;
			var connection :Array=new Array();
			list=XML(info).elements("Figure");
			var i:int;
			
			for(i=0;i<list.length();i++){
				
				fig = FigureFactory.createFigure(int(XML(list[i]).@drawid));
				fig.readInformationToFigure(XML(list[i]));
				
				if(fig is ConnectionFigure){
					connection.push(fig);
				}else{
					this.addchild(fig);
				}
			}
			
			var cf:ConnectionFigure;
			
			for(i=0;i<connection.length;i++){
				cf=ConnectionFigure(connection[i]);
				cf.setStartFigure(this.searchchildWithId(cf.getStartFigureId().toString()));
				cf.setEndFigure(this.searchchildWithId(cf.getEndFigureId().toString()));
				this.addchild(cf);
			}
 		}
 		public function setMultiple(mtp:Number):void{
			this.premultiple=this.multiple;
			this.multiple=mtp;
 		}
 		public function getMultiple():Number{
			return this.multiple;
 		}
		protected function OutputScale(mtp:Number):void{
			
		}
	
	}
}
package org.act.od.impl.figure
{
	import Pattern.AttributeModel;
	import Pattern.OperatorClass;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.impl.model.*;
	
	
	public class Userow2Figure extends Operatorow2Figure
	{
		
		private var jarFilename:String;
		private var functionName:String;
		
		public function Userow2Figure(did:Number)
		{
			super();
			drawid=did;
			this.addChild(this.lblNodeName);
			//this.setpicture(FigureFactory.Switch);
		}
		
		public function setJarFilename(expr: String, functionName:String): void
		{
			this.jarFilename = expr;
			this.functionName = functionName;
		}
		
		public function isJarFilenameSet():Boolean
		{
			if(this.jarFilename == null || this.functionName == null)
				return false;
			return true;
		}
		
		public function getJarFilename():String
		{
			return this.jarFilename;
		}
		
		public function getFunctionName():String
		{
			return this.functionName;
		}
		
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@isUserOp = "1";
			
			var cos:ArrayCollection = OrDesignerModelLocator.getInstance().cos;
			var currentCo:OperatorClass;
			for each (var co:OperatorClass in cos){
				if(co.name == this.figureName){
					currentCo = co;
					break;
				}
			}
			info.@jarFilename = co.filename;
			info.@functionName = co.functionName;
			var paras:String ="";
			for each (var para:AttributeModel in co.params.items){
				paras += para.name;
				paras += " ";
			}
			info.@paras = paras;
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			info.@isUserOp = "1";
			var cos:ArrayCollection = OrDesignerModelLocator.getInstance().cos;
			var currentCo:OperatorClass;
			for each (var co:OperatorClass in cos){
				if(co.name == this.figureName){
					currentCo = co;
					break;
				}
			}
			if(co == null)
				Alert.show("子定义算子" + figureName + "不存在！");
		}
	}
}
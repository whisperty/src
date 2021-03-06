package org.act.od.impl.figure
{
	import flash.geom.Point;
	
	import mx.controls.Alert;
	

	public class Projectow2Figure extends Operatorow2Figure
	{
		private var attributesName:String;
		public function Projectow2Figure()
		{
			super();
			drawid=102;
			this.setpicture(FigureFactory.project);
		}
		
		public function setAttributesIndex(attributesIndex:String):void
		{
			this.attributesName = attributesIndex;
		}
		
		public function getAttributesIndex():String
		{
			return attributesName;
		}
		
		override public function isConfig():Boolean
		{
			if(attributesName == null){
				mx.controls.Alert.show(this.figureName+"结点未设置条件");
				return false;
			}
			return true;
		}
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@attributesName = attributesName;
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			attributesName = info.@attributesName;
		}
	}
}
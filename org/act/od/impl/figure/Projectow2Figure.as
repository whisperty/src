package org.act.od.impl.figure
{
	import flash.geom.Point;
	

	public class Projectow2Figure extends Operatorow2Figure
	{
		private var attributesIndex:String;
		public function Projectow2Figure()
		{
			super();
			drawid=102;
			this.setpicture(FigureFactory.project);
		}
		
		public function setAttributesIndex(attributesIndex:String):void
		{
			this.attributesIndex = attributesIndex;
		}
		
		public function getAttributesIndex():String
		{
			return attributesIndex;
		}
		
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@attributesIndex = attributesIndex;
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			info.@attributesIndex = attributesIndex;
		}
	}
}
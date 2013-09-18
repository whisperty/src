package org.act.od.impl.figure
{
	import flash.geom.Point;

	public class Joinow2Figure extends Operatorow2Figure
	{
		
		public function Joinow2Figure()
		{
			super();
			drawid=103;
			this.setpicture(FigureFactory.join);
		}
		
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@radius=this.radius;
			
			//added by ty
			//add related info about the operator join
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			this.radius=Number(info.@radius);
		}
		
	}
}
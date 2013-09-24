package org.act.od.impl.figure
{
	import Pattern.PatternModel;
	public class Selectow2Figure extends Operatorow2Figure
	{
		
		//added by ty 20130917
		private var conditionExpr: String;
		
		public function Selectow2Figure()
		{
			super();
			drawid=114;
			this.setpicture(FigureFactory.select);
		}
		
		public function setConditionExpr(expr: String): void
		{
			conditionExpr = expr;
		}
		
		public function isConditionSet():Boolean
		{
			if(conditionExpr == null)
				return false;
			return true;
		}
		
		override public function isConfig():Boolean
		{
			return isConditionSet();
		}
		
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@conditionExpr = conditionExpr;
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			conditionExpr = info.@conditionExpr;
		}
/*		public function setPatModel(pat:PatternModel):void
		{
			this.attribute.setPatMod(pat);
		}*/
	}
}
package org.act.od.impl.figure
{
	import Pattern.PatternModel;
	public class SubProcessow2Figure extends Activityow2Figure
	{
		
		protected var subProcessFileName : String = null;
		
		protected var subProcessFileID : String = null;
		
		protected var subProcessFilePath : String = null;
		
		protected var _filePath :String = null;
		
		public function SubProcessow2Figure()
		{
			super();
			drawid=114;
			this.setpicture(FigureFactory.subProcess);
		}
		
		public function setSubProcessFileName(subProcessFileName : String) : void {
			this.subProcessFileName = subProcessFileName;
		}
		
		public function getSubProcessFileName() : String {
			return this.subProcessFileName;
		}
		
		public function setSubProcessFileID(subProcessFileID : String) : void {
			this.subProcessFileID = subProcessFileID;
		}
		
		public function getSubProcessFileID() : String {
			return this.subProcessFileID;
		}
		
		public function setSubProcessFilePath(subProcessFilePath : String) : void {
			this.subProcessFilePath = subProcessFilePath;
		}
		
		public function getSubProcessFilePath() : String {
			return this.subProcessFilePath;
		}
		
		public function set filePath(filePath :String):void{
			this._filePath = filePath;
		}
		public function get filePath():String{
			return this._filePath;
		}
		override public function outputAllInformation():XML{
			var info:XML=super.outputAllInformation();
			info.@subProcessFileName=this.subProcessFileName;
			info.@subProcessFileID=this.subProcessFileID;
			info.@subProcessFilePath=this.subProcessFilePath;
			return info;
		}
		
		
		override public function readInformationToFigure(info:XML):void{
			super.readInformationToFigure(info);
			this.subProcessFileName = info.@subProcessFileName;
			this.subProcessFileID = info.@subProcessFileID;
			this.subProcessFilePath = info.@subProcessFilePath;
		}
/*		public function setPatModel(pat:PatternModel):void
		{
			this.attribute.setPatMod(pat);
		}*/
	}
}
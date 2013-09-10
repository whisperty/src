package org.act.od.impl.vo
{
	import Pattern.AttributeModel;
	import Pattern.PatternModel;
	
	import mx.collections.ArrayCollection;
	
	import org.act.od.impl.other.StringConvertor;
	
	public class StartAttribute extends BasicAttribute 
	{
		[Bindable]
		public var dataSource:String;
		[Bindable]
		public var datasrc:ArrayCollection;
		
		public function StartAttribute() 
		{
			super();
			this.dataSource = "none";
			this.datasrc = new ArrayCollection();
		}
		public function updateDatasrc(srcName:String,srcContent:ArrayCollection):void
		{
			dataSource = srcName;
			/*datasrc = new ArrayCollection([{A1:"02221039294712000133",A2:"01",A3:" 0",
				A4:"15934983047",A5:"905328      ",A6:"15934983047",A7:"10086500             ",A8:"XL        ",
				A9:"01",A10:"      ",A11:"0     ",A12:"0      ",A13:"0",A14:"112",A15:"0471",A16:"047120",A17:"      ", 
				A18:"13800471500",A19:"20130222103921",A20:"20130222113933"},
				
				{A1:"02220939084712000480",A2:"01",A3:" 0",
					A4:"15149975013",A5:"905200      ",A6:"15149975013",A7:"10086                ",A8:"XL        ",
					A9:"01",A10:"      ",A11:"0     ",A12:"0      ",A13:"0",A14:"12 ",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130222093902",A20:"20130222113933"},
				
				{A1:"02221139314712000320",A2:"01",A3:" 0",
					A4:"1500498771",A5:"905200      ",A6:"15004987718",A7:"10086                ",A8:"HALL      ",
					A9:"01",A10:"      ",A11:"0     ",A12:"0      ",A13:"0",A14:"10 ",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130222113922",A20:"20130222113933"},
				
				{A1:"02221139344712000198",A2:"01",A3:" 0",
					A4:"14747888775",A5:"905200      ",A6:"14747888775",A7:"10086                ",A8:"XL      ",
					A9:"01",A10:"      ",A11:"0     ",A12:"0      ",A13:"0",A14:"114",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130222113926",A20:"20130222113933"},
				
				{A1:"02221139264712000311",A2:"01",A3:" 0",
					A4:"13948628591",A5:"905200      ",A6:"13948628591",A7:"10086                ",A8:"XL      ",
					A9:"01",A10:"00    ",A11:"0     ",A12:"0      ",A13:"0",A14:"140",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130222113916",A20:"20130222113933"},
				
				{A1:"02221139314712000597",A2:"01",A3:" 0",
					A4:"15147976904",A5:"905200      ",A6:"15147976904",A7:"10086                ",A8:"XL      ",
					A9:"01",A10:"00      ",A11:"0    ",A12:"0      ",A13:"0",A14:"140",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"220130222113922",A20:"20130222113933"},
				
				{A1:"02221139374712000361",A2:"01",A3:" 0",
					A4:"15124736516",A5:"905200      ",A6:"15124736516",A7:"10086                ",A8:"XL      ",
					A9:"01",A10:"      ",A11:"0     ",A12:"0      ",A13:"0",A14:"86 ",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130222113928",A20:"20130222113933"},
				
				{A1:"02211139314712000196",A2:"01",A3:" 0",
					A4:"13604750877",A5:"905200      ",A6:"13604750877",A7:"10086                ",A8:"XL      ",
					A9:"01",A10:"      ",A11:"0     ",A12:"MC:0062",A13:"0",A14:"88 ",A15:"0471",A16:"047120",A17:"      ", 
					A18:"13800471500",A19:"20130221113923",A20:"20130222113933"}
			]);*/
			datasrc = srcContent;
		}
		override public function getAttributeXML():Array {
			var xmlArray:Array = super.getAttributeXML();
			var dataSourceXMLValue : String = StringConvertor.readableToEscape(dataSource);
			var dataSourceNode:XML = new XML("<Attribute></Attribute>");
			dataSourceNode.@name = "dataSource";
			dataSourceNode.appendChild(dataSourceXMLValue);
			xmlArray.push(dataSourceNode);
			return xmlArray;
		}
		override public function setAttribute(atts:XMLList):void {
			var dataSourceNode:XMLList = atts.Attribute.(@name == "dataSource");
			this.dataSource = (dataSourceNode.children()!=null)?dataSourceNode.children().toString():"";
		}
		public function getdatasourceArray():ArrayCollection
		{
			return this.datasrc;
		}
		override public function getAttributeArray():ArrayCollection {
			return super.getAttributeArray();
		}
		override public function setPatMod(pt:PatternModel):void
		{
			super.setPatMod(pt);
		}
	}	
}
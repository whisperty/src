package fileoperation
{
	import Pattern.AttributeModel;
	import Pattern.OperatorClass;
	import Pattern.PatternModel;
	
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.impl.business.BpelCreator;
	import org.act.od.impl.figure.ProcessFigure;
	import org.act.od.impl.model.OrDesignerModelLocator;
	
	public class SaveToFile
	{
		public var netResult:String;
		public var network:String;
		public var f:FileReference;
		private var netFileName:String = "network1.xml";
		private var resultFileName:String = "result1.xml";
		public const patternFileName:String = "Patterns.xml";
		public const operatorFileName:String = "Operators.xml";
		
		[bindable]
		public var serverAddr:String;
		
		public function SaveToFile()
		{
			f = new FileReference();
		}
		public function saveData(resultData:String):void
		{
			f.save(resultData, resultFileName);
			//var downLoadURL:URLRequest = new URLRequest();
			//downLoadURL.url = resultFileName;
			//f.download(downLoadURL);
		}
		public function saveNet():void
		{
			var bpelCreator :BpelCreator = new BpelCreator();
			var newBPELText :String;
			var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			newBPELText = bpelCreator.outputInfo(ProcessFigure(orDesModelLoc.getFigureEditorNavigatorModel().activeFigureEditorModel.rootFigure) );
			//f.save(bpelCreator.getbpel(), netFileName);
			f.save(newBPELText, netFileName);
			//var netFolder:String = serverAddr+"netFolder/";
			//var request:URLRequest = new URLRequest(netFolder);
			//f.upload(request);
		}
		public function savePattern(data:ArrayCollection):void
		{
			var i:int = 0;
			var j:int = 0;
			var patternxml:XML = new XML("<patterns></patterns>");
			for(i=0; i<data.length; i++)
			{
				var pm:PatternModel = PatternModel(data[i]);
				var pa:XML = new XML("<pattern></pattern>");
				pa.@name = pm.patternName;
				pa.@attriNum = pm.attriNum;
				pa.@description = pm.descri;
				var attris:ArrayCollection = pm.attributes.items;
				for(j=0; j<attris.length; j++)
				{
					var am:AttributeModel = attris[j];
					var at:XML = new XML("<attribute></attribute>");
					at.@name = am.name;
					at.@type = am.name;
					at.@description = am.descri;
					pa.appendChild(at);
				}
				patternxml.appendChild(pa);
			}
			f.save(patternxml, patternFileName);
		}
		public function saveOperator(data:ArrayCollection):void
		{
			var i:int = 0;
			var operatorxml:XML = new XML("<operators></operators>");
			for(i=0; i<data.length; i++)
			{
				var co:OperatorClass = OperatorClass(data[i]);
				var cotemp:XML = new XML("<operator></operator>");
				cotemp.@name = co.name;
				cotemp.@descri = co.descri;
				cotemp.@filename = co.filename;
				operatorxml.appendChild(cotemp);
				var j:int = 0;
				var params:ArrayCollection = co.params.items;
				for(j=0; j<co.params.itemNum; j++)
				{
					var paraTemp:AttributeModel = params[j];
					var para:XML = new XML("<para></para>");
					para.@name = paraTemp.name;
					para.@type = paraTemp.type;
					para.@description = paraTemp.descri;
					cotemp.appendChild(para);
				}
				var outputs:ArrayCollection = co.outputs.items;
				for(j=0; j<co.outputs.itemNum; j++)
				{
					var outputTemp:AttributeModel = outputs[j];
					var output:XML = new XML("<output></output>");
					output.@name = outputTemp.name;
					output.@type = outputTemp.type;
					output.@description = outputTemp.descri;
					cotemp.appendChild(output);
				}
			}
			f.save(operatorxml, operatorFileName);
		}
	}
}
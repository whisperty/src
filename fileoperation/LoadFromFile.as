package fileoperation
{
	import Pattern.AttributeModel;
	import Pattern.OperatorClass;
	import Pattern.PatternModel;
	
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.figure.ProcessFigure;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.other.StringConvertor;
	import org.act.od.impl.view.FigureEditor;
	import org.act.od.impl.viewhelper.FigureEditorNavigatorVH;
	
	import org.act.od.impl.state.*;
	import org.act.od.impl.events.*;
	import org.act.od.impl.model.*;
	
	public class LoadFromFile
	{
		public var data:XML;
		public var filename:String;
		public var orDesignerLoc: OrDesignerModelLocator;
		public var patMods :ArrayCollection;
		
		[Bindable]
		public var cos:ArrayCollection;
		[Bindable]
		public var pms:ArrayCollection;
		
		public function LoadFromFile()
		{
			orDesignerLoc = OrDesignerModelLocator.getInstance();
			cos = new ArrayCollection();
			pms = new ArrayCollection();
		}
		public function getNet():void
		{
			var feModel :FigureEditorModel = new FigureEditorModel(filename);
			feModel.setxml(data);
			new FigureEditorNavigatorAppEvent(FigureEditorNavigatorAppEvent.ACTIVE_FIGUREEDITOR_PAGE,
				{ fileID:"File-9999", filePath:"Examples/examples/Example.xml", 
					fileName:filename, figureEditorModel:feModel }
			).dispatch();
			var feNavVH :FigureEditorNavigatorVH = 
				ViewLocator.getInstance().getViewHelper(FigureEditorNavigatorVH.VH_KEY) as FigureEditorNavigatorVH;
			feNavVH.createNewFigureEditor(feModel, "Examples/examples/Example.xml", filename);
			
			var xmlList:XMLList = new XMLList();
			xmlList = data.elements("Figure");
			for(var i:int = 0;i<xmlList.length();i++)
			{
				var atts:XMLList = new XMLList();
				atts = xmlList[i].children();
				var nameNode:XMLList = atts.Attribute.(@name == "name");
				var patNode:XMLList = atts.Attribute.(@name == "patMode");
				var nameXMLValue : String = (nameNode.children()!=null)?nameNode.children().toString():"";
				var nameValue : String = StringConvertor.escapeToReadable(nameXMLValue);
				var patXMLValue : String = (patNode.children()!=null)?patNode.children().toString():"";
				var patValue : String = StringConvertor.escapeToReadable(patXMLValue);
				if (nameValue.localeCompare("DataStream")==0)
				{
					var patt:PatternModel = getSelectedPatFromName(patValue);
					orDesignerLoc.setSelectedPat(patt);
				}
			}
		}
		public function getSelectedPatFromName(patStr:String):PatternModel
		{
			for (var i:int = 0;i<patMods.length;i++)
			{
				if(PatternModel(patMods[i]).patternName.localeCompare(patStr)==0)
					return PatternModel(patMods[i]);
			}
			return new PatternModel();
		}
		public function OperatorsintoModel(operatorColl:XML):void
		{
			var id:int = 8;
			for each(var p:XML in operatorColl..operator)
			{
				
				var co:OperatorClass = new OperatorClass(String(p.@name), String(p.@descri), String(p.@filename));
				for each (var q:XML in p..para)
				{
					var para:AttributeModel = new AttributeModel(String(q.@name), String(q.@type), String(q.@descri));
					co.addPara(para);
				}
				for each (var k:XML in p..output)
				{
					var output:AttributeModel = new AttributeModel(String(k.@name), String(k.@type), String(k.@descri));
					co.addOutput(output);
				}
				co.setID(id++);
				cos.addItem(co);
			}
		}
		public function PatternsintoModel(patternColl:XML):void
		{
			for each (var p:XML in patternColl..pattern)
			{
				var pm:PatternModel = new PatternModel(String(p.@name), Number(p.@attriNum), String(p.@description));
				for each (var q:XML in p..attribute)
				{
					var attri:AttributeModel = new AttributeModel(String(q.@name), String(q.@type), String(q.@description));
					pm.addAttri(attri);
				}
				pms.addItem(pm);
			}
		}
	}
}
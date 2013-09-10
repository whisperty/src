package org.act.od.impl.state
{
	import fileoperation.SaveToFile;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.rpc.xml.SimpleXMLDecoder;
	
	import org.act.od.impl.events.ListAllEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	
	public class RunningState extends AbstractState
	{
		private var feNavModel :FigureEditorNavigatorModel;
		private var attributeViewModel :AttributeViewModel;
		private var datasrcViewModel :DataSourceViewModel;
		private var _importedFile:FileReference;
		private var _exportedXml:XML;
		private var counter:Number = 2;
		private var selectedDataSource:Startow2Figure;
		private var readArr:ArrayCollection;
		public function RunningState()
		{
			super();
			this.feNavModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			this.attributeViewModel = OrDesignerModelLocator.getInstance().getAttributeViewModel();
			this.datasrcViewModel = OrDesignerModelLocator.getInstance().getDataSourceViewModel();
			this.readArr = new ArrayCollection();
			
		}
		override public function mouseDown(point:Point, event:MouseEvent):void{
			var x:Number=point.x;
			var y:Number=point.y;
			var selectedFigures:Array=feNavModel.activeFigureEditorModel.selectedFigures;
			var temp:IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(x,y);
			var i:int;
			
		//	Alert.show("ok");
			if(temp!=null)
			{
				
				if(selectedFigures.indexOf(temp)==-1)
				{
					feNavModel.activeFigureEditorModel.resetSelectedFigure();
				}
				temp.ifiguretoarray(selectedFigures);
				if(temp.isin(x,y)==1)
				{
					if(temp is Startow2Figure)
					{
						selectedDataSource = Startow2Figure(temp);
						importDataStreamHandler();
					}
					else if(temp is Endow2Figure)
					{
						
					}
					
				}
				
			}
			else
			{
				feNavModel.activeFigureEditorModel.resetSelectedFigure();
				//this.fcStateDomain.setFCActiveState(new MultiSelectionState());
				//this.fcStateDomain.mouseDown(point,event);
			}
			
			for(i=0;i<selectedFigures.length;i++){
				AbstractFigure(selectedFigures[i]).setSelected(true);
				AbstractFigure(selectedFigures[i]).updateDraw();
			}
		}
		protected function importDataStreamHandler():void{
			_importedFile = new FileReference;
			_importedFile.addEventListener(Event.SELECT, importedFile_selectHandler);
			//_importedFile.browse([new FileFilter("XML File", "*.xml")]);
			_importedFile.browse();
		}
		protected function importedFile_selectHandler(event:Event):void
		{
			_importedFile.addEventListener(Event.COMPLETE, importedFile_completeHandler);
			//_importedFile.addEventListener(IOErrorEvent.IO_ERROR, importedFile_errorHandler);
			//_importedFile.addEventListener(SecurityErrorEvent.SECURITY_ERROR, importedFile_errorHandler);
			_importedFile.load();
		}
		protected function importedFile_completeHandler(event:Event):void
		{
			
			
			var inputFileID:String = _importedFile.name; 
			OrDesignerModelLocator.getInstance().getFigureCanvasStateDomain().setFCActiveState(new RunningState2());
			OrDesignerModelLocator.getInstance().setDesignerToolBar();
			var fileID:String;
			var newRunEvent:ListAllEvent = new ListAllEvent(ListAllEvent.LIST,{fileID : inputFileID });
			newRunEvent.dispatch();
			//Alert.show("run");
			/*var list:XML = XML(_importedFile.data.toString());
			var xmlList:XMLList = new XMLList();
			xmlList = list.elements("item");
			//Alert.show(xmlList[0].toString());
			for(var i:int = 0;i<xmlList.length();i++)
			{
			var xmlDoc:XMLDocument = new XMLDocument(xmlList[i].toString());
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
			var resultObj:Object = decoder.decodeXML(xmlDoc);
			readArr.addItem(resultObj.item);
			}*/
			//OrDesignerModelLocator.getInstance().getDataSourceViewModel().editedFigure = selectedDataSource;
			OrDesignerModelLocator.getInstance().figureEditorNavigatorModel.activeFigureEditorModel.datasrcName = _importedFile.name;
			//Alert.show(OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasrcName);
			
		//	OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
	
		//	OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = readArr;
		//	selectedDataSource.setdatasourceArray(_importedFile.name,readArr);
			
		}
	}
}
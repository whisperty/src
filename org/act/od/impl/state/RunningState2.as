package org.act.od.impl.state
{
	import fileoperation.SaveToFile;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.utils.Endian;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	
	public class RunningState2 extends AbstractState
	{
		private var feNavModel :FigureEditorNavigatorModel;
		private var attributeViewModel :AttributeViewModel;
		private var datasrcViewModel :DataSourceViewModel;
		public var saveFile:FileReference ;
		
		public var resultFileName:String;
		public function RunningState2()
		{
			super();
			this.feNavModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			this.attributeViewModel = OrDesignerModelLocator.getInstance().getAttributeViewModel();
			this.datasrcViewModel = new DataSourceViewModel();
		}
/*		public function saveFileCompleteHandler(event:Event):void
		{
			OrDesignerModelLocator.getInstance().figureEditorNavigatorModel.activeFigureEditorModel.resultFileName = saveFile.name;
			//Alert.show(OrDesignerModelLocator.getInstance().resultFileName);
		}*/
		override public function mouseDown(point:Point, event:MouseEvent):void{
			var x:Number=point.x;
			var y:Number=point.y;
			var selectedFigures:Array=feNavModel.activeFigureEditorModel.selectedFigures;
			var temp:IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(x,y);
			var i:int;
			
			if(temp!=null)
			{
				temp.setSelected(true);
				temp.updateDraw();
				if(selectedFigures.indexOf(temp)==-1){
					feNavModel.activeFigureEditorModel.resetSelectedFigure();
				}
				temp.ifiguretoarray(selectedFigures);
				if(temp.isin(x,y)==1)
				{
					OrDesignerModelLocator.getInstance().getDataSourceViewModel().editedFigure = temp;
					//OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasrcName = 
					if(temp is Startow2Figure )
					{
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = Startow2Figure(temp).getdatasourceArray();
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
					else if(temp is Endow2Figure)
					{
/*						saveFile = new FileReference();
						saveFile.save("",resultFileName);
						
					//	saveFile.addEventListener(Event.COMPLETE, saveFileCompleteHandler);
						saveFile.addEventListener(Event.SELECT,saveFileCompleteHandler);
						//OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = Endow2Figure(temp).getresArray();
						//OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();*/
					}
					else if(temp is ConnectionFigure)
					{
						var start:IFigure = ConnectionFigure(temp).getStartFigure();
						var end:IFigure = ConnectionFigure(temp).getEndFigure();
						if(start is Startow2Figure)
						{
							OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = Startow2Figure(start).getdatasourceArray();
							OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
						}
						else if(end is Endow2Figure)
						{
							
						}
					}
					else
					{
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = new ArrayCollection();
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
				}
			}
			else
			{
				feNavModel.activeFigureEditorModel.resetSelectedFigure();
				OrDesignerModelLocator.getInstance().getDataSourceViewModel().editedFigure = null;
				OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasrcName = null;
				OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = new ArrayCollection();
				OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
			}
			for(i=0;i<selectedFigures.length;i++){
				AbstractFigure(selectedFigures[i]).setSelected(true);
				AbstractFigure(selectedFigures[i]).updateDraw();
			}
		}
	}
}
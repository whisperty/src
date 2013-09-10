package org.act.od.impl.state
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	
	public class CheckState extends AbstractState
	{
		private var feNavModel :FigureEditorNavigatorModel;
		private var attributeViewModel :AttributeViewModel;
		private var datasrcViewModel :DataSourceViewModel;
		[Bindable]
		private var res:ArrayCollection = new ArrayCollection([{IMSI:"02211139314712000196",event_type:"01",Duration:" 0",
			MSISDN:"13604750877",IMEI:"905200      ",VLR:"10086                ",cause:"XL      ",
			HLR:"01",sour_lac:"      ",sour_ci:"0     ",State:"MC:0062",end_ci:"0",cause_ID:"88 ",LAC:"0471",dest_lac:"047120",dest_ci:"      ", 
			oppo_num:"13800471500",Send_Stamp:"20130221113923",Receive_Stamp:"20130222113933"}]);
		public function CheckState()
		{
			
			super();
			this.feNavModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			this.attributeViewModel = OrDesignerModelLocator.getInstance().getAttributeViewModel();
			this.datasrcViewModel = OrDesignerModelLocator.getInstance().getDataSourceViewModel();
		}
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
					if(temp is Startow2Figure)
					{
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result2;
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
					else if(temp is Endow2Figure)
					{
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = 	OrDesignerModelLocator.getInstance().result1;
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
					else if(temp is ConnectionFigure)
					{
						var start:IFigure = ConnectionFigure(temp).getStartFigure();
						var end:IFigure = ConnectionFigure(temp).getEndFigure();
						if(start is Startow2Figure)
						{
							OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result2;
							OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
						}
						else if(end is Endow2Figure)
						{
							OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result1;
							OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
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
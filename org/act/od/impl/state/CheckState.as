package org.act.od.impl.state
{
	import Pattern.*;
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.serialization.json.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setInterval;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	
	import org.act.od.impl.business.BpelCreator;
	import org.act.od.impl.events.AccountEvent;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.figure.ProcessFigure;
	import org.act.od.impl.model.*;
	import org.act.od.impl.model.OrDesignerModelLocator;
	
	public class CheckState extends AbstractState
	{
		private var feNavModel :FigureEditorNavigatorModel;
		private var attributeViewModel :AttributeViewModel;
		private var datasrcViewModel :DataSourceViewModel;
		private var ID:String;
		private var patModel : PatternModel
		private var __locator:ServiceLocator=ServiceLocator.getInstance();
		private var _network:RemoteObject = (ServiceLocator.getInstance().getRemoteObject("network"));
		
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
		
		public function getData(e:ResultEvent):void
		{
			_network.removeEventListener(ResultEvent.RESULT, getData);
			
			var data:ArrayCollection = e.result as ArrayCollection;
			
			//Alert.show(data.getItemAt(0).toString()+"data");
			//OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = new ArrayCollection([{IMSI:"a", "phoneNumber":"b"}, {"IMSI":"C", "phoneNumber":"d"}]);
			//Alert.show(patModel.attriNum.toString());
			
			
	
			var i:int;
			var num:int = patModel.attriNum;
			var attrs :ArrayCollection = patModel.getPatAtt();
			var ans:ArrayCollection = new ArrayCollection();
			var tmp:String;
			//var jsonDecoder:JSONDecoder = new JSONDecoder();
			
			for(i = 0; i < data.length;)
			{
				var j:int;
				//var jsondecoder:JSONDecoder = new JSONDecoder();
				tmp = "{";
				
				for(j = 0; j < num; j++, i++)
				{
					if(j > 0)
						tmp = tmp + ",";
					
					tmp = tmp + '"' + attrs.getItemAt(j).name + '":"' + data.getItemAt(i).toString() + '"';
				}
				tmp = tmp + "}";
				
				ans.addItem(JSON.decode(tmp));
				
				//Alert.show(tmp.toString());
				//Alert.show(ans.toString());
			}
			//Alert.show("]]");;
			
			//Alert.show("tmp=" + tmp.toString());
			//Alert.show(new JSONDecoder(tmp).getValue().toString() +"=tmp");
			OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = ans;
			OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView2(patModel);
		}
		
		public function getAttributes(e:ResultEvent):void
		{
			_network.removeEventListener(ResultEvent.RESULT, getAttributes);
			var attris:ArrayCollection = e.result as ArrayCollection;
			patModel = new PatternModel();
			var i : int;
			for(i = 0; i < attris.length; i++)
				patModel.addAttri(new AttributeModel(attris.getItemAt(i).toString(), "String", ""));
		
		
			//Alert.show(attris.length.toString()+"length");
			//Alert.show("getAttributes" + attris.toString());
			
			_network.getData(ID);
			_network.addEventListener(ResultEvent.RESULT, getData);
		}
		
		public function getAttrAndData(id: String):void
		{
			ID = id;

			// Alert.show("nnnnnnnnnn");
			
			_network.getAttributes(ID);
			_network.addEventListener(ResultEvent.RESULT, getAttributes);
			//Alert.show("getAttrAndData");
		}
		
		override public function mouseDown(point:Point, event:MouseEvent):void{
			var x:Number=point.x;
			var y:Number=point.y;
			var selectedFigures:Array=feNavModel.activeFigureEditorModel.selectedFigures;
			var temp:IFigure = feNavModel.activeFigureEditorModel.rootFigure.getupperfigure(x,y);
			var i:int;
			
			//getAttrAndData("1");
			//OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = new ArrayCollection([{A:"a", B:"b"}, {B:"b"}]);
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
						//getAttrAndData(String(AbstractFigure(temp).ID));
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result2;
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
					else if(temp is Endow2Figure)
					{
						//getAttrAndData(String(AbstractFigure(temp).ID));
						OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = 	OrDesignerModelLocator.getInstance().result1;
						OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
					}
					else if(temp is ConnectionFigure)
					{
						var start:IFigure = ConnectionFigure(temp).getStartFigure();
						var end:IFigure = ConnectionFigure(temp).getEndFigure();
						
						//Alert("click link");
						getAttrAndData(String(AbstractFigure(start).ID));
						
						/*if(start is Startow2Figure)
						{
							OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result2;
							OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
						}
						else if(end is Endow2Figure)
						{
							OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource = OrDesignerModelLocator.getInstance().result1;
							OrDesignerModelLocator.getInstance().getOrchestraDesigner().figureAttributeNav.setDataSourceView();
						}*/
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
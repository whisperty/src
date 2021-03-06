
package  org.act.od.impl.business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
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

	
	public class AccountDelegate
	{
		private var __locator:ServiceLocator=ServiceLocator.getInstance(); 
		private var __service:HTTPService;
		private var _object:RemoteObject;
		private var __responder:IResponder;
		private var _accoutns:ArrayCollection;
		[Bindable]
		public var filterOptions:Object = new Object();
		[Bindable]
		private var accounts:ArrayCollection =new ArrayCollection();	
		private var _network:RemoteObject = (ServiceLocator.getInstance().getRemoteObject("network"));
		
		public function AccountDelegate()
		{
		
			_object 	=  (__locator.getRemoteObject("selectNetwork")); 
		
	
		
			
			
		}
		public function listResult(e:ResultEvent):void{
			//accounts.removeAll();
			accounts = e.result as ArrayCollection;
			if(accounts.length >= 10 ){
				var i:int;
				OrDesignerModelLocator.getInstance().result1.removeAll();
				if(accounts.length > 10 )
					OrDesignerModelLocator.getInstance().result2.removeAll();
			//	Alert.show(accounts.getItemAt(0).state +"+++++++listResult");
				for(i = 0; i<10;i++){
					OrDesignerModelLocator.getInstance().result1.addItem(accounts.getItemAt(i));
				}
				for(i ; i<accounts.length;i++){
					OrDesignerModelLocator.getInstance().result2.addItem(accounts.getItemAt(i));
				}
							
				accounts.removeAll();

			}
			
		}
		
		public function listResult2(e:ResultEvent):void{
			//Alert.show("listResult2");
		//	accounts.removeAll();
			accounts = e.result as ArrayCollection;
			if(accounts.length !=0 ){
			//	Alert.show(accounts.getItemAt(0).state +"+++++++");
				OrDesignerModelLocator.getInstance().result2.addAllAt(accounts,0);
			//	Alert.show(	OrDesignerModelLocator.getInstance().result2.length + "listResult2");
				accounts.removeAll();
			}
			
		}
		
		public function showResult(e:ResultEvent):void{
			var tmp:ArrayCollection = e.result as ArrayCollection;
			Alert.show("tmp=" + tmp);
		}
		
		private function getTime2():void {
			
			
			
			_object.getNext1000();
			_object.addEventListener(ResultEvent.RESULT, listResult2)
		}
		
		
		private function getTime():void {
	
			_object.getNext1000();
			_object.addEventListener(ResultEvent.RESULT, listResult);
				
		
		}
		
		public function getFinalDataForSaveFile(event:ResultEvent):void
		{
			_network.removeEventListener(ResultEvent.RESULT, getFinalDataForSaveFile);
			OrDesignerModelLocator.getInstance().resultData = event.result as String;
		}
		
		public function loadPhotos( fileID:String,outputID:String,options:Object):void
		{
		
		
			/* _object.init(options,fileID,outputID);
			 _object.SelectNetwork1();
			 setInterval(getTime, 10000); */// 1 second
		//	 setInterval(getTime2, 100); // 1 second
			
			
		

			 
			 var bpelCreator :BpelCreator = new BpelCreator();
			 var newBPELText :String;
			 var orDesModelLoc :OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
			 newBPELText = bpelCreator.outputInfo(ProcessFigure(orDesModelLoc.getFigureEditorNavigatorModel().activeFigureEditorModel.rootFigure) );
			 
			 _network.init(newBPELText);
			 _network.addEventListener(ResultEvent.RESULT, getFinalDataForSaveFile);
			 
			 //_network.get();
			// Alert("get");
			// _network.addEventListener(ResultEvent.RESULT, showResult);
		}
		
		public function savePatterns(patterns:String):void
		{
			
			var _saveSettings:RemoteObject;
			_saveSettings = (ServiceLocator.getInstance().getRemoteObject("saveSettings"));
			_saveSettings.savePatterns(patterns);
//			Alert.show("get back class successfully");
		}
		
		public function saveOperators(operators:String):void
		{
			var _saveSettings:RemoteObject;
			_saveSettings = (ServiceLocator.getInstance().getRemoteObject("saveSettings"));
			_saveSettings.saveOperators(operators);
		}
	}
}
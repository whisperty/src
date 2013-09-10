package  org.act.od.impl.business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	import org.act.od.impl.model.*;
	public class ListDataDelegate
	{
		private var __locator:ServiceLocator=ServiceLocator.getInstance(); 
		private var __service:HTTPService;
		private var _object:RemoteObject;
		private var __responder:IResponder;
		private var _accoutns:ArrayCollection;
		[Bindable]
		public var filterOptions:Object = new Object();
		[Bindable]
		private var accounts:ArrayCollection = null;	
		public function ListDataDelegate()
		{
			
			//_object 	=  (__locator.getRemoteObject("listItem")); 
			
			
			
			
			
		}
		public function listResult(e:ResultEvent):void{
			accounts = e.result as ArrayCollection;
		//	OrDesignerModelLocator.getInstance().getDataSourceViewModel().datasource.addAll( accounts);
		//	selectedDataSource.setdatasourceArray(fileID,accounts);
//
		}
		
		public function loadPhotos( fileID:String):void
		{
			
			
		//	_object.init("F:\\Stream\\"+fileID);
			
			
		//	_object.listAllItem();
		//	_object.addEventListener(ResultEvent.RESULT, listResult)
			
		}
	}
}
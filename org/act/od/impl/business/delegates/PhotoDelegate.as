package org.act.od.impl.business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	public class PhotoDelegate
	{
		private var __locator:ServiceLocator=ServiceLocator.getInstance(); 
		private var __service:HTTPService;
		private var _object:RemoteObject;
		private var __responder:IResponder;
		public function PhotoDelegate()
		{
			
			_object 	=  __locator.getRemoteObject("accountService"); 
		
		}
		public function loadPhotos():void
		{
			
			_object.list(null);
		
		}
	}
}
package com.bachk.demo.model
{

	[Bindable]
	[RemoteClass(alias="com.bachk.ssys.fcl.model.Account")]
	public class Account
	{
		public var username:String;
		public var password:String;
		public var role:String;
		public var enabled:Boolean;
		public var remark:String;
	}

}

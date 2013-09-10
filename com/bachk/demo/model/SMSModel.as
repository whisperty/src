package com.bachk.demo.model
{
	
	[Bindable]
	[RemoteClass(alias="com.bachk.demo.model.SMSModel")]
	public class SMSModel
	{
		public IMSI:String; 
		public event_type:String; 
		public Duration:String; 
		public MSISDN:String; 
		public IMEI:String; 
		
		public VLR:String; 
		public cause:String; 
		public HLR:String; 
		public sour_lac:String; 
		public sour_ci:String; 
		public state:String; 
		public end_ci:String; 
		public cause_ID:String; 
		public LAC:String; 
		public dest_lac:String; 
		public dest_ci:String; 
		public oppo_num:String; 
		public send_Stamp:String; 
		public receive_Stamp:String; 
		public succeed:Boolean; 
	}
	
}

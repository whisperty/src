package org.act.od.impl.other
{
	import mx.skins.Border;
	/**
	 * Provide properties be used as the source for image data binding.
	 */
	public class Resource
	{
		private static var instance: Resource;
		/**
		 * The source for "start" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/start.gif")]
        public var icon_tool_start :Class;
		/**
		 * The source for "end" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/end.gif")]
        public var icon_tool_end :Class;
		/**
		 * The source for "switch" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/switch.gif")]
        public var icon_tool_switch :Class;
		/**
		 * The source for "link" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/link.gif")]
        public var icon_tool_link :Class;
		/**
		 * The source for "activity" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/activity.gif")]
        public var icon_tool_activity :Class;
		/**
		 * The source for "email" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/email.gif")]
        public var icon_tool_email :Class;
		/**
		 * The source for "fax" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/fax.gif")]
        public var icon_tool_fax :Class;
		/**
		 * The source for "paper" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/pager.gif")]
        public var icon_tool_pager :Class;
		/**
		 * The source for "sms" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/sms.gif")]
        public var icon_tool_sms :Class;
		/**
		 * The source for "voice" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/voice.gif")]
        public var icon_tool_voice :Class;
		/**
		 * The source for "invoke" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/invoke.gif")]
        public var icon_tool_invoke :Class;
		/**
		 * The source for "receive" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/tool/receive.gif")]
        public var icon_tool_receive :Class;
		/**
		 * The source for "reply" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/reply.gif")]
        public var icon_tool_reply :Class;
		/**
		 * The source for "wait" image data binding.
		 */
        [Bindable]
        [Embed(source="../assets/icon/tool/wait.gif")]
        public var icon_tool_wait :Class;
		/**
		 * The source for "assign" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/tool/assign.gif")]
        public var icon_tool_assign :Class;
		/**
		 * The source for "subprocess" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/tool/subprocess.gif")]
        public var icon_tool_subprocess :Class;
		/**
		 * The source for "balloon" image data binding.
		 */
		[Bindable]
		[Embed(source="../assets/smallicons/balloon.png", scaleGridLeft="21",scaleGridTop="1",scaleGridRight="24",scaleGridBottom="79")]
		public var smallicons_balloon :Class;
		/**
		 * The source for "ballon-no-edge" image data binding.
		 */
		[Bindable]
		[Embed(source="../assets/smallicons/balloon-no-edge.png", scaleGridLeft="32",scaleGridTop="18",scaleGridRight="42",scaleGridBottom="21")]
		public var smallicons_balloon_no_edge :Class;
		/**
		 * The source for "ballon-edge" image data binding.
		 */
        [Bindable]
		[Embed(source="../assets/smallicons/balloon-edge.png")]
		public var smallicons_balloon_edge :Class;
		/**
		 * The source for "btn-remove" image data binding.
		 */
		[Bindable]
		[Embed(source="../assets/smallicons/btn-remove.png")]
		public var smallicons_btn_remove :Class;
		/**
		 * The source for "btn-label" image data binding.
		 */
		[Bindable]
		[Embed(source="../assets/smallicons/btn-label.png")]
		public var smallicons_btn_label :Class;
		/**
		 * The source for "btn-link" image data binding.
		 */
		[Bindable]
		[Embed(source="../assets/smallicons/btn-link.png")]
		public var smallicons_btn_link :Class;

		/**
		 * The Resource constructor should only be created
		 * through the static singleton getInstance() method.  Resource
		 * provide properties be used as the source for image data binding.
		 */
		public function Resource(){
			if(instance!=null) throw new Error("Error: Singletons can only be instantiated via getInstance() method!");
   			Resource.instance = this;
		}

		/**
		 * Singleton access to the Resource is assured through the static getInstance()
		 * method, which is used to retrieve the only ViewLocator instance in a Cairngorm
		 * application.
		 * 
		 * <p>Wherever there is a need to retreive the Resource instance, it is achieved
		 * using the following code:</p>
		 * 
		 * <pre>
		 * var resource:Resource = Resource.getInstance();
		 * </pre>
		 */
		public static function getInstance():Resource{
			if(instance==null) instance = new Resource();
			return instance;
		}
	}
}
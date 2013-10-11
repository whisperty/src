package org.act.od.impl.figure
{
	import flash.utils.Dictionary;
	
	
	public class FigureFactory
	{
		[Bindable]
		[Embed(source="../assets/figures/start.gif")]
		public static var start:Class;
		
		[Bindable]
        [Embed(source="../assets/figures/end.gif")]
        public static var end :Class;
		
		[Bindable]
        [Embed(source="../assets/icon/tool/project.gif")]
        public static var project :Class;
        
        [Bindable]
        [Embed(source="../assets/icon/tool/link.gif")]
        public static var link :Class;
        
        [Bindable]
        [Embed(source="../assets/icon/tool/combine.gif")]
        public static var combine :Class;
        
        [Bindable]
        [Embed(source="../assets/icon/tool/select.jpg")]
        public static var select :Class;


        private static var dic :Dictionary = new Dictionary();

		private static function initDic() :void {	
			var id :int;
			var name :String;
			
			id = 100;
			name = "DataStream";
			dic[id] = name;
			dic[name] = id;
			
			id = 101;
			name = "End";
			dic[id] = name;
			dic[name] = id;
			
			id = 102;
			name = "Project";
			dic[id] = name;
			dic[name] = id;
			
			id = 103;
			name = "Join";
			dic[id] = name;
			dic[name] = id;
			
			id = 114;
			name = "Select";
			dic[id] = name;
			dic[name] = id;
			
			id = 3;
			name = "Link";
			dic[id] = name;
			dic[name] = id;
			// below are user defined operators
			
		}
		
		public static function createFigure(figureId:int):IFigure{
			var ifi:IFigure;
			if(figureId > 3 && figureId <100)
				ifi = new Userow2Figure(figureId);
			else{
			switch(figureId)
			{
				case -1:
				ifi=null;
				break;
				
				case 3:
				ifi=new LinkFigure();
				break;
				
				case 100:
				ifi=new Startow2Figure();
				break;
				
				case 101:
				ifi=new Endow2Figure();
				break;
				
				case 102:
				ifi=new Projectow2Figure();
				break;
				
				case 103:
				ifi=new Joinow2Figure();
				break;
				
				case 114:
				ifi=new Selectow2Figure();
				break;
				
				default:
				ifi=null;
				break;	
				
			}
			}
			if(ifi){
				if(ifi is GraphicalFigure){
					GraphicalFigure(ifi).figureName = id2name(ifi.getdrawid());
				}
			}
			return ifi;
		}
		
		
		public static function nametoid(classname:String):int{
			FigureFactory.initDic();
			var id :int = FigureFactory.dic[classname];
			return id;
		}
		
		public static function id2name(id :int) :String {
			FigureFactory.initDic();
			var name :String = FigureFactory.dic[id];
			return name;
		}
		
		//edited by ty
		public static function setdic(name:String, id:String):void
		{
			dic[id]=name;
			dic[name]=id;
		}

	}
}
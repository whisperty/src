package Pattern
{
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.figure.FigureFactory;
	
	public class OperatorClass
	{
		public var name:String;
		public var descri:String;
		public var filename:String;
		[Bindable]
		public var params:MyArray;
		[Bindable]
		public var outputs:MyArray;
		[Bindable]
		public var figureID:int;
		
		public function OperatorClass(name:String=null, descri:String=null, filename:String=null)
		{
			this.name = name;
			this.descri = descri;
			this.filename = filename;
			params = new MyArray();
			outputs = new MyArray();
		}
		public function toString():String
		{
			return name;
		}
		
		public function addPara(item:AttributeModel):void{
			params.addItem(item);
		}
		
		public function removePara(item:AttributeModel):void{
			params.removeItem(item);
		}
		
		public function addOutput(item:AttributeModel):void{
			outputs.addItem(item);
		}
		
		public function removeOutput(item:AttributeModel):void{
			outputs.removeItem(item);
		}
		public function setID(id:int):void
		{
			this.figureID = id;
			FigureFactory.setdic(name, String(id));
		}
	}
}
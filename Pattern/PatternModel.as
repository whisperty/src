package Pattern
{
	import mx.controls.Alert;
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class PatternModel
	{
		[Bindable]
		public var patternName:String;
		[Bindable]
		public var descri:String;
		[Bindable]
		public var attriNum:int;
		[Bindable]
		public var attributes:MyArray;
		public function PatternModel(name:String=null, num:int=0, descri:String=null)
		{
			patternName = name;
			attriNum = num;
			this.descri = descri;
			attributes = new MyArray();
		}
		public function toString():String
		{
			return patternName;
		}
		public function addAttri(item:AttributeModel):void{
			attributes.addItem(item);
			attriNum = attributes.itemNum;
		}
		
		public function removeAttri(attri:AttributeModel):void{
			attributes.removeItem(attri);
			attriNum = attributes.itemNum;
		}
		public function getPatAtt():ArrayCollection{
			var atts:ArrayCollection = new ArrayCollection();
			for each (var item:AttributeModel in attributes.items)
			{
				atts.addItem({name: item.name, value: item.type, flag: "false"});
			}
			//Alert.show("getatt");
			return atts;
		}
	}
}
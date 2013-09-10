package Pattern
{
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;

	public class MyArray
	{
		[Bindable]
		public var items:ArrayCollection;
		[Bindable]
		public var itemNum:int;
		private var cursor:IViewCursor;
		public function MyArray()
		{
			items = new ArrayCollection();
			itemNum = 0;
		}
		public function addItem(item:AttributeModel):void{
			manageAddItem(item);
			itemNum += 1;
		}
		
		private function sortItem():void{
			var attriSort:Sort=new Sort();
			var sortField:SortField=new SortField("name");
			attriSort.fields=new Array(sortField);
			items.sort=attriSort;
			items.refresh();
		}
		
		private function manageAddItem(item:AttributeModel):void{
			if (isItemExist(item) != -1){
				itemNum--;
			}else{
				items.addItem(item);
			}
		}
		
		private function isItemExist(item:AttributeModel):int{
/*			var sci:AttributeModel = getItem(item);
			if(sci == null){
				return false;
			} else {
				return true;
			}*/
			for(var i:int = 0; i<itemNum; i++)
			{
				var attri:AttributeModel = AttributeModel(items[i]);
				if(items[i].name == item.name)
					return i;
			}
			return -1;
		}
		
/*		private function getItem(item:AttributeModel):AttributeModel{
			cursor = items.createCursor();
			sortItem();
			var found:Boolean = cursor.findFirst(item);
			if(found){
				var sci:AttributeModel = cursor.current as AttributeModel;
			}else{
				return null;
			}
			return sci;
		}*/
		
		public function removeItem(attri:AttributeModel):void{
/*			var sci:AttributeModel = getItem(attri);
			if(sci != null){
				cursor.remove();
			}
			itemNum -= 1;*/
			var temp:int = isItemExist(attri);
			if(temp != -1)
			{
				items.removeItemAt(temp);
				itemNum -= 1;
				
			}
		}
	}
}
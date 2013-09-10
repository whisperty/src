package org.act.od.impl.model
{
	import mx.collections.ArrayCollection;
	import org.act.od.impl.figure.*;
	import mx.controls.Alert;
	
	public class DataSourceViewModel
	{
		[Bindable]
		public var datasrcName:String;
		[Bindable]
		public var datasource :ArrayCollection;
		
		[Bindable]
		public var datasource1 :ArrayCollection;
		
		public var editedFigure :IFigure;
		public function DataSourceViewModel()
		{
			if(editedFigure != null && editedFigure is Startow2Figure) {
				datasource = Startow2Figure(editedFigure).getdatasourceArray();
			}else{
				datasource = new ArrayCollection();
			}
		}
		public function updateAttribute():void {
			if(editedFigure != null && editedFigure is Startow2Figure) {
				Startow2Figure(editedFigure).setdatasourceArray(datasrcName,datasource);
			}else{ 
				datasource = new ArrayCollection();
			}
		}
	}
}
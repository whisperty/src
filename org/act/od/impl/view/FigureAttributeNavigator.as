package org.act.od.impl.view
{
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.containers.TabNavigator;
	import mx.core.UIComponent;

	/**
	 * The view for figure's attribute.
	 */
	public class FigureAttributeNavigator extends TabNavigator
	{
		/**
		 * The source for "properties" image data binding.
		 */
		[Bindable]
        [Embed(source="../assets/icon/container/properties.gif")]
        public var properties :Class;
		
		private var figureAttributeView :AttributeView;
		private var figureDataSourceView :DataSourceView;
		
		/**
		 * Initialize figure's attribute view.
		 */
		public function FigureAttributeNavigator(){
			super();
			
			//modified by zjn
			figureAttributeView = new AttributeView();
			figureDataSourceView = new DataSourceView();
			figureDataSourceView.percentHeight = 80;
			figureDataSourceView.percentHeight = 100;
			figureAttributeView.percentHeight = 80;
			figureAttributeView.percentWidth = 100;
			this.setStyle("borderStyle","solid");
			this.percentHeight=100;
			this.percentWidth=100;
			this.createNewFigureEditor(this);
		}
		
		private function createNewFigureEditor(tabNavigator :TabNavigator):void{
		
			var newBox :Box = new Box();
			newBox.addChild(figureAttributeView);
			newBox.percentHeight = 100;
			newBox.percentWidth = 100;
			newBox.label = "Properties";
			newBox.icon = properties;
			tabNavigator.addChildAt(newBox,0);
			var dataBox :Box = new Box();
			dataBox.addChild(figureDataSourceView);
			dataBox.percentHeight = 100;
			dataBox.percentWidth = 100;
			dataBox.label = "DataDisplay";
			dataBox.icon = properties;
			tabNavigator.addChildAt(dataBox,1);
			dataBox.enabled = false;
		}
		public function setDataSourceView():void{
			figureDataSourceView.setDataGrid();
		}
		/*public function getDataSource():ArrayCollection
		{
			return this.figureDataSourceView
		}*/
		public function changeFAState():void{
			(this.getChildAt(0) as UIComponent).enabled = false;
			(this.getChildAt(1) as UIComponent).enabled = true;
			this.selectedIndex = 1;
		}
		
	}
}
package org.act.od.impl.view
{
	import mx.containers.Box;
	import mx.controls.LinkButton;
	import mx.controls.TileList;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.figure.FigureFactory;
	import org.act.od.impl.figure.GraphicalFigure;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.state.CreateConnectionStartState;
	import org.act.od.impl.state.CreationState;

	/**
	 * Provide the title for the toolPanel.
	 */
	public class ToolTile extends TileList
	{
		
		private var content :Array = new Array();
		
		private var xmlData :XMLList;
		

		
		public function ToolTile()
		{
			super();
			
			this.percentHeight = 100;
			this.percentWidth = 100;
			
			this.itemRenderer = new ClassFactory(ToolRenderer);
			this.direction = "vertical";
			this.explicitRowCount = 5;
			this.explicitColumnCount = 1;
			this.rowHeight = 20;
			this.dataProvider = content;
			
//			this.addEventListener(ListEvent.ITEM_CLICK,itemClickHandle);
		}
		/**
		 * Initialize the array for the buoon in the toolPanel.
		 */
		public function initArray() :void{
			
			var item:XML;
			for each(item in xmlData) {
				var button :LinkButton = new LinkButton();
				button.label = item.attribute("name");
				button.buttonMode = false;
				button.percentWidth = 100;
				button.height = 16;
				content.push(button);
			}
		}
		
		public function setInvisible(buttonlabel :String): void{
			var i:int;
			for (i=0; i<content.length; i++)
			{
				if(this.content[i].label == buttonlabel)
				{
					content[i].visible = false;
				}
			}
		}
		
		public function setXMLData(xmlList :XMLList) :void {
			this.xmlData = xmlList;
		}
		
		//editedy by ty
		public function resetContent():void
		{
			content.splice(0, content.length);
		}
		
	}
}
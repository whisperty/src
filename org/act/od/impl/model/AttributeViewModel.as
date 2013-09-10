package org.act.od.impl.model{
	
	import mx.collections.ArrayCollection;
	import org.act.od.impl.figure.*;
	/**
	 * The model for AttributeView
	 */
	public class AttributeViewModel{
		
		/**
		 * The attribute of the selected figure.
		 */
		[Bindable]
		public var attibutes :ArrayCollection;
		/**
		 * The selected figure.
		 */
		public var editedFigure :AbstractFigure;
		/**
		 * Initial the selected figure's attribute.
		 */
		public function AttributeViewModel():void {
			if(editedFigure != null) 
			{
				attibutes = editedFigure.getAttributeArray();

			}else
			{
				attibutes = new ArrayCollection();
			}
		}
		/**
		 * Updata the selected figure's attribute.
		 */
		public function updateAttribute():void {
			if(editedFigure != null) {
				editedFigure.setAttribute(attibutes);
			}else{ 
				attibutes = new ArrayCollection();
			}
		}
	}
	
}
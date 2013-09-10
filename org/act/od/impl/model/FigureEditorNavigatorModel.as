package org.act.od.impl.model{
	
	import flash.utils.Dictionary;
	import org.act.od.impl.view.FigureEditorNavigator;
	
	/**
	 * Store message of primitives editor area
	 */
	public class FigureEditorNavigatorModel{
		
		/**
		 * The model of active figureEditor.
		 */
		private var _activeFEModel :FigureEditorModel;
		
		/**
		 * The model of active BPELEditor.
		 */
	

		/**
		 * A hash map, keyed on fileID with a FigureEditorModel as the value.
		 */
		private var figureEditorModelMap : Dictionary = new Dictionary();
		
		/**
		 * A hash map, keyed on fileID with a BPELEditorModel as the value.
		 */
		private var bpelEditorModelMap : Dictionary = new Dictionary();

		/**
		 * The xml form of the selected figure just for copy and paste operation.
		 */
		private var _xmlOfCopyFigures :XML;
		
		
		public function FigureEditorNavigatorModel(){
			
		}
		
		public function get xmlOfCopyFigures():XML{
			return this._xmlOfCopyFigures;
		}
		
		public function set xmlOfCopyFigures(xml :XML):void{
			this._xmlOfCopyFigures=xml;
		}
		
		public function get activeFigureEditorModel() :FigureEditorModel{
			return this._activeFEModel;
		}
		
		public function set activeFigureEditorModel(figureEditorModel :FigureEditorModel) :void{
			this._activeFEModel = figureEditorModel;
		}
		
	
		
		/**
		 * creat a new figureEditorModel with the parameter, if a model for the fileID 
		 * already exist, then just return the old model.
		 * 
		 * @param fileID
		 * @return 
		 */
		public function addFigureEditorModel(fileID :String) :FigureEditorModel{
			var feModel :FigureEditorModel =  this.figureEditorModelMap[fileID];
			if(feModel == null) {
				feModel = new FigureEditorModel(fileID);
				this.figureEditorModelMap[fileID] = feModel;
   			}
 			return feModel;
		}
		
		public function deleteFigureEditorModel(fileID :String) :void {
			delete this.figureEditorModelMap[fileID];
		}
		
		public function getFigureEditorModel(fileID :String) :FigureEditorModel {
			return this.figureEditorModelMap[fileID];
		}
		
 		
 		/**
 		 * creat a new bpelEditorModel with the parameter, if a model for the fileID
		 * already exist, then just return the old model.
		 * 
 		 * @param fileID
 		 * @return
 		 */
 	
 		
 		

	}
}
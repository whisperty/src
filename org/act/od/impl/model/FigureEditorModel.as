package org.act.od.impl.model{
	
	import Pattern.PatternModel;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import org.act.od.impl.figure.*;
	
	/**
	 * Store primitive canvas
	 */
	public class FigureEditorModel{
		/**
		 * Root figure.
		 */
		private var _rootFigure :IFigure;
		/** 
		 * The array store selected figures.
		 */
		private var _selectedFigures :Array;
		/**
		 * Over figure.
		 */
		private var _overFigure:IFigure;
		
		private var _canvasXML:XML = null;
		
		private var _backupCanvasXML : XML = null;
		
		private var _fileID :String;
		
		private var _relativeBpelFileID :String;
		
		[Bindable]
		public var _showingMultiple:Number=1;
		
		//added by ty 2013
		private var _selectedPattern:PatternModel;
		
		
		
		//added by ty 20130705
		public var resultFileName:String;
		public var datasrcName:String;
		/**
		 * store local id manager
		 */
		public var idManager :FigureIDManager = new FigureIDManager();
		
		//add by ty
		public function setxml(data:XML):void
		{
			_canvasXML = data;
		}
		public function setRoot(data:XML):void
		{
			_rootFigure = IFigure(data);
		}
		
		//added by ty 20130703
		public function setPatModel(pat:PatternModel):void
		{
			_selectedPattern = pat;
		}
		public function getPatModel():PatternModel
		{
			return _selectedPattern;
		}
		
		
		public function FigureEditorModel(fileID :String){
			super();
			this._rootFigure = new ProcessFigure();
			this._selectedFigures = new Array();
			
			this._fileID = fileID;
			BindingUtils.bindSetter(this.smChange,this,"_showingMultiple");
		}
		
		public function isChanged() : Boolean {
			var isChanged : Boolean = true;
			
			if(this._canvasXML.toXMLString().localeCompare("<Process/>") == 0) {
				isChanged = false;
			}
			else if(this._backupCanvasXML != null) {
				var backupCanvasXMLString : String = this._backupCanvasXML.toXMLString();
				var currentCanvasXMLString : String = this._canvasXML.toXMLString();
				if(backupCanvasXMLString.localeCompare(currentCanvasXMLString) == 0) {
					isChanged = false;
				}
			}
			
			return isChanged;
		}
		
		public function updateCanvasXML():void{
			this._canvasXML = _rootFigure.outputAllInformation();
		}
		
		public function saveCanvasXML() : void {
			updateCanvasXML();
			this._backupCanvasXML = this._canvasXML.copy();
		}
		
		public function unsaveCanvasXML() : void {
			if(this._backupCanvasXML == null)
				this._canvasXML = <Process/>;
			else
				this._canvasXML = this._backupCanvasXML.copy();
		}
		
		public function get canvasXML() :XML {
			return this._canvasXML;
		}
		
		
		public function get fileID():String{
			return this._fileID;
		}
		
		public function get relativeBpelID():String{
			return this._relativeBpelFileID;
		}
		
		public function set relativeBpelID(bpelID :String) :void{
			this._relativeBpelFileID = bpelID;
		}
		
		public function set showingMultiple(sm:Number):void{
			this._showingMultiple = sm;
		}
		
		public function get showingMultiple():Number{
			return this._showingMultiple;
		}
		
		/**
		 * Clear elements of selectedfigure
		 * redraw selected elements
		 */
		public function resetSelectedFigure() :void{
			for(var i:int=0; i<_selectedFigures.length; i++){
				IFigure(_selectedFigures[i]).setSelected(false);
				IFigure(_selectedFigures[i]).setIsShowContextPanel(false);
				IFigure(_selectedFigures[i]).updateDraw();
			}
			_selectedFigures.splice(0, _selectedFigures.length);
		}
		
		
		/**
		 * Clear elements of selectedfigure not redraw selected elements
		 */
		public function clearSelectedFigure() :void{
			for(var i:int=0; i<_selectedFigures.length; i++){
				IFigure(_selectedFigures[i]).setSelected(false);
			}
			_selectedFigures.splice(0, _selectedFigures.length);
		}
		
		public function get rootFigure() :IFigure{
			return this._rootFigure;
		}
		
		public function get selectedFigures() :Array{
			return this._selectedFigures;
		}
		
		public function get overFigure():IFigure{
			return this._overFigure;
		}
		
		public function set overFigure(ifi:IFigure):void{
			this._overFigure = ifi;
		}
		public function isSelectionStart():Boolean{
			var i:Number;
			for(i=0;i<selectedFigures.length;i++){
				if(AbstractFigure(selectedFigures[i]).figureName == "DataStream")
					return true;
			}
			return false;
		}
		protected function smChange(sm:Number):void{
			var ar:Array=new Array();
			var con:Array=new Array();
			if(this.rootFigure is ProcessFigure){
				ProcessFigure(this.rootFigure).multiple=this.showingMultiple;
			}
			this.rootFigure.ifiguretoarray(ar);
			var i:int;
			for(i=0;i<ar.length;i++){
				IFigure(ar[i]).setMultiple(this.showingMultiple);
				if(ar[i] is ConnectionFigure){
					con.push(ar[i]);
				}
			}
			for(i=0;i<con.length;i++){
				ConnectionFigure(con[i]).autoSetAnchor();
			}
			for(i=0;i<ar.length;i++){
				IFigure(ar[i]).updateDraw();
			}
		}
		
	}
}
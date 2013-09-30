package org.act.od.impl.model{
	
	import Pattern.AttributeModel;
	import Pattern.PatternModel;
	
	import component.ProgressBar;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.model.IModelLocator;
	import org.act.od.impl.figure.*;
	import org.act.od.impl.model.*;
	import org.act.od.impl.view.FigureAttributeNavigator;
	import org.act.od.impl.view.OrchestraDesigner;
	import org.act.od.impl.vo.BasicAttribute;
	
	/**
	 * OrDesignerModelLocator is the marker interface used by Cairngorm
	 * applications to implement the model in an Model-View-Controller
	 * architecture.
	 */
	public class OrDesignerModelLocator implements IModelLocator{
		
		/**
		 * Singleton Pattern.
		 */
		private static var odModelLocator : OrDesignerModelLocator;
		
		/** 
		 * Attribute view Model.
		 */
			
		[Bindable]
		public var result1:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var result2:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var pms:ArrayCollection;
		[Bindable]
		public var cos:ArrayCollection;
//		public var selectedPattern:PatternModel;
		[Bindable]
		private var dataSourceViewModel :DataSourceViewModel;
		
		public var resultData:String ="";
		
		[Bindable]
		private var attributeViewModel :AttributeViewModel;
//		public var property:String;
//		public var operator:String;
//		public var value:String;
		/** 
		 * Primitives editor area Moedl.
		 */
		public var figureEditorNavigatorModel :FigureEditorNavigatorModel;
		public var figureAttributeNavigatorModel :FigureAttributeNavigator;
		
		/** 
		 * TooLBox Model.
		 */
		private var toolPanelModel : ToolPanelModel;
		
		/** 
		 * Primitives editor area data Moedl.
		 */
		private var fcStateDomain :FigureCanvasStateDomain;
		
		/** 
		 * File navigator Model.
		 */
		private var fileNavigatorViewModel:FileNavigatorViewModel;
		
		/**
		 * UDDIRefModel reference model.
		 */
		private var progressBar :ProgressBar;
		
		
		/**
		 * The instance of OrchestraDesigner.
		 */
		private var orchestraDesigner :OrchestraDesigner;
		
		/**
		 * Singleton access to the OrDesignerModelLocator is assured through the static getInstance()
		 * method, which is used to retrieve the only OrDesignerModelLocator instance in a Cairngorm
		 * application.
		 * 
		 * <p>Wherever there is a need to retreive the Resource instance, it is achieved
		 * using the following code:</p>
		 * 
		 * <pre>
		 * var orDesignerModelLocator:OrDesignerModelLocator = OrDesignerModelLocator.getInstance();
		 * </pre>
		 */
		public static function getInstance() : OrDesignerModelLocator{
			if(odModelLocator == null)
				OrDesignerModelLocator.odModelLocator = new OrDesignerModelLocator(new SingleEnforcer());
			return OrDesignerModelLocator.odModelLocator;
		}
		
		/**
		 * Initial all models.
		 */
		public function OrDesignerModelLocator(enforcer:SingleEnforcer):void {
			super();	
			this.attributeViewModel = new AttributeViewModel();
			this.dataSourceViewModel = new DataSourceViewModel();
			this.figureEditorNavigatorModel = new FigureEditorNavigatorModel();
			this.toolPanelModel = new ToolPanelModel();
			this.fcStateDomain = new FigureCanvasStateDomain();
			this.fileNavigatorViewModel  = new FileNavigatorViewModel();
		}
		
		public function getAttributeViewModel() :AttributeViewModel{
			return this.attributeViewModel;
		}
		public function setAttributeViewModel():void
		{
			//Alert.show(selectedPattern.patternName);
			this.attributeViewModel.attibutes = figureEditorNavigatorModel.activeFigureEditorModel.getPatModel().getPatAtt();
		}
		public function setAttributeViewModel2(atts:ArrayCollection):void
		{
			this.attributeViewModel.attibutes = atts;
		}
		public function setSelectProperty(conditionExpr:String):void
		{
//			property = pro;
//			operator = op;
//			value = val;
			var sfs:Array = figureEditorNavigatorModel.activeFigureEditorModel.selectedFigures;
			for each (var sf:IFigure in sfs){
				if(sf is Selectow2Figure){
					Selectow2Figure(sf).setConditionExpr(conditionExpr);
//					Alert.show("条件表达式设置成功");
				}
			}
		}
		
		public function setProjectProperty(attributesIndex:String):void
		{
			var sfs:Array = figureEditorNavigatorModel.activeFigureEditorModel.selectedFigures;
			for each (var sf:IFigure in sfs){
				if(sf is Projectow2Figure)
					Projectow2Figure(sf).setAttributesIndex(attributesIndex);
			}
		}
		
		public function setProjectPattern(pm:PatternModel):void
		{
			getFigureEditorNavigatorModel().activeFigureEditorModel.setPatModel(pm);
			var sfs:Array = figureEditorNavigatorModel.activeFigureEditorModel.selectedFigures;
			for each (var sf:IFigure in sfs){
				if(sf is Startow2Figure)
					Startow2Figure(sf).setPatternModel(pm);
			}
		}
		/**
		 * Return the attributeViewModel.
		 */
		public function getDataSourceViewModel():DataSourceViewModel{
			return this.dataSourceViewModel;
		}
		public function setDataSourceViewModel(datasrcModel:DataSourceViewModel):void
		{
			this.dataSourceViewModel = datasrcModel;
		}
		/**
		 * Return the figureEditorNavigatorModel.
		 */
		public function getFigureEditorNavigatorModel() :FigureEditorNavigatorModel{
			return this.figureEditorNavigatorModel;
		}
		/**
		 * Return the toolPanelModel
		 */
		public function getToolPanelModel() : ToolPanelModel{
			return this.toolPanelModel;
		}
		/**
		 * Return the fcStateDomain.
		 */
		public function getFigureCanvasStateDomain() :FigureCanvasStateDomain{
			return this.fcStateDomain;
		}
		/**
		 * Return the fileNavigatorViewModel
		 */
		public function getFileNavigatorViewModel():FileNavigatorViewModel{
			return this.fileNavigatorViewModel;
		}
		/**
		 * Return the orchestraDesigner.
		 */
		public function getOrchestraDesigner() :OrchestraDesigner{
			return this.orchestraDesigner;
		}
		/**
		 * Set the orchestraDesigner.
		 */
		public function setOrchestraDesigner(od :OrchestraDesigner):void{
			this.orchestraDesigner = od;
		}
		/**
		 * Return the UDDIRefModel.
		 */
		public function getFigureAttributeNavigator():FigureAttributeNavigator{
			return this.orchestraDesigner.figureAttributeNav;
		}
		public function popProgressBar():void{
			progressBar = ProgressBar(PopUpManager.createPopUp(orchestraDesigner,ProgressBar,true));
			PopUpManager.centerPopUp(progressBar);
			progressBar.playProgressBar();
		}
		public function setDesignerToolBar():void{
			orchestraDesigner.designerToolBar.runState();
		}
		
		public function setSaveButton():void{
			orchestraDesigner.designerToolBar.setSaveButton();
		}
		public function getPmsArr():ArrayCollection{
			return orchestraDesigner.pms;
		}
		public function setSelectedPat(pat:PatternModel):void
		{
			//selectedPattern = pat;
			figureEditorNavigatorModel.activeFigureEditorModel.setPatModel(pat);
			setAttributeViewModel();
		}
		public function getSelectedPat():PatternModel
		{
			return figureEditorNavigatorModel.activeFigureEditorModel.getPatModel();
		}
	}
	
	
}
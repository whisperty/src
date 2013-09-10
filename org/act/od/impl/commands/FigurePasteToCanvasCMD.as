package org.act.od.impl.commands
{
	import mx.managers.PopUpManager;
	
	import org.act.od.framework.commands.AODCommand;
	import org.act.od.framework.control.OrDesignerEvent;
	import org.act.od.framework.view.ViewLocator;
	import org.act.od.impl.figure.AbstractFigure;
	import org.act.od.impl.figure.ConnectionFigure;
	import org.act.od.impl.figure.Endow2Figure;
	import org.act.od.impl.figure.FigureFactory;
	import org.act.od.impl.figure.IFigure;
	import org.act.od.impl.figure.ProcessFigure;
	import org.act.od.impl.figure.Startow2Figure;
	import org.act.od.impl.model.FigureEditorModel;
	import org.act.od.impl.model.FigureEditorNavigatorModel;
	import org.act.od.impl.model.OrDesignerModelLocator;
	import org.act.od.impl.view.FigureCreateFailedWarning;
	import org.act.od.impl.viewhelper.FigureEditorVH;
	
	/**
	 * Paste a figures to the canvas and figureEditorModel.
	 */ 
	public class FigurePasteToCanvasCMD extends AODCommand{
		
		
		public function FigurePasteToCanvasCMD(){
			super();
		}
		
		
		/**
		 * 
		 * @param event {fileID}
		 * 
		 */
		override public function execute(event :OrDesignerEvent) :void{
			
			var fileID :String = event.data.fileID;
			
			var feVH :FigureEditorVH = 
					ViewLocator.getInstance().getViewHelper(FigureEditorVH.getViewHelperKey(fileID)) as FigureEditorVH;
			
			var feNavModel :FigureEditorNavigatorModel = OrDesignerModelLocator.getInstance().getFigureEditorNavigatorModel();
			
			var feModel :FigureEditorModel = feNavModel.getFigureEditorModel(fileID);
			
			var selectedFigures :Array = feModel.selectedFigures;
			
			var rootfigure :ProcessFigure = ProcessFigure(feNavModel.activeFigureEditorModel.rootFigure);
			
			if(feNavModel.xmlOfCopyFigures){
						
				var xml:XML = feNavModel.xmlOfCopyFigures;
				
				feNavModel.activeFigureEditorModel.resetSelectedFigure();
				
				var fig :IFigure;
				var connection :Array = new Array();
				var figList :XMLList = xml.elements("Figure");
				var i :int;
				var mapobject :Object = new Object();
				
				var j:int;
				var arr:Array;
				var fcfw:FigureCreateFailedWarning;
						
				for(i=0;i<figList.length();i++){
					
					fig = FigureFactory.createFigure( int(XML(figList[i]).@drawid) );
					
					if(fig is Startow2Figure){
						arr=new Array();
						feModel.rootFigure.ifiguretoarray(arr);
						for(j=0;j<arr.length;j++){
							if(arr[j] is Startow2Figure){
								break;
							}
							else{
								continue;
							}
						}
						if(j<arr.length){
							fcfw = PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),
																 FigureCreateFailedWarning, true) as FigureCreateFailedWarning;
							PopUpManager.centerPopUp(fcfw);
							continue;
						}
					}
					if(fig is Endow2Figure){
						arr=new Array();
						feModel.rootFigure.ifiguretoarray(arr);
						for(j=0;j<arr.length;j++){
							if(arr[j] is Endow2Figure){
								break;
							}
							else{
								continue;
							}
						}
						if(j<arr.length){
							fcfw = PopUpManager.createPopUp(OrDesignerModelLocator.getInstance().getOrchestraDesigner(),
																 FigureCreateFailedWarning, true) as FigureCreateFailedWarning;
							PopUpManager.centerPopUp(fcfw);
							continue;
						}
					}
					
					
					fig.readInformationToFigure( XML(figList[i]));
					
					var copiedNode_id:int = feNavModel.activeFigureEditorModel.idManager.getAvailabelId();

					mapobject[fig.getID().toString()] = copiedNode_id;
							
					fig.setID(copiedNode_id);
							
					if(fig is ConnectionFigure){
						connection.push(fig);
					}else{
						if(feVH){
							feVH.addFigureToCanvas( AbstractFigure(fig) );
							rootfigure.addchild(fig);
							fig.ifiguretoarray(selectedFigures);
						}
					}
				}
						
				var cf:ConnectionFigure;

				for(i=0;i<connection.length;i++){
					cf=ConnectionFigure(connection[i]);
					if(mapobject.hasOwnProperty(cf.getStartFigureId().toString())&&mapobject.hasOwnProperty(cf.getEndFigureId().toString())){
						cf.setStartFigure(rootfigure.searchchildWithId(mapobject[cf.getStartFigureId().toString()]));
						cf.setEndFigure(rootfigure.searchchildWithId(mapobject[cf.getEndFigureId().toString()]));
						rootfigure.addchild(cf);
						if(feVH){
							feVH.addFigureToCanvas( AbstractFigure(cf) );
							cf.ifiguretoarray(selectedFigures);
						}	
					}else{
						continue;
					}
				}
				
				
				for(i=0;i<selectedFigures.length;i++){
					fig=IFigure(selectedFigures[i]);
					fig.setSelected(true);
					fig.setMultiple(feNavModel.activeFigureEditorModel._showingMultiple);
					if(fig is ConnectionFigure){
						continue;
					}
					fig.setposition(fig.getdrawx()+50,fig.getdrawy()+50);
				}
						
				
				for(i=0;i<selectedFigures.length;i++){
					fig=IFigure(selectedFigures[i]);
					if(fig is ConnectionFigure){
						ConnectionFigure(fig).autoSetAnchor();
					}
					fig.updateDraw();
				}
						
			}
			
		}

	}
}
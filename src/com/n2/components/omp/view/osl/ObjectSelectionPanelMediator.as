package com.n2.components.omp.view.osl {
	import com.n2.components.library.events.AssetLoaderEvent;
	import com.n2.components.omp.model.OMPModel;
	import fl.controls.Label;
	import flash.text.TextFormat;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectSelectionPanelMediator extends Mediator {
		[Inject]
		public var view:ObjectSelectionPanel;
		[Inject]
		public var ompModel:OMPModel;
		
		public function ObjectSelectionPanelMediator(){
		}
		
		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, AssetLoaderEvent.LOAD_ASSETS_END, updateDataGrid);
			
			setupGUI();
		}
		
		private function updateDataGrid(e:AssetLoaderEvent):void {
			trace("updateDataGrid");
		}
		
		private function setupGUI():void {
			//Set text fields format
			var tf:TextFormat = new TextFormat("Lucida Console", 10, 0x000000, false);
			
			for (var i:Number = 0; i < view.numChildren; i++){
				var child:* = view.getChildAt(i);
				if (child is Label){
					child.setStyle("textFormat", tf);
				}
			}
			//
			
			//Set list component format
			view.gameObjectsTable.addColumn("ID");
			view.gameObjectsTable.addColumn("type");
			view.gameObjectsTable.minColumnWidth = 50;
		}
	}

}
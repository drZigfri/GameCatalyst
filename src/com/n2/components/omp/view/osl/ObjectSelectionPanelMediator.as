package com.n2.components.omp.view.osl {
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.library.events.LibraryEvent;
	import com.n2.components.omp.model.OMPModel;
	import com.n2.components.omp.view.events.ObjectSelectionPanelEvent;
	import com.n2.components.scene.events.SceneEvent;
	import fl.controls.Button;
	import fl.controls.Label;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectSelectionPanelMediator extends Mediator {
		[Inject]
		public var gameCatalystModel:GameCatalystModel;
		[Inject]
		public var view:ObjectSelectionPanel;
		[Inject]
		public var ompModel:OMPModel;
		
		private var _stageObjectsTableDP:DataProvider;
		
		public function ObjectSelectionPanelMediator(){
		}
		
		override public function onRegister():void {
			setupDataProviders();
			setupGUI();
			mapEvents();
		}
		
		private function mapEvents():void {
			//Map events
			eventMap.mapListener(view.buttonAddToStage, MouseEvent.CLICK, handleAddToStageClick, MouseEvent);
			eventMap.mapListener(view.buttonViewLibraryObjects, MouseEvent.CLICK, handleViewLibraryClick, MouseEvent);
			eventMap.mapListener(view.buttonViewSceneObjects, MouseEvent.CLICK, handleViewSceneObjectsClick, MouseEvent);
			eventMap.mapListener(view.sceneObjectsTable, ListEvent.ITEM_CLICK, handleSceneObjectSelected, ListEvent);
			
			eventMap.mapListener(eventDispatcher, LibraryEvent.LIBRARY_UPDATED, handleLibraryUpdated, LibraryEvent);
			eventMap.mapListener(eventDispatcher, SceneEvent.OBJECT_ADDED_TO_STAGE, handleObjectAddedToStage, SceneEvent);
			//
		}
		
		private function handleSceneObjectSelected(e:ListEvent):void {
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.OBJECT_SELECTED, e.item));
		}
		
		private function setupDataProviders():void {
			_stageObjectsTableDP = new DataProvider();
			view.sceneObjectsTable.dataProvider = _stageObjectsTableDP;
		}
		
		private function handleObjectAddedToStage(e:SceneEvent):void {
			_stageObjectsTableDP.addItem(e.gameObject);
		}
		
		private function handleLibraryUpdated(e:LibraryEvent):void {
			view.gameObjectsTable.dataProvider = gameCatalystModel.gameObjectsLibrary.getAllObjects();
		}
		
		private function handleAddToStageClick(e:MouseEvent):void {
			var item:Object = view.gameObjectsTable.selectedItem;
			item.sceneID = item.id + "_" + _stageObjectsTableDP.toArray().length;
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.ADD_OBJECT_TO_STAGE, item));
		}
		
		private function handleViewSceneObjectsClick(e:MouseEvent):void {
			view.gameObjectsTable.enabled = false;
			view.gameObjectsTable.visible = false;
			view.buttonAddToStage.visible = false;
			view.sceneObjectsTable.enabled = true;
			view.sceneObjectsTable.visible = true;
		}
		
		private function handleViewLibraryClick(e:MouseEvent):void {
			view.gameObjectsTable.enabled = true;
			view.gameObjectsTable.visible = true;
			view.buttonAddToStage.visible = true;
			view.sceneObjectsTable.enabled = false;
			view.sceneObjectsTable.visible = false;
		}
		
		private function setupGUI():void {
			//Set text fields format
			var tf:TextFormat = new TextFormat("Lucida Console", 10, 0x000000, false);
			
			for (var i:Number = 0; i < view.numChildren; i++){
				var child:* = view.getChildAt(i);
				if (child is Label || child is Button){
					child.setStyle("textFormat", tf);
				}
			}
			//
			
			//Set list component formats
			view.gameObjectsTable.addColumn("id");
			view.gameObjectsTable.addColumn("type");
			view.gameObjectsTable.minColumnWidth = 50;
			
			//Disable tables and add to stage button
			view.sceneObjectsTable.addColumn("sceneID");
			view.sceneObjectsTable.addColumn("type");
			view.sceneObjectsTable.minColumnWidth = 50;
			view.gameObjectsTable.enabled = false;
			view.gameObjectsTable.visible = false;
			view.buttonAddToStage.visible = false;
			view.sceneObjectsTable.enabled = false;
			view.sceneObjectsTable.visible = false;
		}
	}

}
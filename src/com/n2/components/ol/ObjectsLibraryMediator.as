package com.n2.components.ol {
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.library.events.LibraryEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.omp.view.osl.ObjectSelectionPanel;
	import com.n2.components.scene.events.SceneEvent;
	import com.n2.components.scene.model.SceneModel;
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
	public class ObjectsLibraryMediator extends Mediator {
		[Inject]
		public var gameCatalystModel:GameCatalystModel;
		[Inject]
		public var view:ObjectsLibrary;
		[Inject]
		public var sceneModel:SceneModel;
		
		private var _stageObjectsTableDP:DataProvider;
		
		override public function onRegister():void {
			setupGUI();
			setupDataProviders();
			mapEvents();
		}
		
		private function get objectSelectionPanel():ObjectSelectionPanel {
			return view.objectSelectionPanel;
		}
		
		private function mapEvents():void {
			//Map events
			eventMap.mapListener(objectSelectionPanel.buttonAddToStage, MouseEvent.CLICK, handleAddToStageClick, MouseEvent);
			eventMap.mapListener(objectSelectionPanel.buttonViewLibraryObjects, MouseEvent.CLICK, handleViewLibraryClick, MouseEvent);
			eventMap.mapListener(objectSelectionPanel.buttonViewSceneObjects, MouseEvent.CLICK, handleViewSceneObjectsClick, MouseEvent);
			eventMap.mapListener(objectSelectionPanel.sceneObjectsTable, ListEvent.ITEM_CLICK, handleSceneObjectSelected, ListEvent);
			
			eventMap.mapListener(eventDispatcher, LibraryEvent.LIBRARY_UPDATED, handleLibraryUpdated, LibraryEvent);
			//
		}
		
		private function handleSceneObjectSelected(e:ListEvent):void {
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.OBJECT_SELECTED, e.item));
		}
		
		private function setupDataProviders():void {
			_stageObjectsTableDP = new DataProvider();
			objectSelectionPanel.sceneObjectsTable.dataProvider = sceneModel.stageObjects;
			objectSelectionPanel.gameObjectsTable.dataProvider = gameCatalystModel.gameObjectsLibrary.getAllObjects();
		}
		
		private function handleLibraryUpdated(e:LibraryEvent):void {
			objectSelectionPanel.gameObjectsTable.dataProvider = gameCatalystModel.gameObjectsLibrary.getAllObjects();
		}
		
		private function handleAddToStageClick(e:MouseEvent):void {
			var item:Object = cloneObject(objectSelectionPanel.gameObjectsTable.selectedItem);
			
			item.sceneID = sceneModel.stageObjects.toArray().length + ". " + item.id;
			
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.ADD_OBJECT_TO_STAGE, item));
		}
		
		private function cloneObject(selectedItem:Object):Object {
			var ret:Object = { };
			for (var s:String in selectedItem) {
				ret[s] = selectedItem[s];
			}
			return ret;
		}
		
		private function handleViewSceneObjectsClick(e:MouseEvent):void {
			objectSelectionPanel.gameObjectsTable.enabled = false;
			objectSelectionPanel.gameObjectsTable.visible = false;
			objectSelectionPanel.buttonAddToStage.visible = false;
			objectSelectionPanel.sceneObjectsTable.enabled = true;
			objectSelectionPanel.sceneObjectsTable.visible = true;
		}
		
		private function handleViewLibraryClick(e:MouseEvent):void {
			objectSelectionPanel.gameObjectsTable.enabled = true;
			objectSelectionPanel.gameObjectsTable.visible = true;
			objectSelectionPanel.buttonAddToStage.visible = true;
			objectSelectionPanel.sceneObjectsTable.enabled = false;
			objectSelectionPanel.sceneObjectsTable.visible = false;
		}
		
		private function setupGUI():void {
			//Set text fields format
			var tf:TextFormat = new TextFormat("Lucida Console", 10, 0x000000, false);
			
			for (var i:Number = 0; i < objectSelectionPanel.numChildren; i++){
				var child:* = objectSelectionPanel.getChildAt(i);
				if (child is Label || child is Button){
					child.setStyle("textFormat", tf);
				}
			}
			//
			
			//Set list component formats
			objectSelectionPanel.gameObjectsTable.addColumn("id");
			objectSelectionPanel.gameObjectsTable.addColumn("type");
			objectSelectionPanel.gameObjectsTable.minColumnWidth = 50;
			
			//Disable tables and add to stage button
			objectSelectionPanel.sceneObjectsTable.addColumn("sceneID");
			objectSelectionPanel.sceneObjectsTable.addColumn("type");
			objectSelectionPanel.sceneObjectsTable.minColumnWidth = 50;
			objectSelectionPanel.gameObjectsTable.enabled = false;
			objectSelectionPanel.gameObjectsTable.visible = false;
			objectSelectionPanel.buttonAddToStage.visible = false;
			objectSelectionPanel.sceneObjectsTable.enabled = false;
			objectSelectionPanel.sceneObjectsTable.visible = false;
		}
	}

}
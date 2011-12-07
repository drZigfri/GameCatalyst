package com.n2.components.ol {
	import away3d.entities.Mesh;
	import away3d.library.assets.AssetType;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.services.library.events.LibraryEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.omp.view.osl.ObjectSelectionPanel;
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
	public class GameAssetsLibraryViewMediator extends Mediator {
		[Inject]
		public var catalystModel:IGameCatalystModel;
		[Inject]
		public var view:GameAssetsLibraryView;
		
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
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.OBJECT_SELECTED, e.item as Mesh));
		}
		
		private function setupDataProviders():void {
			_stageObjectsTableDP = new DataProvider();
			objectSelectionPanel.sceneObjectsTable.dataProvider = catalystModel.scene.stageObjects;
			objectSelectionPanel.gameObjectsTable.dataProvider = catalystModel.gameAssetsLibrary.getAllAssets();
		}
		
		private function handleLibraryUpdated(e:LibraryEvent):void {
			objectSelectionPanel.gameObjectsTable.dataProvider = catalystModel.gameAssetsLibrary.getAllAssets();
		}
		
		private function handleAddToStageClick(e:MouseEvent):void {
			var item:Object = cloneObject(objectSelectionPanel.gameObjectsTable.selectedItem);
			var gameObject:Mesh = getGameObject3D(item.id);
			
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.ADD_OBJECT_TO_STAGE, gameObject));
		}
		
		private function getGameObject3D(id:String):Mesh {
			var assets:Object = catalystModel.gameAssetsLibrary.getAssetByID(id).assets;
			var objectRepresentation:Mesh = new Mesh();
			
			objectRepresentation.name = catalystModel.scene.stageObjects.toArray().length + "_" + id;
			
			for (var i:int = 0; i < assets.length; i++){
				if (assets[i].assetType == AssetType.MESH){
					var msh:Mesh = assets[i].clone() as Mesh;
					msh.x = 0;
					msh.y = 0;
					msh.z = 0;
					msh.scale(1);
					msh.mouseEnabled = true;
					
					objectRepresentation.addChild(msh);
				}
			}
			
			return objectRepresentation;
		}
		
		private function cloneObject(selectedItem:Object):Object {
			var ret:Object = {};
			for (var s:String in selectedItem){
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
			objectSelectionPanel.sceneObjectsTable.addColumn("name");
			objectSelectionPanel.gameObjectsTable.enabled = false;
			objectSelectionPanel.gameObjectsTable.visible = false;
			objectSelectionPanel.sceneObjectsTable.enabled = false;
			objectSelectionPanel.buttonAddToStage.visible = false;
			objectSelectionPanel.sceneObjectsTable.visible = false;
		}
	}

}
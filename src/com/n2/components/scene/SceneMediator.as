package com.n2.components.scene {
	import away3d.containers.ObjectContainer3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.assets.AssetType;
	import away3d.lights.DirectionalLight;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.components.gop.events.ObjectControlPanelEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.scene.events.SceneEvent;
	import com.n2.components.scene.model.SceneModel;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneMediator extends Mediator {
		[Inject]
		public var model:SceneModel;
		[Inject]
		public var sceneView:SceneView;
		[Inject]
		public var gameCatalystModel:GameCatalystModel;
		
		public function SceneMediator(){
		}
		
		override public function onRegister():void {
			//Map events
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.ADD_OBJECT_TO_STAGE, handleAddObjectToStage, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.OBJECT_SELECTED, handleObjectSelected, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, handleObjectParamsUpdate, ObjectControlPanelEvent);
			
			//Initialize view
			sceneView.initialize();
		
			//TODO: Initialize camera controller
		}
		
		private function handleObjectSelected(e:ObjectSelectionPanelEvent):void {
			model.selectedStageObject = e.gameObject;
			sceneView.moveCameraToSelectedObject = true;
			sceneView.lookAtObject = e.gameObject.objectRepresentation;
		}
		
		private function handleAddObjectToStage(e:ObjectSelectionPanelEvent):void {
			var go:Object = e.gameObject;
			var assets:Object = gameCatalystModel.gameObjectsLibrary.getResourceByID(go.id).assets;
			var objectRepresentation:ObjectContainer3D = new ObjectContainer3D();
			
			for (var i:int = 0; i < assets.length; i++){
				if (assets[i].assetType == AssetType.MESH){
					var msh:Mesh = assets[i].clone() as Mesh;
					msh.x = 0;
					msh.y = 0;
					msh.z = 0;
					msh.scale(1);
					
					objectRepresentation.addChild(msh);
				}
			}
			
			go.objectRepresentation = objectRepresentation;
			
			model.stageObjects.addItem(go);
			
			sceneView.view.scene.addChild(objectRepresentation);
			dispatch(new SceneEvent(SceneEvent.OBJECT_ADDED_TO_STAGE));
		}
		
		private function handleObjectParamsUpdate(e:ObjectControlPanelEvent):void {
			var tt:String = e.transformType;
			var tp:String;
			
			if (tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_ROTATION || tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_SCALE){
				tp = e.targetProperty.toUpperCase();
				tt = tt.toLowerCase();
			} else if (tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_POSITION){
				tp = e.targetProperty.toLowerCase();
				tt = "";
			}
			
			//TODO: object manipulation code
			if (model.selectedStageObject != null){
				var objectRepresentation:ObjectContainer3D = model.selectedStageObject.objectRepresentation;
				objectRepresentation[tt + tp] = e.targetValue;
			}
		}
	}

}
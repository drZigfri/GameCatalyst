package com.n2.components.scene {
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.lights.DirectionalLight;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.components.library.events.AssetLoaderEvent;
	import com.n2.components.omp.view.events.ObjectControlPanelEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneMediator extends Mediator {
		[Inject]
		public var sceneView:SceneView;
		[Inject]
		public var gcModel:GameCatalystModel;
		
		public function SceneMediator(){
		}
		
		override public function onRegister():void {
			//Map events
			eventMap.mapListener(gcModel.gameObjectsLibrary, AssetEvent.ASSET_COMPLETE, handleAssetsLoaded, AssetEvent);
			eventMap.mapListener(eventDispatcher, ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, handleObjectParamsUpdate, ObjectControlPanelEvent);
			
			//Initialize view
			sceneView.initialize();
			
			//Initialize camera controller
			//camController.panAngle = 45;
			//camController.distance = 1000;
			//camController.targetObject = sceneView.view.camera;
		}
		
		private function handleObjectParamsUpdate(e:ObjectControlPanelEvent):void {
			var tt:String = e.transformType;
			var tp:String;
			
			if (tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_ROTATION || tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_SCALE) {
				tp = e.targetProperty.toUpperCase();
				tt = tt.toLowerCase();
			} else if (tt == ObjectControlPanelEvent.TRANSFORM_OBJECT_POSITION) {
				tp = e.targetProperty.toLowerCase();
				tt = "";
			}
			
			sceneView.plane[tt + tp] = e.targetValue;
		}
		
		private function handleAssetsLoaded(e:AssetEvent):void {
			trace("e.asset: " + e.asset);
			//TODO: Assets loaded handling
			var msh:Mesh;
			if (e.asset is Mesh) {
				msh = gcModel.gameObjectsLibrary.getGameObjectByID(e.assetPrevName).clone() as Mesh;
				
				sceneView.addMeshToScene(msh);
			}
		}
	
	}

}
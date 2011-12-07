package com.n2.components.scene {
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.MouseEvent3D;
	import away3d.library.assets.AssetType;
	import away3d.lights.DirectionalLight;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.services.camera.events.CameraControlEvent;
	import com.n2.components.gop.events.ObjectControlPanelEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.scene.events.SceneEvent;
	import com.n2.components.scene.interfaces.ISceneModel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneMediator extends Mediator {
		[Inject]
		public var model:ISceneModel;
		[Inject]
		public var sceneView:SceneView;
		[Inject]
		public var gameCatalystModel:IGameCatalystModel;
		
		private var _cameraController:HoverController;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _camera:Camera3D;
		private var _moveCameraToSelectedObject:Boolean;
		private var _moveCameraByMouse:Boolean;
		
		public function SceneMediator(){
		}
		
		override public function onRegister():void {
			//Initialize view
			initializeCamera();
			sceneView.initialize(_camera);
			
			//Map events
			mapEvents();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.ADD_OBJECT_TO_STAGE, handleAddObjectToStage, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.OBJECT_SELECTED, handleObjectSelected, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, ObjectControlPanelEvent.UPDATE_OBJECT_PARAMETERS, handleObjectParamsUpdate, ObjectControlPanelEvent);
			eventMap.mapListener(eventDispatcher, CameraControlEvent.SET_LOCK_ON_OBJECT, handleLockOnObject, ObjectControlPanelEvent);
			eventMap.mapListener(sceneView, Event.ENTER_FRAME, handleEnterFrame, Event);
			
			//TODO: Cleanup code
			//Setup mouse handling
			//_view.mouseEnabled = true;
			//_view.mouseChildren = true;
			view.addEventListener(MouseEvent.MOUSE_DOWN, handleStageMouseDown);
			view.addEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
		}
		
		private function initializeCamera():void {
			//TODO: Initialize camera controller
			_camera = new Camera3D();
			_cameraController = new HoverController(_camera, null, 45, 20, 500, 10);
			dispatch(new CameraControlEvent(CameraControlEvent.CAMERA_ADDED_TO_STAGE, _cameraController));
		}
		
		private function handleEnterFrame(e:Event):void {
			if (_moveCameraByMouse){
				_cameraController.panAngle = 0.3 * (view.mouseX - _lastMouseX) + _lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (view.mouseY - _lastMouseY) + _lastTiltAngle;
				
				_moveCameraToSelectedObject = false;
			} else if (_moveCameraToSelectedObject){
				//_cameraController.panAngle = 0.3 * 45;
				//_cameraController.tiltAngle = 0.3 * 45;
			}
			
			view.render();
		}
		
		private function handleLockOnObject(e:CameraControlEvent):void {
			if (Boolean(e.value) == true) {
				_cameraController.lookAtObject = model.selectedStageObject;
			} else {
				_cameraController.lookAtObject = null;
			}
		}
		
		private function handleStageMouseDown(e:MouseEvent):void {
			_lastMouseX = view.mouseX;
			_lastMouseY = view.mouseY;
			_lastPanAngle = _cameraController.panAngle;
			_lastTiltAngle = _cameraController.tiltAngle;
			view.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			_moveCameraByMouse = true;
		}
		
		private function handleStageMouseUp(e:MouseEvent):void {
			_moveCameraByMouse = false;
			view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void {
			_moveCameraByMouse = false;
			view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function handleObjectSelected(e:ObjectSelectionPanelEvent):void {
			_moveCameraToSelectedObject = true;
			_cameraController.lookAtObject = e.gameObject;
		}
		
		private function handleAddObjectToStage(e:ObjectSelectionPanelEvent):void {
			var go:Mesh = e.gameObject;
			//Add game object to list of stage objects
			model.stageObjects.addItem(go);
			
			//Add mouse click listener
			//mostly used for object selection
			go.addEventListener(MouseEvent3D.CLICK, handleStageObjectClick);
			go.addEventListener(MouseEvent3D.MOUSE_DOWN, handleStageObjectMouseDown);
			go.addEventListener(MouseEvent3D.MOUSE_UP, handleStageObjectMouseUp);
			
			//Add child to scene
			view.scene.addChild(go);
			
			dispatch(new SceneEvent(SceneEvent.OBJECT_ADDED_TO_STAGE));
		}
		
		private function handleStageObjectMouseUp(e:MouseEvent3D):void {
		}
		
		private function handleStageObjectMouseDown(e:MouseEvent3D):void {
		}
		
		private function handleStageObjectClick(e:MouseEvent3D):void {
			dispatch(new ObjectSelectionPanelEvent(ObjectSelectionPanelEvent.OBJECT_SELECTED, e.target as Mesh));
		}
		
		private function handleObjectParamsUpdate(e:ObjectControlPanelEvent):void {
			var transformationType:String = e.transformType;
			var transformationParameter:String;
			
			if (transformationType == ObjectControlPanelEvent.TRANSFORM_OBJECT_ROTATION || transformationType == ObjectControlPanelEvent.TRANSFORM_OBJECT_SCALE){
				transformationParameter = e.targetProperty.toUpperCase();
				transformationType = transformationType.toLowerCase();
			} else if (transformationType == ObjectControlPanelEvent.TRANSFORM_OBJECT_POSITION){
				transformationParameter = e.targetProperty.toLowerCase();
				transformationType = "";
			}
			
			if (model.selectedStageObject != null){
				var objectRepresentation:Mesh = model.selectedStageObject;
				objectRepresentation[transformationType + transformationParameter] = e.targetValue;
			}
		}
		
		private function get view():View3D {
			return sceneView.view;
		}
	}

}
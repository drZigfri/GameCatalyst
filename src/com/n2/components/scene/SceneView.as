package com.n2.components.scene {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Plane;
	import away3d.primitives.WireframeAxesGrid;
	import com.n2.components.scene.navigation.NavigationAxisView;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneView extends Sprite {
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		private var _view:View3D;
		private var _navigationAxis:NavigationAxisView;
		private var _planeWireframe:WireframeAxesGrid;
		
		private var _cameraController:HoverController;
		private var _moveCameraByMouse:Boolean = false;
		private var _moveCameraToSelectedObject:Boolean = false;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		
		public function SceneView(){
		}
		
		public function initialize():void {
			initEngine();
		}
		
		private function initEngine():void {
			_scene = new Scene3D();
			_camera = new Camera3D();
			_view = new View3D(_scene, _camera);
			_cameraController = new HoverController(_camera, null, 45, 20, 200, 10);
			_navigationAxis = new NavigationAxisView();
			_planeWireframe = new WireframeAxesGrid(30, 2000);
			
			var stats:AwayStats = new AwayStats(_view);
			
			//Setup navigation components
			_navigationAxis.x = 0;
			_navigationAxis.y = 0;
			_navigationAxis.z = 0;
			//
			_camera.x = 0;
			_camera.y = 0;
			_camera.z = 0;
			_camera.lens.far = 10000;
			
			_view.width = 990;
			_view.height = 745;
			_view.antiAlias = 4;
			
			_view.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_view.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_view.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			
			stats.x = _view.width - stats.width;
			
			addChild(_view);
			addChild(stats);
			
			_view.camera.rotationY = 45;
			_view.scene.addChild(_planeWireframe);
			_view.scene.addChild(_navigationAxis);
		}
		
		private function handleMouseUp(e:MouseEvent):void {
			_moveCameraByMouse = false;
			_view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function handleMouseDown(e:MouseEvent):void {
			lastMouseX = _view.mouseX;
			lastMouseY = _view.mouseY;
			lastPanAngle = _cameraController.panAngle;
			lastTiltAngle = _cameraController.tiltAngle;
			_view.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			_moveCameraByMouse = true;
		}
		
		private function onStageMouseLeave(event:Event):void {
			_moveCameraByMouse = false;
			_view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function handleEnterFrame(e:Event):void {
			//TODO: Move camera controller to mediator
			if (_moveCameraByMouse){
				_cameraController.panAngle = 0.3 * (_view.mouseX - lastMouseX) + lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_view.mouseY - lastMouseY) + lastTiltAngle;
				
				moveCameraToSelectedObject = false;
			} else if (moveCameraToSelectedObject){
				_cameraController.panAngle = 0.3 * lastPanAngle;
				_cameraController.tiltAngle = 0.3 * lastTiltAngle;
			}
			_view.render();
		}
		
		public function addMeshToScene(msh:Mesh):void {
		}
		
		public function get view():View3D {
			return _view;
		}
		
		public function get moveCameraToSelectedObject():Boolean {
			return _moveCameraToSelectedObject;
		}
		
		public function set moveCameraToSelectedObject(value:Boolean):void {
			_moveCameraToSelectedObject = value;
		}
		
		public function set lookAtObject(value:ObjectContainer3D):void {
			_cameraController.lookAtObject = value;
		}
	}

}
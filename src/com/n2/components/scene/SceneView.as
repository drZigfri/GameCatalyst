package com.n2.components.scene {
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.Plane;
	import away3d.textures.BitmapTexture;
	import away3d.textures.Texture2DBase;
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
		private var _cameraController:HoverController;
		
		private var move:Boolean = false;
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
			_cameraController = new HoverController(_camera, null, 45, 20, 1000, 10);
			
			_camera.x = 0;
			_camera.y = 0;
			_camera.z = 0;
			_camera.lens.far = 10000;
			
			_view.width = 640;
			_view.height = 480;
			_view.antiAlias = 4;
			
			_view.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_view.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_view.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			
			addChild(_view);
			addChild(new AwayStats(_view));
			
			_view.camera.rotationY = 45;
		}
		
		private function handleMouseUp(e:MouseEvent):void {
			move = false;
			_view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function handleMouseDown(e:MouseEvent):void {
			lastMouseX = _view.mouseX;
			lastMouseY = _view.mouseY;
			lastPanAngle = _cameraController.panAngle;
			lastTiltAngle = _cameraController.tiltAngle;
			_view.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
			move = true;
		}
		
		private function onStageMouseLeave(event:Event):void {
			move = false;
			_view.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function handleEnterFrame(e:Event):void {
			//TODO: Move camera controller to mediator
			if (move){
				_cameraController.panAngle = 0.3 * (_view.mouseX - lastMouseX) + lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_view.mouseY - lastMouseY) + lastTiltAngle;
			}
			_view.render();
		}
		
		public function addMeshToScene(msh:Mesh):void {
		}
		
		public function get view():View3D {
			return _view;
		}
	}

}
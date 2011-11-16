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
		
		[Embed(source="../../../../../lib/assets/rockbase.jpg")]
		private var Albedo:Class;
		[Embed(source="../../../../../lib/assets/rockbase_local.png")]
		private var Normals:Class;
		
		private var _albedo:BitmapData = new Albedo().bitmapData;
		private var _normals:BitmapData = new Normals().bitmapData;
		private var _light:PointLight;
		private var _referenceMaterial:TextureMaterial
		private var _referenceAsset:Mesh;
		private var _numMeshes:uint = 0;
		private var _maxMeshes:uint = 120;
		private var _cameraController:HoverController;
		private var move:Boolean = false;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		public var plane:Mesh;
		private var meshTemplates:Object;
		
		public function SceneView(){
			trace("SceneView");
		}
		
		public function initialize():void {
			initEngine();
		}
		
		private function initEngine():void {
			this.mouseChildren = true;
			_scene = new Scene3D();
			_camera = new Camera3D();
			_view = new View3D(_scene, _camera);
			_light = new PointLight();
			_cameraController = new HoverController(_camera, null, 45, 20, 1000, 10);
			_view.mouseChildren = true;
			
			_camera.x = 0;
			_camera.y = 0;
			_camera.z = 0;
			_camera.lens.far = 10000;
			
			_referenceAsset = new Plane(createMaterial());
			
			_view.width = 640;
			_view.height = 480;
			
			_view.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_view.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_view.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			
			addChild(_view);
			addChild(new AwayStats(_view));
			
			plane = createPlane();
			plane.x = 10;
			plane.y = 10;
			plane.z = 10;
			plane.rotationX = 45;
			plane.rotationY = 67;
			plane.rotationZ = 18;
			plane.scale(10);
			
			_view.camera.rotationY = 45;
			
			_view.scene.addChild(_light);
			_view.scene.addChild(plane);
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
		
		private function createMaterial():TextureMaterial {
			var material:TextureMaterial = new TextureMaterial(new BitmapTexture(_albedo));
			//material.normalMap = _normals;
			material.bothSides = true;
			//material.lights = [_light];
			return material;
		}
		
		private function createPlane():Mesh {
			return _referenceAsset.clone() as Mesh;
		}
		
		private function createMeshes():void {
			var mesh:Mesh;
			var i:uint;
			
			while (i++ < 10 && _numMeshes < _maxMeshes){
				++_numMeshes;
				var randx : Number = Math.random() * 1000 - 500;
				var randy : Number = Math.random() * 1000 - 500;
				var randz : Number = Math.random() * 1000 - 500;
				var randrx : Number = Math.random() * 360;
				var randrz : Number = Math.random() * 360;
				
				for (var s : String in meshTemplates) {
					if (s != "Box001") {
						mesh = meshTemplates[s].clone() as Mesh;
						mesh.x = randx;
						mesh.y = randy;
						mesh.z = randz;
						mesh.rotationX = randrx;
						mesh.rotationZ = randrz;
						_view.scene.addChild(mesh);
					}
				}
			}
		}
		
		private function handleEnterFrame(e:Event):void {
			//trace("_camera.rotationY: " + _camera.rotationY);
			if (move){
				_cameraController.panAngle = 0.3 * (_view.mouseX - lastMouseX) + lastPanAngle;
				_cameraController.tiltAngle = 0.3 * (_view.mouseY - lastMouseY) + lastTiltAngle;
			}
			if (meshTemplates != null)
				createMeshes();
			_view.render();
		}
		
		public function addMeshToScene(msh:Mesh):void {
			trace("msh.name: " + msh.name);
			if (meshTemplates == null) meshTemplates = { };
			meshTemplates[msh.name] = msh;
			//_view.scene.addChild(msh);
		}
		
		public function get view():View3D {
			return _view;
		}
	}

}
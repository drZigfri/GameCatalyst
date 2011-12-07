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
		private var _view:View3D;
		private var _navigationAxis:NavigationAxisView;
		private var _planeWireframe:WireframeAxesGrid;
		
		private var _moveCameraByMouse:Boolean = false;
		private var _moveCameraToSelectedObject:Boolean = false;
		
		public function initialize(cam:Camera3D):void {
			_scene = new Scene3D();
			_view = new View3D(_scene, cam);
			_navigationAxis = new NavigationAxisView();
			_planeWireframe = new WireframeAxesGrid(30, 2000);
			
			var stats:AwayStats = new AwayStats(_view);
			
			//Set view size
			_view.width = 990;
			_view.height = 745;
			
			//Setup view components
			_navigationAxis.x = 0;
			_navigationAxis.y = 0;
			_navigationAxis.z = 0;
			
			stats.x = _view.width - stats.width;
			
			cam.x = 0;
			cam.y = 0;
			cam.z = 0;
			cam.lens.far = 15000;
			//
			
			_view.antiAlias = 4;
			
			addChild(_view);
			addChild(stats);
			
			//_view.camera.rotationY = 45;
			_view.scene.addChild(_planeWireframe);
			_view.scene.addChild(_navigationAxis);
		}
		
		public function addMeshToScene(msh:Mesh):void {
		}
		
		public function get view():View3D {
			return _view;
		}
	}

}
package com.n2.components.scene.model {
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.services.camera.events.CameraControlEvent;
	import com.n2.components.ol.events.ObjectSelectionPanelEvent;
	import com.n2.components.scene.interfaces.ISceneModel;
	import fl.data.DataProvider;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneModel extends Actor implements ISceneModel, ICatalystService {
		private var _selectedStageObject:Mesh;
		private var _stageObjects:DataProvider;
		private var _cameras:Vector.<HoverController>;
		
		public function SceneModel(){
		}
		
		public function initialize():void {
			_stageObjects = new DataProvider();
			mapEvents();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, ObjectSelectionPanelEvent.OBJECT_SELECTED, handleObjectSelected, ObjectSelectionPanelEvent);
			eventMap.mapListener(eventDispatcher, CameraControlEvent.CAMERA_ADDED_TO_STAGE, handleCameraAddedToStage, CameraControlEvent);
		}
		
		private function handleCameraAddedToStage(e:CameraControlEvent):void {
			if (_cameras == null)
				_cameras = new Vector.<HoverController>();
			
			_cameras.push(e.value as HoverController);
		}
		
		private function handleObjectSelected(e:ObjectSelectionPanelEvent):void {
			_selectedStageObject = e.gameObject;
		}
		
		public function get selectedStageObject():Mesh {
			return _selectedStageObject;
		}
		
		public function get stageObjects():DataProvider {
			return _stageObjects;
		}
		
		public function get cameras():Vector.<HoverController> {
			return _cameras;
		}
	
	}

}
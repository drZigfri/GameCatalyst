package com.n2.apps.catalyst.model.services.camera {
	import away3d.cameras.Camera3D;
	import away3d.controllers.HoverController;
	import com.n2.apps.catalyst.model.interfaces.ICameraControl;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.services.camera.events.CameraControlEvent;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class CameraControl extends Actor implements ICameraControl, ICatalystService {
		private var _selectedCamera:uint;
		private var _cameras:Vector.<HoverController>;
		private var _lockOnObject:Boolean;
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystService */
		
		public function initialize():void {
			mapEvents();
		}
		
		//
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, CameraControlEvent.SET_LOCK_ON_OBJECT, handleSetLockOnObject, CameraControlEvent);
			eventMap.mapListener(eventDispatcher, CameraControlEvent.SET_DISTANCE_FROM_OBJECT, handleSetDistanceFromObject, CameraControlEvent);
			eventMap.mapListener(eventDispatcher, CameraControlEvent.CAMERA_ADDED_TO_STAGE, handleCameraAddedToStage, CameraControlEvent);
		}
		
		private function handleSetDistanceFromObject(e:CameraControlEvent):void {
			if(_cameras[0])
				_cameras[0].distance = e.value as Number;
		}
		
		private function handleCameraAddedToStage(e:CameraControlEvent):void {
			if (_cameras == null)
				_cameras = new Vector.<HoverController>();
			_cameras.push(e.value as HoverController);
		}
		
		private function handleSetLockOnObject(e:CameraControlEvent):void {
			//TODO: Setting of 
			_lockOnObject = e.value;
		}
		
		public function get lockOnObject():Boolean {
			return _lockOnObject;
		}
		
		public function get distanceFromObject():Number {
			return _cameras[0].distance;
		}
	
	}

}
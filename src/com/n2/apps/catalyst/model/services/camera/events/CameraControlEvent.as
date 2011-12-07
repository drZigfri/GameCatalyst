package com.n2.apps.catalyst.model.services.camera.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class CameraControlEvent extends Event {
		public static const SET_LOCK_ON_OBJECT:String = "setLockOnObject";
		public static const CAMERA_ADDED_TO_STAGE:String = "cameraAddedToStage";
		public static const SET_DISTANCE_FROM_OBJECT:String = "setDistanceFromObject";
		
		private var _value:*;
		
		public function CameraControlEvent(type:String, val:*){
			super(type);
			_value = val;
		}
		
		public function get value():* {
			return _value;
		}
	
	}

}
package com.n2.components.scene.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneEvent extends Event {
		public static const OBJECT_ADDED_TO_STAGE:String = "event_objectAddeddToStage";
		
		private var _gameObject:Object;
		/**
		 * 
		 * @param	type - Event type
		 * @param	go - Game object
		 */
		public function SceneEvent(type:String, go:Object){
			super(type);
			_gameObject = go;
		}
		
		public function get gameObject():Object {
			return _gameObject;
		}
	
	}

}
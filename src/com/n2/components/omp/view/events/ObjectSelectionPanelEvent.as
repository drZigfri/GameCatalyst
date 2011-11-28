package com.n2.components.omp.view.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectSelectionPanelEvent extends Event {
		public static const ADD_OBJECT_TO_STAGE:String = "event_addObjectToStage";
		public static const OBJECT_SELECTED:String = "event_objectSelected";
		
		private var _gameObject:*;
		
		/**
		 * @param type - Event type
		 * @param go - Game object
		 */
		public function ObjectSelectionPanelEvent(type:String, go:Object){
			super(type);
			_gameObject = go;
		}
		
		public function get gameObject():Object {
			return _gameObject;
		}
	
	}

}
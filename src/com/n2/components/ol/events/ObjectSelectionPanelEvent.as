package com.n2.components.ol.events {
	import away3d.entities.Mesh;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectSelectionPanelEvent extends Event {
		public static const ADD_OBJECT_TO_STAGE:String = "event_addObjectToStage";
		public static const OBJECT_SELECTED:String = "event_objectSelected";
		
		private var _gameObject:Mesh;
		
		/**
		 * @param type - Event type
		 * @param go - Game object
		 */
		public function ObjectSelectionPanelEvent(type:String, go:Mesh){
			super(type);
			_gameObject = go;
		}
		
		public function get gameObject():Mesh {
			return _gameObject;
		}
	
	}

}
package com.n2.apps.catalyst.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GCComponentEvent extends Event {
		public static var CREATE_COMPONENT:String = "event_createComponent";
		
		private var _componentType:String;
		/**
		 * 
		 * @param	type - Type of event
		 * @param	comp - Component Class
		 */
		public function GCComponentEvent(type:String, comp:String){
			super(type);
			_componentType = comp;
		}
		
		public function get componentType():String {
			return _componentType;
		}
	
	}

}
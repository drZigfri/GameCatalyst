package com.n2.apps.gc.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ContextEventGC extends Event {
		public static const VIEW_INITIALIZATION_BEGIN:String = "event_contextViewInitializationBegin";
		public static const VIEW_INITIALIZATION_END:String = "event_contextViewInitializationEnd";
		
		public function ContextEventGC(type:String){
			super(type);
		}
		
		override public function clone():Event {
			return new ContextEventGC(type);
		}
	}

}
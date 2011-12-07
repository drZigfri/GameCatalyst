package com.n2.apps.catalyst.model.services.library.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LibraryEvent extends Event {
		public static const LIBRARY_UPDATED:String = "event_libraryUpdated";
		public static const RESOURCE_LOADED:String = "event_libraryResourceLoaded";
		
		private var _value:*;
		
		public function LibraryEvent(type:String, val:* = null){
			super(type);
			_value= val;
		}
		
		override public function clone():Event {
			return new LibraryEvent(type);
		}
		
		public function get value():* {
			return _value;
		}
	}

}
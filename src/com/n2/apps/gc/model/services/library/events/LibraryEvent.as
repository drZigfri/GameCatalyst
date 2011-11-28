package com.n2.apps.gc.model.services.library.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LibraryEvent extends Event {
		public static const LIBRARY_UPDATED:String = "event_libraryUpdated";
		public static const RESOURCE_LOADED:String = "event_libraryResourceLoaded";
		
		public function LibraryEvent(type:String){
			super(type);
		}
		
		override public function clone():Event {
			return new LibraryEvent(type);
		}
	}

}
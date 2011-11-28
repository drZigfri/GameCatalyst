package com.n2.apps.gc.model.services.loader.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ComponentLoaderEvent extends Event {
		public static const COMPONENTS_LOADED:String = "event_componentsLoaded";
		public static const CONFIG_LOADED:String = "event_configLoaded";
		
		public function ComponentLoaderEvent(type:String){
			super(type);
		}
	
	}

}
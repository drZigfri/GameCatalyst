package com.n2.components.library.events {
	import away3d.events.AssetEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class AssetLoaderEvent extends Event {
		public static const LOAD_ASSETS_START:String = "event_loadAssetsBegin";
		public static const LOAD_ASSETS_END:String = "event_loadAssetsEnd";
		
		public function AssetLoaderEvent(type:String){
			super(type);
		}
		
		override public function clone():Event {
			return new AssetLoaderEvent(type);
		}
	}

}
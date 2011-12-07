package com.n2.apps.catalyst.events {
	import away3d.events.AssetEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class AssetLoaderEvent extends Event {
		public static const OBJECTS_DESCRIPTOR_UPDATED:String = "objectsDescriptorUpdated";
		public static const ASSETS_DESCRIPTOR_UPDATED:String = "assetsDescriptorUpdated";
		public static const LOAD_ASSETS_START:String = "loadAssetsBegin";
		public static const LOAD_ASSETS_END:String = "loadAssetsEnd";
		
		private var _data:*;
		
		public function AssetLoaderEvent(type:String, dt:* = null){
			super(type);
			_data = dt;
		}
		
		override public function clone():Event {
			return new AssetLoaderEvent(type);
		}
		
		public function get data():* {
			return _data;
		}
	}

}
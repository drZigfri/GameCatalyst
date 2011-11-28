package com.n2.apps.gc.model.services.loader.events {
	import com.n2.apps.gc.model.services.loader.queue.LoaderQueueItem;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class QueueEvent extends Event {
		public static const ITEM_LOADED:String = "event_queueItemLoaded";
		public static const QUEUE_LOADING_COMPLETE:String = "event_queueLoadingComplete";
		
		private var _item:LoaderQueueItem;
		
		public function QueueEvent(type:String, itm:LoaderQueueItem = null){
			_item = itm;
			super(type);
		}
		
		public function get item():LoaderQueueItem {
			return _item;
		}
		
		override public function clone():Event {
			return new QueueEvent(type, _item);
		}
	
	}

}
package com.n2.apps.catalyst.model.services.loader.queue {
	import com.n2.apps.catalyst.model.services.loader.events.QueueEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LoaderQueue extends Actor {
		private var _queue:Vector.<LoaderQueueItem>
		
		public function LoaderQueue(){
			_queue = new Vector.<LoaderQueueItem>;
		}
		
		public function addItemToQueueBegining(item:LoaderQueueItem):void {
			_queue.unshift(item);
		}
		
		public function addItemToQueueEnd(item:LoaderQueueItem):void {
			_queue.push(item);
		}
		
		private function handleItemLoaded(e:QueueEvent):void {
			if (e.item == _queue[0]) {
				e.target.removeEventListener(QueueEvent.ITEM_LOADED, handleItemLoaded);
				dispatch(e.clone());
				
				_queue.shift();
				
				//Load next item if available
				if (_queue.length > 0) {
					loadNextItem();
				} else {
					dispatch(new QueueEvent(QueueEvent.QUEUE_LOADING_COMPLETE));
				}
			} else {
				//TODO: Queue wrong item
			}
		}
		
		private function loadNextItem():void {
			_queue[0].addEventListener(QueueEvent.ITEM_LOADED, handleItemLoaded);
			_queue[0].execute();
		}
		
		public function startLoading():void {
			loadNextItem();
		}
	}
}
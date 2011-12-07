package com.n2.apps.catalyst.model.services.loader.queue {
	import com.n2.apps.catalyst.model.services.loader.ComponentDefinitions;
	import com.n2.apps.catalyst.model.services.loader.events.QueueEvent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LoaderQueueItem extends EventDispatcher {
		private var _loadedItem:*;
		private var _loader:Object;
		
		private var _itemID:String;
		private var _itemPath:String;
		private var _itemType:String;
		
		/*
		 * @param type - Only following values possible:
		 * 	ComponentDefinitions.TXT_COMPONENT
		 * 	ComponentDefinitions.XML_COMPONENT
		 * 	ComponentDefinitions.OBJ_COMPONENT
		 * 	ComponentDefinitions.SWF_COMPONENT
		 * 	ComponentDefinitions.IMG_COMPONENT
		 */
		public function LoaderQueueItem(type:String, path:String, id:String = null){
			_itemType = type;
			_itemPath = path;
			_itemID = id;
			
			setupLoader();
		}
		
		public function execute():void {
			var request:URLRequest = new URLRequest(_itemPath);
			_loader.load(request);
		}
		
		public function get loadedItem():* {
			return _loadedItem;
		}
		
		public function get itemID():String {
			return _itemID;
		}
		
		private function setupLoader():void {
			switch (_itemType){
				case ComponentDefinitions.TXT_COMPONENT: 
				case ComponentDefinitions.XML_COMPONENT: 
					_loader = new URLLoader();
					_loader.dataFormat = URLLoaderDataFormat.TEXT;
					_loader.addEventListener(Event.COMPLETE, handleTextLoaded);
					break;
				
				case ComponentDefinitions.IMG_COMPONENT: 
				case ComponentDefinitions.SWF_COMPONENT: 
				case ComponentDefinitions.OBJ_COMPONENT: 
					_loader = new Loader();
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleObjectLoaded);
					break;
				
				default:
					break;
			}
		}
		
		private function handleObjectLoaded(e:Event):void {
			_loadedItem = e.target.content;
			dispatchEvent(new QueueEvent(QueueEvent.ITEM_LOADED, this));
		}
		
		private function handleTextLoaded(e:Event):void {
			_loadedItem = e.target.data;
			dispatchEvent(new QueueEvent(QueueEvent.ITEM_LOADED, this));
		}
	}

}
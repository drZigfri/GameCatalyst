package com.n2.apps.gc.model.services.loader {
	import com.n2.apps.gc.model.services.loader.events.ComponentLoaderEvent;
	import com.n2.apps.gc.model.services.loader.events.QueueEvent;
	import com.n2.apps.gc.model.services.loader.queue.LoaderQueue;
	import com.n2.apps.gc.model.services.loader.queue.LoaderQueueItem;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ComponentLoader extends Actor {
		[Inject]
		public var _loadQueue:LoaderQueue;
		
		private var _componentsDescriptor:Array;
		private var _loadedObjects:Object;
		
		public function loadConfig():void {
			var descriptorLoader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("components_descriptor.xml");
			
			descriptorLoader.dataFormat = URLLoaderDataFormat.TEXT;
			descriptorLoader.addEventListener(Event.COMPLETE, handleDescriptorLoaded);
			
			descriptorLoader.load(request);
		}
		
		public function getLoadedObjectByID(id:String):* {
			if (_loadedObjects)
				return _loadedObjects[id];
			return null;
		}
		
		private function startLoadingComponents():void {
			setupLoaderQueue();
			_loadQueue.startLoading();
		}
		
		private function createQueueItems():void {
			for each (var pkg:Object in _componentsDescriptor){
				for (var i:int = 0; i < pkg.components.length; i++){
					var citem:Object = pkg.components[i];
					var qitem:LoaderQueueItem = new LoaderQueueItem(citem.type, citem.path, citem.id);
					
					_loadQueue.addItemToQueueEnd(qitem);
				}
			}
		}
		
		private function setupLoaderQueue():void {
			eventMap.mapListener(eventDispatcher, QueueEvent.ITEM_LOADED, handleQueueItemComplete, QueueEvent);
			eventMap.mapListener(eventDispatcher, QueueEvent.QUEUE_LOADING_COMPLETE, handleQueueLoadingComplete, QueueEvent);
			
			createQueueItems();
		}
		
		private function parseDescriptorData(desc:XML):Array {
			var descData:Array = new Array();
			var packages:XMLList = desc.child("componentPackage");
			
			for each (var pkg:XML in packages){
				var packageObject:Object = {};
				
				packageObject.id = pkg.attribute("id");
				packageObject.order = Number(pkg.attribute("order"));
				packageObject.components = parsePackageData(pkg.child("component"));
				
				descData.push(packageObject);
			}
			
			descData.sortOn("id");
			
			return descData;
		}
		
		private function parsePackageData(componentsList:XMLList):Array {
			var components:Array = new Array();
			
			for each (var cmp:XML in componentsList){
				var component:Object = {};
				
				component.id = cmp.attribute("id");
				component.order = Number(cmp.attribute("order"));
				component.type = cmp.attribute("type");
				component.path = cmp.attribute("path");
				
				components.push(component);
			}
			
			components.sortOn("id");
			
			return components;
		}
		
		private function handleDescriptorLoaded(e:Event):void {
			var desc:XML = new XML(e.target.data);
			
			_componentsDescriptor = parseDescriptorData(desc);
			
			startLoadingComponents();
		}
		
		private function handleQueueItemComplete(e:QueueEvent):void {
			if (_loadedObjects == null) _loadedObjects = { };
			_loadedObjects[e.item.itemID] = e.item.loadedItem;
		}
		
		private function handleQueueLoadingComplete(e:QueueEvent):void {
			dispatch(new ComponentLoaderEvent(ComponentLoaderEvent.COMPONENTS_LOADED));
		}
	
	}

}
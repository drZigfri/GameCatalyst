package com.n2.apps.gc.model.services.library {
	import away3d.containers.Scene3D;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Parsers;
	import com.n2.apps.gc.model.interfaces.IGameAssets;
	import com.n2.apps.gc.model.services.library.events.LibraryEvent;
	import com.n2.common.games.IGameObject;
	import fl.data.DataProvider;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectsLibrary extends Actor {
		private var _scene:Scene3D;
		
		private var _gameResources:IGameAssets;
		private var _assetsDescriptor:Object;
		private var _assetMap:Object;
		//Vars used for resource loading
		private var _loadingQueue:Vector.<String>;
		
		public function GameObjectsLibrary() {
		}
		
		/* INTERFACE com.n2.components.library.IGameObjectsLibrary */
		
		public function initialize():void {
		}
		
		private function loadNextResource():void {
			if (_loadingQueue.length > 0){
				var queueItem:String = _loadingQueue[0];
				var ldr:Loader3D = new Loader3D();
				var ldrContext:AssetLoaderContext = new AssetLoaderContext();
				var resAsset:Class = _gameResources.getAssetByID(_assetsDescriptor[queueItem].classPath);
				var resSkin:Class = _gameResources.getAssetByID(_assetsDescriptor[queueItem].texturePaths[0]);
				//Setup parser to be used on loader3D
				Parsers.enableAllBundled();
				
				ldrContext.mapUrlToData(_assetsDescriptor[queueItem].textureIDs[0], new resSkin());
				ldr.addEventListener(LoaderEvent.RESOURCE_COMPLETE, handleResourceComplete);
				ldr.addEventListener(AssetEvent.ASSET_COMPLETE, handleAssetComplete);
				
				ldr.loadData(new resAsset(), ldrContext);
			} else {
				//trace("asset map: " + _assetMap.player);
				handleResourcesLoaded();
			}
		}
		
		private function setupQueue():void {
			//
			_scene = new Scene3D();
			
			if (_assetMap == null)
				_assetMap = {};
			if (_loadingQueue == null)
				_loadingQueue = new Vector.<String>();
			
			for each (var item:*in _assetsDescriptor){
				_loadingQueue.push(item.id);
			}
			
			loadNextResource();
		}
		
		private function handleResourcesLoaded():void {
			dispatch(new LibraryEvent(LibraryEvent.LIBRARY_UPDATED));
		}
		
		private function handleAssetComplete(e:AssetEvent):void {
			var currentQueueItem:String = _loadingQueue[0];
			
			if (_assetMap[currentQueueItem] == null){
				_assetMap[currentQueueItem] = {};
				_assetMap[currentQueueItem].assets = new Array();
			}
			_assetMap[currentQueueItem].assets.push(e.asset);
			
			if (e.asset.assetType == AssetType.MESH)
				_scene.addChild(e.asset as Mesh);
		}
		
		private function handleResourceComplete(e:LoaderEvent):void {
			_loadingQueue.shift();
			
			loadNextResource();
		}
		
		public function getAllObjects():DataProvider {
			var allObjects:DataProvider = new DataProvider();
			
			for each (var item:*in _assetsDescriptor){
				allObjects.addItem(item);
			}
			return allObjects;
		}
		
		public function getGameObjectByID(id:String):* {
			return _assetsDescriptor[id];
		}
		
		public function getGameObjectsByType(type:String):IGameObject {
			return null;
		}
		
		/* INTERFACE com.n2.apps.gc.model.interfaces.IGameObjectsLibrary */
		
		public function getResourceByID(id:String):Object {
			return _assetMap[id];
		}
		
		public function get assetsDescriptor():Object {
			return _assetsDescriptor;
		}
		
		public function set assetsDescriptor(value:Object):void {
			_assetsDescriptor = value;
			
			setupQueue();
		}
		
		public function get gameResources():IGameAssets {
			return _gameResources;
		}
		
		public function set gameResources(value:IGameAssets):void {
			_gameResources = value;
		}
	
	}

}
package com.n2.apps.catalyst.model.services.library {
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
	import com.n2.apps.catalyst.events.AssetLoaderEvent;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.interfaces.IGameAssetsLibrary;
	import com.n2.apps.catalyst.model.services.library.events.LibraryEvent;
	import com.n2.common.games.objects.IGameObject;
	import fl.data.DataProvider;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameAssetsLibrary extends Actor implements IGameAssetsLibrary, ICatalystService {
		//TODO: Cleanup game objects library
		private var _scene:Scene3D;
		private var _assetsDescriptor:Object;
		private var _assetMap:Object;
		//Vars used for resource loading
		private var _loadingQueue:Vector.<String>;
		
		public function GameAssetsLibrary(){
		}
		
		private function loadNextResource():void {
			if (_loadingQueue.length > 0){
				var queueItem:String = _loadingQueue[0];
				var ldr:Loader3D = new Loader3D();
				var ldrContext:AssetLoaderContext = new AssetLoaderContext();
				var resAsset:String = _assetsDescriptor[queueItem].assetPath;
				
				//Setup parser to be used on loader3D
				Parsers.enableAllBundled();
				
				ldr.addEventListener(LoaderEvent.RESOURCE_COMPLETE, handleResourceComplete);
				ldr.addEventListener(AssetEvent.ASSET_COMPLETE, handleAssetComplete);
				
				var req:URLRequest = new URLRequest(resAsset);
				
				ldr.load(req, ldrContext);
			} else {
				handleResourcesLoaded();
			}
		}
		
		private function setupQueue():void {
			//
			if (_scene == null)
				_scene = new Scene3D();
			
			if (_assetMap == null)
				_assetMap = {};
			if (_loadingQueue == null)
				_loadingQueue = new Vector.<String>();
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
		
		private function handleAssetsDescriptorParsed(e:AssetLoaderEvent):void {
			_assetsDescriptor = e.data;
			
			if (_assetsDescriptor != null){
				for each (var item:*in _assetsDescriptor){
					_loadingQueue.push(item.id);
				}
			}
			
			loadNextResource();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, AssetLoaderEvent.ASSETS_DESCRIPTOR_UPDATED, handleAssetsDescriptorParsed, AssetLoaderEvent);
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystService */
		
		public function initialize():void {
			setupQueue();
			mapEvents();
			loadNextResource();
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.IGameAssetsLibrary */
		
		public function getAssetByID(id:String):* {
			return _assetMap[id];
		}
		
		public function getAllAssets():DataProvider {
			var allObjects:DataProvider = new DataProvider();
			
			for (var s:String in _assetsDescriptor){
				allObjects.addItem(_assetsDescriptor[s]);
			}
			return allObjects;
		
		}
	
	}

}
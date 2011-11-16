package com.n2.components.library {
	import away3d.events.AssetEvent;
	import away3d.library.AssetLibrary;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Parsers;
	import com.n2.common.games.IGameObject;
	import com.n2.components.library.events.AssetLoaderEvent;
	import com.n2.components.library.interfaces.IGameObjectsLibrary;
	import flash.events.EventDispatcher;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectsLibrary extends EventDispatcher implements IGameObjectsLibrary {
		private var _gameAssets:GameAssets;
		private var _loadedAssets:Object;
		
		public function GameObjectsLibrary(){
		}
		
		/* INTERFACE com.n2.components.library.IGameObjectsLibrary */
		
		public function initialize():void {
			_gameAssets = new GameAssets();
			_loadedAssets = { };
		}
		
		public function loadAssets():void {
			//setup parser to be used on loader3D
			Parsers.enableAllBundled();
			
			var loaderBox:Loader3D = new Loader3D();
			var loaderPlayer:Loader3D = new Loader3D();
			var loaderContextBox:AssetLoaderContext = new AssetLoaderContext();
			var loaderContextPlayer:AssetLoaderContext = new AssetLoaderContext();
			var boxClass:Class = _gameAssets.BoxAsset;
			var playerClass:Class = _gameAssets.PlayerAsset;
			
			loaderContextBox.mapUrlToData("Box001.jpg", new _gameAssets.BoxSkin());
			loaderContextPlayer.mapUrlToData("PLAYER01.JPG", new _gameAssets.PlayerSkin());
			loaderBox.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			loaderPlayer.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			loaderBox.loadData(new boxClass(), loaderContextBox);
			loaderPlayer.loadData(new playerClass(), loaderContextPlayer);
			
		}
		
		private function onAssetComplete(e:AssetEvent):void {
			trace("onAssetComplete");
			_loadedAssets[e.assetPrevName] = e.asset;
			
			dispatchEvent(e);
		}
		
		public function getGameObjectByID(id:String):* {
			return AssetLibrary.getAsset(id);
			//return _loadedAssets[id];
		}
		
		public function getGameObjectsByType(type:String):IGameObject {
			return null;
		}
	
	}

}
package com.n2.apps.catalyst.model {
	import com.n2.apps.catalyst.events.AssetLoaderEvent;
	import com.n2.apps.catalyst.model.interfaces.ICameraControl;
	import com.n2.apps.catalyst.model.interfaces.ICatalystConfig;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import com.n2.apps.catalyst.model.interfaces.IGameAssetsLibrary;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.interfaces.IGameObjectsLibrary;
	import com.n2.apps.catalyst.model.services.library.GameAssetsLibrary;
	import com.n2.common.games.levels.LevelModel;
	import com.n2.components.scene.interfaces.ISceneModel;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystModel extends Actor implements IGameCatalystModel, ICatalystService {
		[Inject]
		public var _gameAssetsLibrary:IGameAssetsLibrary;
		[Inject]
		public var _gameObjectsLibrary:IGameObjectsLibrary;
		[Inject]
		public var _scene:ISceneModel;
		[Inject]
		public var _cameraControlModel:ICameraControl;
		[Inject]
		public var _catalystConfig:ICatalystConfig;
		
		private var _gameDescriptor:ICatalystConfig;
		private var _level:Vector.<LevelModel>;
		private var _currentLevel:LevelModel;
		
		public function GameCatalystModel(){
		}
		
		private function mapEvents():void {
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystService */
		
		public function initialize():void {
			mapEvents();
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.IGameCatalystModel */
		
		public function get scene():ISceneModel {
			return _scene;
		}
		
		public function get gameAssetsLibrary():IGameAssetsLibrary {
			return _gameAssetsLibrary;
		}
		
		public function get gameDescriptor():ICatalystConfig {
			return _gameDescriptor;
		}
		
		public function get cameraControlModel():ICameraControl {
			return _cameraControlModel;
		}
		
		public function get catalystConfig():ICatalystConfig {
			return _catalystConfig;
		}
		
		public function get gameObjectsLibrary():IGameObjectsLibrary {
			return _gameObjectsLibrary;
		}
	}

}
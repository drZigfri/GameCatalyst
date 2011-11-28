package com.n2.apps.gc.model {
	import com.n2.apps.gc.model.services.library.GameObjectsLibrary;
	import com.n2.common.games.levels.LevelModel;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystModel extends Actor {
		[Inject]
		public var _gameObjectsLibrary:GameObjectsLibrary;
		
		private var _gameAssetsConfig:Object;
		private var _level:Vector.<LevelModel>;
		private var _currentLevel:LevelModel;
		
		public function GameCatalystModel(){
		}
		
		public function get gameObjectsLibrary():GameObjectsLibrary {
			return _gameObjectsLibrary;
		}
		
		public function get gameAssetsConfig():Object {
			return _gameAssetsConfig;
		}
		
		public function set gameAssetsConfig(value:Object):void {
			_gameAssetsConfig = value;
		}
	}

}
package com.n2.apps.gc.model {
	import com.n2.common.games.levels.LevelModel;
	import com.n2.components.library.GameObjectsLibrary;
	import com.n2.components.library.interfaces.IGameObjectsLibrary;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystModel extends Actor {
		private var _gameObjectsLibrary:GameObjectsLibrary;
		private var _level:Vector.<LevelModel>;
		private var _currentLevel:LevelModel;
		
		public function GameCatalystModel(){
			_gameObjectsLibrary = new GameObjectsLibrary();
		}
		
		public function get gameObjectsLibrary():GameObjectsLibrary {
			return _gameObjectsLibrary;
		}
	}

}
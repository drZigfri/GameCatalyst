package com.n2.common.games.levels {
	import com.n2.common.games.objects.IGameObject;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class LevelModel extends Actor implements ILevel {
		private var _levelObjects : Object;
		private var _enemyObjects : Object;
		private var _onStageObjects : Object;
		
		public function LevelModel() {
			trace("[ eli ] LevelModel");
			_levelObjects = {};
		}
		
		public function getGameObject(value : String) : IGameObject {
			return _levelObjects[value];
		}
		
		public function getOnStageGameObject(value : String) : IGameObject {
			return _onStageObjects[value];
		}
	
	}

}
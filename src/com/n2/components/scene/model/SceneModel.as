package com.n2.components.scene.model {
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneModel extends Actor {
		private var _selectedStageObject:Object;
		
		public function SceneModel(){
		}
		
		public function get selectedStageObject():Object {
			return _selectedStageObject;
		}
		
		public function set selectedStageObject(value:Object):void {
			_selectedStageObject = value;
		}
	
	}

}
package com.n2.components.scene.model {
	import away3d.containers.ObjectContainer3D;
	import fl.data.DataProvider;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class SceneModel extends Actor {
		private var _selectedStageObject:Object;
		private var _stageObjects:DataProvider;
		
		public function SceneModel() {
			_stageObjects = new DataProvider();
		}
		
		public function get selectedStageObject():Object {
			return _selectedStageObject;
		}
		
		public function set selectedStageObject(value:Object):void {
			_selectedStageObject = value;
		}
		
		public function get stageObjects():DataProvider {
			return _stageObjects;
		}
	
	}

}
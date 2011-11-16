package com.n2.apps.gc.view {
	import com.n2.components.omp.ObjectsManipulationPanel;
	import com.n2.components.scene.SceneView;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystView extends Sprite {
		[Inject]
		private var _objectManipulationPanel:ObjectsManipulationPanel;
		[Inject]
		private var _sceneView:SceneView;
		
		public function GameCatalystView(){
			_objectManipulationPanel = new ObjectsManipulationPanel();
			_sceneView = new SceneView();
		}
		
		public function initialize():void {
			//Set components positions
			_objectManipulationPanel.x = 5;
			_objectManipulationPanel.y = 5;
			_sceneView.x = 310;
			_sceneView.y = 5;
			
			addChild(_objectManipulationPanel);
			addChild(_sceneView);
		}
	
	}

}
package com.n2.apps.gc {
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.GameCatalystContext;
	import com.n2.apps.gc.view.GameCatalystView;
	import com.n2.components.scene.SceneView;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalyst extends Sprite {
		private var _gameCatalystContext:GameCatalystContext;
		
		public function GameCatalyst(){
			_gameCatalystContext = new GameCatalystContext(this);
		}
		
		public function initializeView():void {
			var gcview:GameCatalystView;
			
			setupStage();
			
			//Create application view
			gcview  = new GameCatalystView();
			
			//Set view coordinates
			gcview.x = 0;
			gcview.y = 0;
			
			gcview.initialize();
			
			//Add application to context view
			this.addChild(gcview);
		}
		
		private function setupStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	
	}

}
package com.n2.apps.gc {
	import alternativa.gui.alternativagui;
	import alternativa.gui.layout.DefaultLayoutManager;
	import alternativa.gui.layout.LayoutManager;
	import alternativa.gui.mouse.MouseManager;
	import alternativa.gui.theme.defaulttheme.init.DefaultTheme;
	import alternativa.gui.theme.defaulttheme.primitives.base.Hint;
	import alternativa.init.GUI;
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.GameCatalystContext;
	import com.n2.apps.gc.view.GameCatalystView;
	import com.n2.components.scene.SceneView;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	use namespace alternativagui;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalyst extends Sprite {
		private var _gameCatalystContext:GameCatalystContext;
		private var _objectContainer:Sprite;
		private var _hintContainer:Sprite;
		private var _gcview:GameCatalystView;
		
		public function GameCatalyst(){
			_gameCatalystContext = new GameCatalystContext(this);
		}
		
		public function initializeView():void {
			mouseChildren = true;
			mouseEnabled = true;
			useHandCursor = true;
			
            // Container with objects
			_objectContainer = new Sprite();
			_objectContainer.mouseEnabled = false;
			_objectContainer.tabEnabled = false;
			addChild(_objectContainer);
			
            // Hint container
			_hintContainer = new Sprite();
			_hintContainer.mouseEnabled = false;
			_hintContainer.tabEnabled = false;
			addChild(_hintContainer);
			
            // AlternativaGUIDefaultTheme initialization
			DefaultTheme.init();
			
            // AlternativaGUI initialization
			GUI.init(stage, _hintContainer);
			
            // LayoutManager initialization
			LayoutManager.init(stage, [_objectContainer, _hintContainer], (new DefaultLayoutManager()));
			
            // Add hint class to the MouseManager
			MouseManager.setHintImaging(new Hint());
			
            // CursorManager initialization. Pass the array of custom cursors
			//CursorManager.init(createCursors());
			
			setupStage();
			
			//Create application view
			_gcview = new GameCatalystView();
			
			//Set view coordinates
			_gcview.x = 0;
			_gcview.y = 0;
			
			_gcview.initialize();
			
			//Add application to context view
			_objectContainer.addChild(_gcview);
		}
		
		private function setupStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	
	}

}
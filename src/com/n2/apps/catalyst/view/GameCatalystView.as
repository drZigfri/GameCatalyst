package com.n2.apps.catalyst.view {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.layout.DefaultLayoutManager;
	import alternativa.gui.layout.LayoutManager;
	import alternativa.gui.mouse.MouseManager;
	import alternativa.gui.theme.defaulttheme.init.DefaultTheme;
	import alternativa.gui.theme.defaulttheme.primitives.base.Hint;
	import alternativa.init.GUI;
	import com.n2.apps.catalyst.view.gcmenu.GameCatalystMenuView;
	import com.n2.apps.catalyst.events.ContextEventGC;
	import com.n2.components.scene.SceneView;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystView extends GUIobject {
		[Inject]
		public var sceneView:SceneView;
		
		private var _gameMenu:GameCatalystMenuView;
		private var _componentContainer:Sprite;
		
		public function GameCatalystView(){
			mouseChildren = true;
			mouseEnabled = true;
		}
		
		public function initialize():void {
			//Instantiate views
			sceneView = new SceneView();
			_componentContainer = new Sprite();
			_gameMenu = new GameCatalystMenuView();
			
			//Set components positions
			_componentContainer.x = 0;
			_componentContainer.y = 35;
			sceneView.x = 5;
			sceneView.y = 50;
			
			addChild(sceneView);
			addChild(_componentContainer);
			addChild(_gameMenu);
		}
		
		public function get componentContainer():Sprite {
			return _componentContainer;
		}
	
	}

}
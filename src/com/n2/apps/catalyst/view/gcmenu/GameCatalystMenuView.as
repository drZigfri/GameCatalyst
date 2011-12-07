package com.n2.apps.catalyst.view.gcmenu {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.DropDownMenuEvent;
	import alternativa.gui.theme.defaulttheme.controls.dropDownMenu.DropDownMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystMenuView extends GUIobject {
		private var _gameMenuDropDown:DropDownMenu;
		private var objectContainer:Sprite;
		private var hintContainer:Sprite;
		
		public function initializeMenu(dp:DataProvider):void {
			_gameMenuDropDown = new DropDownMenu();
			_gameMenuDropDown.dataProvider = new DataProvider();
			_gameMenuDropDown.dataProvider = dp;
			
			_gameMenuDropDown.width = 1000;
			_gameMenuDropDown.padding = 2;
			
			addChild(_gameMenuDropDown);
		}
		
		public function get gameMenuDropDown():DropDownMenu {
			return _gameMenuDropDown;
		}
	}

}
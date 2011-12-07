package com.n2.components.gol {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.linear.VBox;
	import alternativa.gui.container.tabPanel.TabData;
	import alternativa.gui.controls.button.BaseButton;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.container.panel.Panel;
	import alternativa.gui.theme.defaulttheme.container.tabPanel.TabButton;
	import alternativa.gui.theme.defaulttheme.container.tabPanel.TabPanel;
	import alternativa.gui.theme.defaulttheme.event.PanelEvent;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectsLibraryView extends GUIobject {
		private var _panel:Panel;
		private var _tabPanel:TabPanel;
		private var _content:VBox;
		
		public function GameObjectsLibraryView(){
		
		}
		
		/**
		 * Initializes view
		 */
		public function initializePanel(model:IGameCatalystModel):void {
			_panel = new Panel();
			_tabPanel = new TabPanel();
			_content = new VBox(10);
			
			//Setup panel
			_panel.title = "Game objects library"
			_panel.closeButtonShow = true;
			_panel.padding = 5;
			_panel.width = 250;
			_panel.height = 60;
			
			//Setup tabs data
			var gameObjectsDefinitions:Object = model.catalystConfig.gameObjectsConfig;
			var godIDs:Array = new Array();
			
			if (gameObjectsDefinitions != null){
				for (var s:String in gameObjectsDefinitions) {
					godIDs.push(s);
				}
			}
			
			for (var i:int = 0; i < godIDs.length; i++){
				var tabButton:TabButton = new TabButton();
				var tabVBox:VBox = new VBox(8);
				tabButton.label = godIDs[i];
				
				_tabPanel.addTab(new TabData(tabButton, tabVBox));
				
			}
			//Setup listeners
			_panel.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			_panel.addEventListener(MouseEvent.MOUSE_DOWN, panelMouseDownHandler);
			_panel.addEventListener(PanelEvent.CLOSE, closePanelHandler);
			
			//Put objects to stage
			//_content.align = Align.LEFT;
			_panel.content = _tabPanel;
			
			addChild(_panel);
		}
		
		/* Panel events handling BEGIN */
		private function panelMouseDownHandler(e:MouseEvent):void {
			//Sets panel on top most level
			this.parent.swapChildren(this.parent.getChildAt(this.parent.numChildren - 1), this);
			
			if (e.currentTarget == _panel && !(e.target is BaseButton || e.target is TextField)){
				_panel.startDrag();
			}
		}
		
		private function panelMouseUpHandler(e:MouseEvent):void {
			_panel.stopDrag();
		}
		
		private function closePanelHandler(e:PanelEvent):void {
			parent.removeChild(this);
		}
	/* Panel events handling END*/
	}

}
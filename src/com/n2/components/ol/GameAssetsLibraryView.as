package com.n2.components.ol {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.theme.defaulttheme.container.panel.Panel;
	import alternativa.gui.theme.defaulttheme.event.PanelEvent;
	import com.n2.components.omp.view.osl.ObjectSelectionPanel;
	import fl.controls.BaseButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameAssetsLibraryView extends GUIobject {
		private var _panel:Panel;
		private var _objectSelectionPanel:ObjectSelectionPanel;
		
		public function GameAssetsLibraryView(){
			initializePanel();
		}
		
		public function initializePanel():void {
			_objectSelectionPanel = new ObjectSelectionPanel();
			_panel = new Panel();
			_panel.title = "Assets library"
			_panel.closeButtonShow = true;
			_panel.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			_panel.addEventListener(MouseEvent.MOUSE_DOWN, panelMouseDownHandler);
			_panel.addEventListener(PanelEvent.CLOSE, closePanelHandler);
			
			addChild(_panel);
			_panel.content = _objectSelectionPanel;
		}
		
		private function panelMouseDownHandler(e:MouseEvent):void {
			//Put infornt
			this.parent.swapChildren(this.parent.getChildAt(this.parent.numChildren - 1), this);
			
			if (e.currentTarget == _panel && !(e.target is BaseButton)) {
				_panel.startDrag();
			}
		}
		
		private function panelMouseUpHandler(e:MouseEvent):void {
			_panel.stopDrag();
		}
		
		private function closePanelHandler(e:PanelEvent):void {
			parent.removeChild(this);
		}
		
		public function get objectSelectionPanel():ObjectSelectionPanel {
			return _objectSelectionPanel;
		}
	
	}

}
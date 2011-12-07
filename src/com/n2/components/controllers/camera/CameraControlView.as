package com.n2.components.controllers.camera {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.linear.VBox;
	import alternativa.gui.controls.button.BaseButton;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.container.panel.Panel;
	import alternativa.gui.theme.defaulttheme.container.tabPanel.TabPanel;
	import alternativa.gui.theme.defaulttheme.controls.buttons.CheckBox;
	import alternativa.gui.theme.defaulttheme.controls.slider.Slider;
	import alternativa.gui.theme.defaulttheme.event.PanelEvent;
	import com.n2.apps.catalyst.model.interfaces.ICameraControl;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class CameraControlView extends GUIobject {
		private var _panel:Panel;
		private var _tabPanel:TabPanel;
		private var _content:VBox;
		private var _btnLockOn:CheckBox;
		private var _sldDistance:Slider;
		
		public function CameraControlView(){
		}
		
		/**
		 * Initializes view
		 */
		public function initializePanel(model:IGameCatalystModel):void {
			_panel = new Panel();
			_tabPanel = new TabPanel();
			_content = new VBox(2);
			
			//Create panel objects
			_btnLockOn = new CheckBox();
			_sldDistance = new Slider(40, model.cameraControlModel.distanceFromObject/100, 1);
			_sldDistance.width = 200;
			
			_btnLockOn.label = "Lock on object";
			_btnLockOn.checked = model.cameraControlModel.lockOnObject;
			
			//Setup panel
			_panel.title = "Camera controls"
			_panel.closeButtonShow = true;
			_panel.padding = 5;
			_panel.width = 200;
			_panel.height = 60;
			
			//Put objects to stage
			_content.align = Align.LEFT;
			_content.addChild(_sldDistance);
			_content.addChild(_btnLockOn);
			_panel.content = _content;
			
			//Setup listeners
			_panel.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			_panel.addEventListener(MouseEvent.MOUSE_DOWN, panelMouseDownHandler);
			_panel.addEventListener(PanelEvent.CLOSE, closePanelHandler);
			
			addChild(_panel);
		}
		
		/**
		 * Updates panel parameters
		 */
		public function updatePanelControls(model:IGameCatalystModel):void {
			//TODO: Handle update controls
			_sldDistance.currentPos = model.cameraControlModel.distanceFromObject;
			_btnLockOn.checked = model.cameraControlModel.lockOnObject;
		}
		
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
		
		public function get sldDistance():Slider {
			return _sldDistance;
		}
		
		public function get btnLockOn():CheckBox {
			return _btnLockOn;
		}
	
	}

}
package com.n2.components.gop {
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.theme.defaulttheme.container.panel.Panel;
	import alternativa.gui.theme.defaulttheme.event.PanelEvent;
	import away3d.containers.ObjectContainer3D;
	import com.n2.components.omp.view.ocp.ObjectControlPanel;
	import fl.controls.BaseButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectPropertiesView extends GUIobject {
		private var _panel:Panel;
		private var _objectControlPanel:ObjectControlPanel;
		
		public function GameObjectPropertiesView(){
			initializePanel();
		}
		/**
		 * Initializes view
		 */
		public function initializePanel():void {
			_objectControlPanel = new ObjectControlPanel();
			_panel = new Panel();
			_panel.title = "Object properties"
			_panel.closeButtonShow = true;
			_panel.padding = 5;
			_panel.addEventListener(MouseEvent.MOUSE_UP, panelMouseUpHandler);
			_panel.addEventListener(MouseEvent.MOUSE_DOWN, panelMouseDownHandler);
			_panel.addEventListener(PanelEvent.CLOSE, closePanelHandler);
			
			_panel.content = _objectControlPanel;
			addChild(_panel);
		}
		/**
		 * Updates panel parameters
		 * @param	object - Container object 
		 */
		public function updatePanelControls(object:ObjectContainer3D):void {
			_objectControlPanel.x_Position_Input.text = String(object.x);
			_objectControlPanel.y_Position_Input.text = String(object.y);
			_objectControlPanel.z_Position_Input.text = String(object.z);
			_objectControlPanel.x_Rotation_Input.text = String(object.rotationX);
			_objectControlPanel.y_Rotation_Input.text = String(object.rotationY);
			_objectControlPanel.z_Rotation_Input.text = String(object.rotationZ);
			_objectControlPanel.x_Scale_Input.text = String(object.scaleX);
			_objectControlPanel.y_Scale_Input.text = String(object.scaleY);
			_objectControlPanel.z_Scale_Input.text = String(object.scaleZ);
			_objectControlPanel.x_Rotation_Slider.value = object.rotationX;
			_objectControlPanel.y_Rotation_Slider.value = object.rotationY;
			_objectControlPanel.z_Rotation_Slider.value = object.rotationZ;
			_objectControlPanel.x_Scale_Slider.value = object.scaleX;
			_objectControlPanel.y_Scale_Slider.value = object.scaleY;
			_objectControlPanel.z_Scale_Slider.value = object.scaleZ;
		}
		
		private function panelMouseDownHandler(e:MouseEvent):void {
			//Sets panel on top most level
			this.parent.swapChildren(this.parent.getChildAt(this.parent.numChildren - 1), this);
			
			if (e.currentTarget == _panel && !(e.target is BaseButton || e.target is TextField)) {
				_panel.startDrag();
			}
		}
		
		private function panelMouseUpHandler(e:MouseEvent):void {
			_panel.stopDrag();
		}
		
		private function closePanelHandler(e:PanelEvent):void {
			parent.removeChild(this);
		}
		/**
		 * Returns object control panel representation
		 */
		public function get objectControlPanel():ObjectControlPanel {
			return _objectControlPanel;
		}
	}

}
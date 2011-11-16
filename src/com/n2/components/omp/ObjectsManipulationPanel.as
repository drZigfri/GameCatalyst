package com.n2.components.omp {
	import com.n2.components.omp.view.ocp.ObjectControlPanel;
	import com.n2.components.omp.view.OMPViewBackground;
	import com.n2.components.omp.view.osl.ObjectSelectionPanel;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ObjectsManipulationPanel extends Sprite {
		[Inject]
		public var _controlPanel:ObjectControlPanel;
		[Inject]
		public var _selectionPanel:ObjectSelectionPanel;
		
		public function ObjectsManipulationPanel() {
			var background:OMPViewBackground = new OMPViewBackground();
			_controlPanel = new ObjectControlPanel();
			_selectionPanel = new ObjectSelectionPanel();
			
			//Set panel coordinates
			_controlPanel.x = 5;
			_controlPanel.y = 5;
			_selectionPanel.x = 5;
			_selectionPanel.y = 170;
			
			//Set sizes
			background.height = 480;
			
			addChild(background);
			addChild(_controlPanel);
			addChild(_selectionPanel);
		}
	
	}

}
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
		public var controlPanel:ObjectControlPanel;
		[Inject]
		public var selectionPanel:ObjectSelectionPanel;
		
		public function ObjectsManipulationPanel() {
			var background:OMPViewBackground = new OMPViewBackground();
			controlPanel = new ObjectControlPanel();
			selectionPanel = new ObjectSelectionPanel();
			
			//Set panel coordinates
			controlPanel.x = 5;
			controlPanel.y = 5;
			selectionPanel.x = 5;
			selectionPanel.y = 170;
			
			//Set sizes
			background.height = 480;
			
			addChild(background);
			addChild(controlPanel);
			addChild(selectionPanel);
		}
	
	}

}